GWAS Tutorial


> https://cloufield.github.io/GWASTutorial/

```
git clone https://github.com/Cloufield/GWASTutorial.git
```

#####################     https://cloufield.github.io/GWASTutorial/04_Data_QC/#allele-frequency
# # s1  Calculate missing rate

cd /BIGDATA2/gzfezx_shhli_2/USER/luozhenyu/script/GWASself/01_Dataset

genotypeFile="1KG.EAS.auto.snp.norm.nodup.split.rare002.common015.missing" 
#!!! Please add your own path here.  "1KG.EAS.auto.snp.norm.nodup.split.rare002.common015.missing" is the prefix of PLINK bed file. 

plink \
    --bfile ${genotypeFile} \
    --missing \
    --out plink_results

#### res 
# This code will generate two files plink_results.imiss and plink_results.lmiss, 
# which contain the missing rate information for samples and SNPs respectively.

# Take a look at the .imiss file. The last column shows the missing rate for samples. 
# Since we used part of the 1000 Genome Project data this time, 
# there are no missing SNPs in the original datasets. But for educational purposes, we randomly make some of the genotypes missing.

########  s2 Calculate the MAF of variants using PLINK1.9
plink2 \
        --bfile ${genotypeFile} \
        --freq \
        --out plink_results

# Calculate inbreeding F coefficient

plink \
    --bfile ${genotypeFile} \
    --extract plink_results.prune.in \
    --het \
    --out plink_results

# Create sample list of individuals with extreme F using awk

# only one sample
awk 'NR>1 && $6>0.1 || $6<-0.1 {print $1,$2}' plink_results.het > high_het.sample

#########  sample QC finally
# Apply all the filters to obtain a clean dataset
# We can then apply the filters and remove samples with high  to get a clean dataset for later use.


plink \
        --bfile ${genotypeFile} \
        --maf 0.01 \
        --geno 0.02 \
        --mind 0.02 \
        --hwe 1e-6 \
        --remove high_het.sample \
        --keep-allele-order \
        --make-bed \
        --out sample_data.clean














































































