#######################   S1. follow 1 ########################################

# ref:https://mp.weixin.qq.com/s?__biz=MzkzNTQzMDY2OA==&mid=2247487732&idx=1&sn=ffdefd6860f9c3231c7f0f4b5d8fb3fb&chksm=c2af4f97f5d8c681bd2abb3aa1e9dc4a6aad1881648fec895245923dddd4de7a97e001a61480&cur_album_id=2853023349386526726&scene=189#wechat_redirect
## 1, 安装TwoSampleMR，如果已安装，可以忽略

# library(remotes)
# install_github("MRCIEU/TwoSampleMR")

setwd('D:\\01_study\\001_md\\bioinformation')
## 2， 载入TwoSampleMR包
library(TwoSampleMR)


# https://api.opengwas.io/profile/  生成token
Sys.setenv(OPENGWAS_JWT="eyJhbGciOiJSUzI1NiIsImtpZCI6ImFwaS1qd3QiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhcGkub3Blbmd3YXMuaW8iLCJhdWQiOiJhcGkub3Blbmd3YXMuaW8iLCJzdWIiOiIxMDE4OTU0MDg3QHFxLmNvbSIsImlhdCI6MTc1ODY3NzI4OSwiZXhwIjoxNzU5ODg2ODg5fQ.ne6KD2_-kH-Zy70_6_l9N-GjqMKKZ1ytX4YE12CeR4Dq8sMFFCxP3c_6oyU1-2ToJzwNws_zh0up0_IPb2EwuH2YMo3f2YonefdlrH3Nd_KHIFSjxcFWs62hl9LDGdSf0LjZYhbsgvE7EHgT09fX3o6FWyvpPeJFYhqCeRTZvnrMpA37QvPUI84AnlHedGh0IEptgLLRPEPEt4x_MK8zIDLnfAKomI7E_Yi2wksTEAiOdB6hXkMf_katWjKt0qvB23Stj7l2iI21leMMpg3xxH0KtlDYXYGYslY7XS9qGxeE4zvSS07ZgJYUhCnRirZsGGjNQjA5e_bBK99j0GQHvg") 

## 3，从数据库中提取暴露的GWAS summary数据

# 暴露因素
# Body mass index         ieu-a-2
# Hypertension            finn-b-I9_HYPTENS
exposure_data <- mv_extract_exposures(c("ieu-a-2", "finn-b-I9_HYPTENS"),
                                      pval_threshold = 1e-10,
                                      # 有了令牌，运行的优先级相对较高，加了这一项不容易超时报错
                                      opengwas_jwt = ieugwasr::get_opengwas_jwt())



dim(exposure_data)
# 结局因素
# Coronary heart disease ieu-a-7
outcome_data <- extract_outcome_data(exposure_data$SNP,
                                     "ieu-a-7")
dim(outcome_data)
# 效应等位与效应量保持统一
mvdata <- mv_harmonise_data(exposure_data,
                            outcome_data,
                            harmonise_strictness = 2)
#进行MVMR的分析 （IVW）
res <- mv_multiple(mvdata)
result_table <- res$result
result_or <- generate_odds_ratios(result_table)

# remotes::install_github("WSpiller/MVMR")
library(MVMR)
# 也可以使用 MVMR 进行操作，使用到工具变量与结局数据的效应值（β）矩阵以及标准误：
F.data <- format_mvmr(BXGs = mvdata[["exposure_beta"]],
                      BYG = mvdata[["outcome_beta"]],
                      seBXGs = mvdata[["exposure_se"]],
                      seBYG = mvdata[["outcome_se"]],
                      RSID = rownames(mvdata[["exposure_beta"]]))

# IVW 因果效应估计
ivw_mvmr_res <- ivw_mvmr(F.data)

# 计算F值
F_z <- strength_mvmr(r_input = F.data, gencov = 0)

# 异质性检验
pres <- pleiotropy_mvmr(r_input = F.data, gencov = 0)
pres

# 结果与 TwoSampleMR 得到的差不多，F-statistic > 10 表明工具变量足够强，
# 需要注意的是水平多效性的检验结果。
# 通过 Cochran's Q 统计量 检测 SNP 是否存在非暴露途径的效应发现
# ，我们的结果有很明显的水平多效性，表明部分 SNP 可能通过非暴露路径影响结局。

# 使用R包 MRPRESSO 的 mr_presso 函数，
# 能够判断出数据是否存在显著水平多效性，以及若是存在，哪些工具变量导致了这个多效性。

# 创建整合数据框
presso_data <- data.frame(
  HTN_beta = mvdata[["exposure_beta"]][, "finn-b-I9_HYPTENS"],
  HTN_se = mvdata[["exposure_se"]][, "finn-b-I9_HYPTENS"],
  BMI_beta = mvdata[["exposure_beta"]][, "ieu-a-2"],
  BMI_se = mvdata[["exposure_se"]][, "ieu-a-2"],
  CHD_beta = mvdata[["outcome_beta"]],
  CHD_se = mvdata[["outcome_se"]]
)

# 使用 remotes 或 devtools 包从 GitHub 安装 MR-PRESSO，并强制重新安装
# remotes::install_github("rondolab/MR-PRESSO", force = TRUE)
library("MRPRESSO")
mr_presso_result <- mr_presso(
  BetaOutcome = "CHD_beta", 
  BetaExposure = c("HTN_beta", "BMI_beta"),
  SdOutcome = "CHD_se", 
  SdExposure = c("HTN_se", "BMI_se"),
  OUTLIERtest = TRUE,
  DISTORTIONtest = TRUE,
  data = presso_data,
  NbDistribution = 10000,
  SignifThreshold = 0.01
)
mr_presso_result[['Main MR results']]

mr_presso_result[["MR-PREsso results"]][['Global Test']]

mr_presso_result[['MR-PREsso results']][['Distortion Test']]
# 结果表明，数据的全局检验显著，但是没有找到异常SNP，
# 这预示着数据多效性可能是由多个SNP的微弱效应叠加导致，非少数强异常值驱动。


# 这里尝试使用其他方法进行分析，看一下有无差别，
# R包 MendelianRandomization 除了使用 IVW 外，也可进行 Egger 等方法：

MRMVInputObject <- mr_mvinput(bx = mvdata[["exposure_beta"]],
                              bxse = mvdata[["exposure_se"]],
                              by = mvdata[["outcome_beta"]],
                              byse = mvdata[["outcome_se"]],
                              snps = rownames(mvdata[["exposure_beta"]]))


mr_mvegger <- mr_mvegger(MRMVInputObject, orientate = 1)

mv_median <- mr_mvmedian(MRMVInputObject)

mv_lasso <- mr_mvlasso(MRMVInputObject, lambda = 0.1, orientate = 1)

mr_mvegger

mv_median

mv_lasso

# 所有方法的结果大致相近，能够得到的结论如下：
# 
# 高血压是冠心病明确且稳健的因果风险因素，效应独立于BMI；
# 多效性存在，但多种MVMR结果收敛，说明核心因果效应还是具有稳健性的。可以认为BMI对冠心病有因果效应，但也不能完全忽视混杂干扰，需要谨慎解读结果；
# 后续可通过2SMR、中介MR等量化生物学通路，或者尝试寻找经验工具变量，去解决多效性的问题。


#######################   S2. follow 2 ########################################

setwd('D:\\01_study\\001_md\\bioinformation')
## 2， 载入TwoSampleMR包
library(TwoSampleMR)


# https://api.opengwas.io/profile/  生成token
Sys.setenv(OPENGWAS_JWT="eyJhbGciOiJSUzI1NiIsImtpZCI6ImFwaS1qd3QiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhcGkub3Blbmd3YXMuaW8iLCJhdWQiOiJhcGkub3Blbmd3YXMuaW8iLCJzdWIiOiIxMDE4OTU0MDg3QHFxLmNvbSIsImlhdCI6MTc1ODY3NzI4OSwiZXhwIjoxNzU5ODg2ODg5fQ.ne6KD2_-kH-Zy70_6_l9N-GjqMKKZ1ytX4YE12CeR4Dq8sMFFCxP3c_6oyU1-2ToJzwNws_zh0up0_IPb2EwuH2YMo3f2YonefdlrH3Nd_KHIFSjxcFWs62hl9LDGdSf0LjZYhbsgvE7EHgT09fX3o6FWyvpPeJFYhqCeRTZvnrMpA37QvPUI84AnlHedGh0IEptgLLRPEPEt4x_MK8zIDLnfAKomI7E_Yi2wksTEAiOdB6hXkMf_katWjKt0qvB23Stj7l2iI21leMMpg3xxH0KtlDYXYGYslY7XS9qGxeE4zvSS07ZgJYUhCnRirZsGGjNQjA5e_bBK99j0GQHvg") 

## 3，从数据库中提取暴露的GWAS summary数据

# 暴露因素
# Body mass index         ieu-a-2
# Hypertension            finn-b-I9_HYPTENS
exposure_data <- mv_extract_exposures(c("ieu-a-2", "finn-b-I9_HYPTENS"),
                                      pval_threshold = 1e-10,
                                      # 有了令牌，运行的优先级相对较高，加了这一项不容易超时报错
                                      opengwas_jwt = ieugwasr::get_opengwas_jwt())



dim(exposure_data)
# 结局因素
# Coronary heart disease ieu-a-7
outcome_data <- extract_outcome_data(exposure_data$SNP,
                                     "ieu-a-7")
dim(outcome_data)
# 效应等位与效应量保持统一
dat = harmonise_data(exposure_data, outcome_data)
dim(dat)

# 主分析：计算因果效应估计
res = mr(dat)
# 异质性检验：检查SNP间的效应差异
mr_heterogeneity(dat)
# 多效性检验：检查是否存在水平多效性
mr_pleiotropy_test(dat)
# 留一法分析：评估单个SNP对结果的影响
res_loo = mr_leaveoneout(dat)

# 四种核心图表
mr_scatter_plot(res, dat)      # 散点图
mr_forest_plot(res_single)     # 森林图  
mr_funnel_plot(res_single)     # 漏斗图
mr_leaveoneout_plot(res_loo)   # 留一法图

# 图表解读与意义
# 1. ​散点图 (Scatter Plot)​​
# ​🔍 图表内容​：
# X轴：SNP对暴露（BMI/高血压）的效应大小
# Y轴：SNP对结局（冠心病）的效应大小
# 每条线代表一种MR方法（IVW、MR-Egger等）的拟合结果
# ​🎯 临床意义​：
# ​斜率​：代表因果效应的大小和方向
# ​点分布​：观察点与拟合线的偏离程度，评估多效性
# ​方法比较​：不同方法结果的一致性反映结果的稳健性
# 2. ​森林图 (Forest Plot)​​
# ​🔍 图表内容​：
# 每个SNP单独的因果效应估计及其置信区间
# 底部为合并的总体效应（IVW方法）
# ​🎯 临床意义​：
# ​效应一致性​：各个SNP效应方向是否一致
# ​异质性检测​：SNP间效应大小的变异程度
# ​影响力评估​：识别对总体结果影响较大的SNP
# 3. ​漏斗图 (Funnel Plot)​​
# ​🔍 图表内容​：
# X轴：单个SNP的因果效应估计
# Y轴：SNP效应的精确度（通常为1/标准误）
# ​🎯 临床意义​：
# ​对称性检验​：评估是否存在发表偏倚或小样本效应
# ​异质性可视化​：不对称分布提示存在异质性
# ​方法有效性​：对称的漏斗图表明结果可靠性较高
# 4. ​留一法图 (Leave-one-out Plot)​​
# ​🔍 图表内容​：
# 显示每次剔除一个SNP后剩余的合并效应估计
# 比较剔除前后结果的变化
# ​🎯 临床意义​：
# ​敏感性分析​：评估结果对单个SNP的依赖程度
# ​异常值识别​：剔除某个SNP后结果发生显著变化，提示该SNP可能是异常值
# ​结果稳健性​：所有留一法结果与总体结果一致，表明结论稳健

