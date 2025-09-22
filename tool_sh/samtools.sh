


samtools 提取reads，singleton
samtools fastq -F 3584 -f 77 $i  | gzip -c > $output_dir/${id}_R1.fq.gz
samtools fastq -F 3584 -f 141 $i | gzip -c > $output_dir/${id}_R2.fq.gz
samtools fastq -f 4 -F 1 $i | gzip -c > $output_dir/${id}_Singletons.fq.gz




samtools view -hb -L target.bed wgs.sort.bam > target.region.bam


# Extract the alignments from a Bam file by name of the read
java -jar /BIGDATA2/gzfezx_shhli_2/software/picard.jar FilterSamReads \
       I=00114031182M22BFF2.clip.V.bam \
       O=tmp.bam \
       READ_LIST_FILE=tmp.txt FILTER=includeReadList


http://www.gzcxckedu.cn:8080/registration system/index



bedtools bamtobed -i 00114031182M22BFF2.f4.V.bam | \
bedtools coverage -hist -b -  -a /BIGDATA2/gzfezx_shhli_2/database/viral_refseq/viral.1.1.genomic.bed > sample.1.hist











