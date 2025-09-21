setwd("D:\\01_study\\001_md\\bioinformation")

# 2. TCGA数据导入
# - 导入TCGA数据
survival_file <- read.table('../data/TCGA-CESC.survival.tsv.gz',
                            header = T, sep = '\t',
                            quote = '', check.names = F)

survival_file <- survival_file[grep("-01A",survival_file$sample),]
head(survival_file)


fpkm_file <- read.table('../data/TCGA-CESC.star_fpkm.tsv.gz',
                      header = T, sep = '\t',
                      quote = '', check.names = F)
head(fpkm_file)
survival_file <- survival_file[survival_file$sample %in% colnames(fpkm_file),]
row.names(fpkm_file) <- fpkm_file$Ensembl_ID
fpkm_file <- fpkm_file[,survival_file$sample]


# - 基因ID转换
library(org.Hs.eg.db)
keytypes(org.Hs.eg.db)
head(keys(org.Hs.eg.db,"ENSEMBL"))
fpkm_file$ENSG_id <- row.names(fpkm_file)
head(fpkm_file$ENSG_id)

fpkm_file$ENSG_id <- data.table::tstrsplit(fpkm_file$ENSG_id, "\\.")[[1]]
head(fpkm_file$ENSG_id)

gene_id <- clusterProfiler::bitr(fpkm_file$ENSG_id, OrgDb = org.Hs.eg.db,
                                 fromType="ENSEMBL",toType="SYMBOL")
head(gene_id)

fpkm_file <- merge(gene_id, fpkm_file, by.x="ENSEMBL", by.y="ENSG_id")


# aggregate()  R基础包中的函数，用于对数据进行分组聚合操作
# fpkm_file是原始数据框。-c(1,2)表示移除第一列和第二列，
#   通常这些列可能是基因ID或其他你不希望参与聚合计算的标识列。
# by参数指定分组依据。这里表示按照 fpkm_file数据框中名为 SYMBOL的列（通常存储基因符号）进行分组。
#   list(gene=...)同时为结果中的分组因子列命名。
fpkm_data <- aggregate(fpkm_file[-c(1,2)], 
                        by=list(gene=fpkm_file$SYMBOL),
                        FUN=mean)
row.names(fpkm_data) <- fpkm_data$gene
fpkm_data <- fpkm_data[-1]
fpkm_data[1:5,1:4]

save(fpkm_data, survival_file, file="../output/TCGA_data.RData")

# 3. 生存分析
# 
# - 单因素Cox比例风险回归分析

rm(list=ls())
# load("WGCNA-hubgene.Rdata")
load("../output/TCGA_data.RData")
# 需要安装的包列表
packages <- c("survival", "survminer", "timeROC")

if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")

# 使用循环安装
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) { # 先检查包是否已安装
    install.packages(pkg)
  }
}

hubgene <- read.csv('../data/hub_gene.csv')[,1]
fpkm_data <- t(fpkm_data)
# fpkm_data <- fpkm_data[, colnames(fpkm_data)%in%c(hubgene1,hubgene2)]
fpkm_data <- fpkm_data[, colnames(fpkm_data)%in%c(hubgene)]
fpkm_data <- as.data.frame(fpkm_data)

# 创建生存分析所需的生存对象（Survival Object）​，它结合了 with()函数和 Surv()函数的功能
# Surv(OS.time, OS):
  #   Surv()函数来自 R 的 survival包，是创建生存对象的核心函数​
  # 它通常接受两个主要参数：
  # ​OS.time: 表示生存时间​（Time to event），即从研究开始到某个事件发生或观察结束的时间。这个时间单位可以是天、月、年等
  # ​OS: 表示事件状态​（Event status），是一个指示变量，通常用 1表示我们关注的事件（如死亡、疾病复发）已经发生，用 0表示未发生或观察截止（右删失，right-censored）
mySurv <- with(survival_file, Surv(OS.time, OS))

# 主要用于对表达数据（例如基因表达矩阵）进行批量Cox比例风险回归分析，
# 目的是评估每个基因的表达水平对生存结局（如生存时间）的影响
# 参数 2表示按列操作。
# function(gene){ ... }:
  # 这是一个匿名函数，apply会将 fpkm_data的每一列作为参数 gene传入并执行此函数
  # 每次执行，gene就是当前处理的那个基因在所有样本中的表达量数值向量

# coxph()是R中拟合Cox比例风险模型的函数，来自 survival包
# mySurv应是一个生存对象，通常由 Surv()函数创建，包含了每个样本的生存时间和事件状态​（如是否死亡）
# ~ gene表示建立以 gene（当前基因的表达量）为自变量，以 mySurv（生存结局）为因变量的Cox模型。
allfit <-apply(fpkm_data,2,function(gene){
   res_cox <- coxph(mySurv ~ gene, data=fpkm_data)
 })

options(scipen=200)
allres <- lapply(allfit,function(x){
   x<-summary(x)
   P.value<-round(x$wald["pvalue"], digits=4) #P-value
   wald.test<-round(x$wald["test"], digits=4) #wald.test
   beta<-round(x$coef[1],digits=4) #coef beta
   HR<-round(x$coef[2],digits=4) #exp(coef)
   HR_CI_lower<-round(x$conf.int[,"lower .95"],4)
   HR_CI_upper<-round(x$conf.int[,"upper .95"],4)
   HR<-paste0(HR,"(",HR_CI_lower,"-",HR_CI_upper,")")
   z<-round(x$coef[4],digits=4) #z值，z = coef/se(coef)
   res<-c(beta, HR, z,wald.test, P.value)
   names(res)<-c("beta","HR (95% CI)","z","wald.test","P-value")
   return(res)
 })
allres
results <- t(as.data.frame(allres, check.names = FALSE))
results <- t(as.data.frame(allres, check.names = FALSE))
results <- as.data.frame(results)
results <- results[order(results$`P-value`),]
head(results)


top10 <- row.names(results)[1:10]
top10


# 多因素Cox比例风险回归分析

multi_COX <- coxph(mySurv ~ ., data=fpkm_data[,top10])
multi_COX

# - 逐步回归

step.multi_COX <- step(multi_COX, direction = "both")
step.multi_COX

# - 风险评分计算

RiskScore <- predict(step.multi_COX, type="risk", 
                                           data=fpkm_data[,names(step.multi_COX$coefficients)])
head(RiskScore)

risk_group <- ifelse(RiskScore >= median(RiskScore),'high','low')
head(risk_group)

# - Kaplan-Meier曲线

survival_file$risk_group <- risk_group
fit <- survfit(Surv(OS.time, OS) ~ risk_group, data = survival_file)

ggsurv <- ggsurvplot(
   fit,                     
   data = survival_file,   
   palette = c("orangered", "dodgerblue"),
   legend.labs=c("High", "Low"), legend.title="Risk", 
   ggtheme = theme_classic(),
   risk.table = TRUE,
   conf.int = TRUE,
   pval.int = TRUE,
   break.time.by = 1000,
   xlab = "Time in days",
   risk.table.height = 0.25,
   risk.table.y.text = FALSE,
   risk.table.y.text.col = T,
   #conf.int.style = "step", surv.median.line = "hv"
   )
print(ggsurv)
# ggsave(print(ggsurv), file="../output/surv_km.png", width=5, height=5)


# - ROC曲线
library(timeROC)

time_ROC <- timeROC(
   T=survival_file$OS.time, 
   delta=survival_file$OS, 
   marker=RiskScore,
   cause=1, 
   weighting = "marginal", 
   times = c(3 * 365, 5 * 365, 10 * 365), 
   ROC=TRUE,
   iid=TRUE) #计算AUC
time_ROC

time_ROC.res <- data.frame(TP_3year=time_ROC$TP[,1], #获取3年的ROC的TP
                                                       FP_3year=time_ROC$FP[,1],  #获取3年的ROC的FP
                                                       TP_5year=time_ROC$TP[,2],  #获取5年的ROC的TP
                                                       FP_5year=time_ROC$FP[,2], #获取5年的ROC的FP
                                                       TP_10year=time_ROC$TP[,3], #获取10年的ROC的TP
                                                       FP_10year=time_ROC$FP[,3]) #获取10年的ROC的FP

TimeROC_plot <- ggplot()+
   geom_line(data=time_ROC.res,aes(x=FP_3year,y=TP_3year),size=1,color="#BC3C29")+
   geom_line(data=time_ROC.res,aes(x=FP_5year,y=TP_5year),size=1,color="#0072B5")+
   geom_line(data=time_ROC.res,aes(x=FP_10year,y=TP_10year),size=1,color="#E18727")+
   geom_line(aes(x=c(0,1),y=c(0,1)),color = "grey",size=1, linetype = 2 )+
   theme_bw()+
   annotate("text",x=0.75,y=0.25,size=4.5,
                         label=paste0("AUC at 3 years = ",round(time_ROC$AUC[[1]],3)),color="#BC3C29")+
   annotate("text",x=0.75,y=0.15,size=4.5,
                         label=paste0("AUC at 5 years = ",round(time_ROC$AUC[[2]],3)),color="#0072B5")+
   annotate("text",x=0.75,y=0.05,size=4.5,
                         label=paste0("AUC at 10 years = ",round(time_ROC$AUC[[3]],3)),color="#E18727")+
   labs(x="False positive rate",y="True positive rate")+
   theme(axis.text=element_text(face="bold", size=11,  color="black"),
                   axis.title=element_text(face="bold", size=14, color="black"))

TimeROC_plot
ggsave(print(TimeROC_plot), file="../plot/TimeROC_plot.png", width=5, height=4)



