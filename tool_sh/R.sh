

# 去除某列中的特定字符
pca.data$sample<-gsub('[X]', '', pca.data$sample)



merge(x,  y,  by,  by.x,  by.y, all,  all.x,  all.y...)


# melt
data<- melt(df1,id.vars=c('name'),
            variable.name=c("Sample"),value.name="value")

# 数据因子化
df4$paired<- factor(df4$paired, c(),
                    ordered = TRUE)


## 先卸载先前的安装控制程序
remove.packages(c("BiocInstaller", "BiocManager", "BiocVersion"))
 
## 再安装新版程序
install.packages("BiocManager")
BiocManager::install(update=TRUE, ask=FALSE)

# 使用旧软件包
BiocManager::install(version="3.8")  ## 当前BioC版本为 3.9

conda install r-base=4.3.3


#安装1：
BiocManager::install("GenomicFeatures",dependencies=TRUE, INSTALL_opts = c('--no-lock'))

#安装2：
install.packages("GenomicFeatures", dependencies=TRUE, INSTALL_opts = c('--no-lock'))

library(BiocManager)
library(AnnotationDbi)
library(GenomicFeatrues)
library(ChIPseeker)

setwd('E:\\index\\viral_ref/')
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
library(BiocManager)
BiocManager::install(c("GenomicFeatures", "AnnotationDbi"))
library(GenomicFeatrues)
BiocManager::install(c("GenomicFeatures", "AnnotationDbi"))
spombe <- makeTxDbFromGFF("test.gff3")
#从ucsc中下载，但是我没跑通
hg19.refseq.db <- makeTxDbFromUCSC(genome="hg19", table="refGene")

remove.packages('BiocManager', lib ='C:/Users/Administrator/AppData/Local/R/win-library/4.3')
install.packages("BiocManager",lib="C:/Program Files/R/R-4.3.2/library")
BiocManager::install(update=TRUE, ask=FALSE)
BiocManager::install(version="3.8") 
BiocManager::install(version = "3.18")
BiocManager::install('GenomicFeatures',force = TRUE,lib ='C:/Users/Administrator/AppData/Local/R/win-library/4.3')
install.packages('ChIPseeker')
.libPaths()
.libPaths("C:/Users/Administrator/AppData/Local/Temp/Rtmp0mlY9l/downloaded_packages")

file.edit('~/.Rprofile') 


BiocManager::install('GenomicFeatures')

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
install.packages("BiocManager")
BiocManager::install(c('AnnotationDbi',  
                       'org.Hs.eg.db', 'GenomicFeatures', 
                       'GenomicRanges', 'IRanges'))

BiocManager::install('ChIPseeker', dependencies=TRUE, INSTALL_opts = c('--no-lock'))


BiocManager::install(c("AnnotationDbi","GenomicFeatures","ChIPseeker"), dependencies=TRUE, INSTALL_opts = c('--no-lock'))


BiocManager::install(c("GenomicFeatures","ChIPseeker"), dependencies=TRUE, INSTALL_opts = c('--no-lock'))


install.packages("devtools", dependencies=TRUE)
devtools::install_github("YuLab-SMU/ChIPseeker")


### R <3.6
> source("http://bioconductor.org/biocLite.R")
> biocLite("ChIPseeker")
> library("graph")


#############  R 画图
https://mp.weixin.qq.com/s/Zth_bSu1tskE013vXPWfwQ


.libPaths(c("/BIGDATA2/gzfezx_shhli_2/miniconda3/envs/manta/lib/R/library"))

installed.packages()

installed.packages(c("","")




安装R包时报错：Error in if (nzchar(SHLIB_LIBADD)) SHLIB_LIBADD else character() :

ll `find /BIGDATA2/gzfezx_shhli_2/miniconda3  -name Makeconf`


###########  fatal error: fribidi.h: No such file or directory

export C_INCLUDE_PATH=/home/lzy/miniconda3/include/freetype2:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/lzy/miniconda3/include/freetype2:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=/home/lzyminiconda3/lib/python3.11/config-3.11-x86_64-linux-gnu:$LIBRARY_PATH


export C_INCLUDE_PATH=/home/lzy/miniconda3/include/fribidi:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/lzy/miniconda3/include/fribidi:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=/home/lzyminiconda3/lib/python3.11/config-3.11-x86_64-linux-gnu:$LIBRARY_PATH


