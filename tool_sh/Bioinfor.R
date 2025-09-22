
将Ensemble ID转换成Symbol

exp <- exp %>% rownames_to_column("gene_id")
name <- bitr(exp$gene_id,fromType = 'ENSEMBL',toType = "SYMBOL",OrgDb = 'org.Hs.eg.db')
exp2 <- right_join(name,exp,by=c("ENSEMBL"="gene_id"))
exp2 <- exp2[,-1]
exp3 <- exp2[!duplicated(exp2$SYMBOL),]
exp <- na.omit(exp3) 
rownames(exp) <- exp$SYMBOL
write_tsv(exp,"GSE196921.txt")















