current path :
~/work_path/01_stLFR/14_new_pcrfree_stlfr_bwa/G400_ECR6_stLFR-17/stLFR_Analysis/01_sub_bam
~/work_path/01_stLFR/14_new_pcrfree_stlfr_ema/G400_ECR6_stLFR-1
~/work_path/01_stLFR/14_new_pcrfree_stlfr_lariat/G400_ECR6_stLFR-1
~/work_path/01_stLFR/14_new_pcrfree_stlfr_bcmap/G400_ECR6_stLFR-1
~/work_path/01_stLFR/V300045667C-ESR20/stLFR_Analysis/01_sub_bam

~/work_path/01_stLFR/14_new_pcrfree_stlfr_bwa/data/L01/test/03_10x_2_bcmap

~/work_path/01_stLFR/14_new_pcrfree_stlfr_combine/03_phasing/02_pcrfree_20x

04.04 
/research/rv-02/home/zhenyuluo/01_stLFR/14_new_pcrfree_stlfr_bwa/G400_ECR6_stLFR-1/stLFR_Analysis/02_sub_bam
/research/rv-02/home/zhenyuluo/01_stLFR/14_new_pcrfree_stlfr_lariat/G400_ECR6_stLFR-17/04_rmdup/01_sub_bam
/research/rv-02/home/zhenyuluo/01_stLFR/14_new_pcrfree_stlfr_bwa/G400_ECR6_stLFR-17/stLFR_Analysis/02_sub_bam


for i in *X.bam
do
nohup samtools index -@ 200 $i &
done

nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I data.sort.30X.bam -O data.sort.30X.bam_gatk.vcf &

nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I data.sort.20X.bam -O data.sort.20X.bam_gatk.vcf &

nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I data.sort.10X.bam -O data.sort.10X.bam_gatk.vcf &


############  old pe 100 stLFR 
/research/rv-02/home/zhenyuluo/01_stLFR/01_PCR_free_50X/PE100_stLFR_analysis
#################
ln -s data.sort.30X.bam_gatk.vcf lariat.stlfr_17.30x.gatk.vcf
###########  rtg benchmark analysis #############################
echo "$(hostname)"
for i in lariat.stlfr_17.30x.gatk.vcf
do
id=$(basename $i .gatk.vcf)
bcftools view $i -Oz -o $i.gz
bcftools index $i.gz
tabix -p vcf $i.gz

bcftools view -O z --type snps $i.gz > $i.snp.gz
bcftools index $i.snp.gz
tabix -p vcf $i.snp.gz

bcftools view -O z --type indels $i.gz > $i.indel.gz
bcftools index $i.indel.gz
tabix -p vcf $i.indel.gz

echo " deal with vcf done"

/research/rv-02/home/qmao/Scripts/rtg-tools-3.8.4/rtg vcfeval \
-b /home/ycai/hm/dev/pipeline/by_eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/giab4.2.1/benchmark_indel.chrfix.vcf.gz \
-c $i.indel.gz \
-e /home/ycai/hm/dev/pipeline/by_eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/giab4.2.1/benchmark_bed.chrfix.bed \
-t /research/rv-02/home/qmao/DBs/hg38_benchmark_ref/GRCh38.sdf \
-T 80 \
-o ${id}_indel_GIAB_v4

/research/rv-02/home/qmao/Scripts/rtg-tools-3.8.4/rtg vcfeval \
-b /home/ycai/hm/dev/pipeline/by_eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/giab4.2.1/benchmark_snp.chrfix.vcf.gz \
-c $i.snp.gz \
-e /home/ycai/hm/dev/pipeline/by_eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/giab4.2.1/benchmark_bed.chrfix.bed \
-t /research/rv-02/home/qmao/DBs/hg38_benchmark_ref/GRCh38.sdf \
-o ${id}_snp_GIAB_v4

echo "compare with GIAB done"
done
###########################  end  ########################################


####################  for bwa calling  ###################
for i in data.sort.*.bam_gatk.vcf
do
~/anaconda3/envs/python3/bin/python /home/zhenyuluo/01_git_stlfr/dev/CGI_WGS_nonstandard_Pipeline/vcffilter.py \
-g 11 -G 61 -m 0.11 -M 0.265 -x 5.5 -X 3.95 -infile $i -sample data
echo "$i filter done "
done
#########################  end  ##############################
################  for ema calling ##############################
for i in data.sort.*.bam_gatk.vcf
do
~/anaconda3/envs/python3/bin/python /home/zhenyuluo/01_git_stlfr/dev/CGI_WGS_nonstandard_Pipeline/vcffilter.py \
-g 11 -G 61 -m 0.11 -M 0.265 -x 5.5 -X 3.95 -infile $i -sample sample1
echo "$i filter done "
done
##################  end  #############################



echo "filter start=$(date)"
~/anaconda3/envs/python3/bin/python /home/zhenyuluo/01_git_stlfr/dev/CGI_WGS_nonstandard_Pipeline/vcffilter.py \
-g 11 -G 61 -m 0.11 -M 0.265 -x 5.5 -X 3.95 -infile data.sort.10X.bam_gatk.vcf -sample data
echo "filter start=$(date)"
~/anaconda3/envs/python3/bin/python /home/zhenyuluo/01_git_stlfr/dev/CGI_WGS_nonstandard_Pipeline/vcffilter.py \
-g 11 -G 61 -m 0.11 -M 0.265 -x 5.5 -X 3.95 -infile data_gatk.vcf -sample data
echo "end=$(date)"
echo "filter start=$(date)"
~/anaconda3/envs/python3/bin/python /home/zhenyuluo/01_git_stlfr/dev/CGI_WGS_nonstandard_Pipeline/vcffilter.py \
-g 11 -G 61 -m 0.11 -M 0.265 -x 5.5 -X 3.95 -infile data_gatk.vcf -sample data
echo "end=$(date)"
echo "end=$(date)"


# need to see
~/work_path/01_stLFR/14_new_pcrfree_stlfr_lariat/G400_ECR6_stLFR-1
http://lx-basm-05.dev.completegenomics.com:38178?auth=DDZmoNIhgUP2LtD6uICCUjbLh8DUMQhuDv4FwZ2z38A
http://lx-basm-03.dev.completegenomics.com:38178?auth=DDZmoNIhgUP2LtD6uICCUjbLh8DUMQhuDv4FwZ2z38A

~/work_path/01_stLFR/14_new_pcrfree_stlfr_ema/G400_ECR6_stLFR-1




~/anaconda3/envs/python3/bin/python /home/zhenyuluo/01_git_stlfr/dev/CGI_WGS_nonstandard_Pipeline/vcffilter.py \
-g 11 -G 61 -m 0.11 -M 0.265 -x 5.5 -X 3.95 -infile data_gatk.vcf -sample data_tmp


for bam in data.sort.10X.bam data.sort.20X.bam
do

nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I $bam -O ${bam}_gatk.vcf &
done

Nhnjnydx0k


###################  for  ~/work_path/01_stLFR/14_new_pcrfree_stlfr_bwa/G400_ECR6_stLFR-17/stLFR_Analysis/01_sub_bam
echo $(hostname)
echo "downsample start doing"
depthV2=/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/tools/depthV2.0.pl
ref=/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa
fasta_non_gapped_bases=2934876545

rawbam=data.sort.removedup_rm000.bam
bamf=$(basename $rawbam .removedup_rm000.bam)

samtools view -@ 200 -s 0.8219178 $rawbam -o $bamf.30X.bam
samtools index -@ 200 $bamf.30X.bam

bam=$bamf.30X.bam
nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I $bam -O ${bam}_gatk.vcf &

nohup bedtools genomecov -bga -ibam $bam > $bam.bedtools.nopc.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=($3-$2+1)*$4 }END{print SUM/2934876545}' $bam.bedtools.nopc.depth >> bedtools_samtools.depth.stat && \
echo "$bam.bedtools.nopc.depth done" >> bedtools_samtools.depth.stat  && echo >> bedtools_samtools.depth.stat &

nohup samtools depth $bam > $bam.samtools.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3 }END{print SUM/2934876545}' $bam.samtools.depth >> bedtools_samtools.depth.stat && \
echo "$bam.samtools.depth done" >> bedtools_samtools.depth.stat && echo  >> bedtools_samtools.depth.stat &

nohup samtools view -@ 200 -c $bam >> reads_number.txt && echo "$bam reads count done"  >> reads_number.txt && echo >> reads_number.txt &
nohup perl $depthV2 -l $fasta_non_gapped_bases $bam ./ > ${bam}_perl_depth.txt &

samtools view -@ 200 -s 0.5479452 $rawbam -o $bamf.20X.bam
samtools index -@ 200 $bamf.20X.bam &

bam=$bamf.20X.bam
nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I $bam -O ${bam}_gatk.vcf &

nohup bedtools genomecov -bga -ibam $bam > $bam.bedtools.nopc.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=($3-$2+1)*$4 }END{print SUM/2934876545}' $bam.bedtools.nopc.depth >> bedtools_samtools.depth.stat && \
echo "$bam.bedtools.nopc.depth done" >> bedtools_samtools.depth.stat  && echo >> bedtools_samtools.depth.stat &

nohup samtools depth $bam > $bam.samtools.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3 }END{print SUM/2934876545}' $bam.samtools.depth >> bedtools_samtools.depth.stat && \
echo "$bam.samtools.depth done" >> bedtools_samtools.depth.stat && echo  >> bedtools_samtools.depth.stat &

nohup samtools view -@ 200 -c $bam >> reads_number.txt && echo "$bam reads count done"  >> reads_number.txt && echo >> reads_number.txt &
nohup perl $depthV2 -l $fasta_non_gapped_bases $bam ./ > ${bam}_perl_depth.txt &

samtools view -@ 200 -s 0.2739726 $rawbam -o $bamf.10X.bam
samtools index -@ 200 $bamf.10X.bam &

bam=$bamf.10X.bam
nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I $bam -O ${bam}_gatk.vcf &

nohup bedtools genomecov -bga -ibam $bam > $bam.bedtools.nopc.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=($3-$2+1)*$4 }END{print SUM/2934876545}' $bam.bedtools.nopc.depth >> bedtools_samtools.depth.stat && \
echo "$bam.bedtools.nopc.depth done" >> bedtools_samtools.depth.stat  && echo >> bedtools_samtools.depth.stat &

nohup samtools depth $bam > $bam.samtools.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3 }END{print SUM/2934876545}' $bam.samtools.depth >> bedtools_samtools.depth.stat && \
echo "$bam.samtools.depth done" >> bedtools_samtools.depth.stat && echo  >> bedtools_samtools.depth.stat &

nohup samtools view -@ 200 -c $bam >> reads_number.txt && echo "$bam reads count done"  >> reads_number.txt && echo >> reads_number.txt &
nohup perl $depthV2 -l $fasta_non_gapped_bases $bam ./ > ${bam}_perl_depth.txt &

echo "downsample have done"
###################  for  ~/work_path/01_stLFR/14_new_pcrfree_stlfr_bwa/G400_ECR6_stLFR-17/stLFR_Analysis/01_sub_bam




##########################  for ema
echo $(hostname)
conda activate python3

# ln -s data/*_R?_*.gz .
# ln -s data/10X.barcode.240M.list
# # run1
# parallel -j120 --bar 'paste <(pigz -c -d {} | paste - - - -) <(pigz -c -d {= s:_R1_:_R2_: =} | paste - - - -) | tr "\t" "\n" |\
  # /home/zhenyuluo/anaconda3/envs/python3/bin/ema count -w 10X.barcode.240M.list  -o {/.} 2>{/.}.log' ::: *_R1_*.gz

# echo "ema run1 done"
ema=/home/zhenyuluo/anaconda3/envs/python3/bin/ema
sambamba=/home-02/zhenyuluo/anaconda3/envs/python3/bin/sambamba
# run2
paste <(pigz -c -d *_R1_*.gz | paste - - - -) <(pigz -c -d *_R2_*.gz | paste - - - -) | tr "\t" "\n" |\
  $ema preproc -w 10X.barcode.240M.list -n 500 -t 40 -o output_dir *.ema-ncnt 2>&1 | tee preproc.log

echo "ema run2 done"

# run3
parallel --bar -j20 "/home/zhenyuluo/anaconda3/envs/python3/bin/ema align -t 8 -d -r /home/zhenyuluo/work_path/reference/hs38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -s {} |\
  samtools sort -@ 8 -O bam -l 0 -m 4G -o {}.bam -" ::: output_dir/ema-bin-???
echo "ema run3 done"

# run4

/opt/cgi-tools/bin/bwa mem -p -t 120 -M -R "@RG\tID:rg1\tSM:sample1" /home/zhenyuluo/work_path/reference/hs38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa output_dir/ema-nobc |\
  samtools sort -@ 120 -O bam -o output_dir/ema-nobc.bam

echo "ema run4 done"
# run5

$sambamba markdup -t 120 -p -l 0 output_dir/ema-nobc.bam output_dir/ema-nobc-dupsmarked.bam
rm output_dir/ema-nobc.bam

echo "ema run5 done"
# run6
$sambamba merge -t 120 -p ema_final.bam output_dir/*.bam
echo "ema run6 done"
echo "done"
####################################################end  




depthV2=/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/tools/depthV2.0.pl
ref=/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa
fasta_non_gapped_bases=2934876545

rawbam=data.sort.removedup_rm000.bam
bamf=$(basename $rawbam .removedup_rm000.bam)
echo $(hostname)

samtools view -@ 200 -s 0.8503 $rawbam -o $bamf.30X.bam
samtools index -@ 200 $bamf.30X.bam

bam=$bamf.30X.bam
nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I $bam -O ${bam}_gatk.vcf &

nohup bedtools genomecov -bga -ibam $bam > $bam.bedtools.nopc.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=($3-$2+1)*$4 }END{print SUM/2934876545}' $bam.bedtools.nopc.depth >> bedtools_samtools.depth.stat && \
echo "$bam.bedtools.nopc.depth done" >> bedtools_samtools.depth.stat  && echo >> bedtools_samtools.depth.stat &

nohup samtools depth $bam > $bam.samtools.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3 }END{print SUM/2934876545}' $bam.samtools.depth >> bedtools_samtools.depth.stat && \
echo "$bam.samtools.depth done" >> bedtools_samtools.depth.stat && echo  >> bedtools_samtools.depth.stat &

nohup samtools view -@ 200 -c $bam >> reads_number.txt && echo "$bam reads count done"  >> reads_number.txt && echo >> reads_number.txt &
nohup perl $depthV2 -l $fasta_non_gapped_bases $bam ./ > ${bam}_perl_depth.txt &

samtools view -@ 200 -s 0.56689 $rawbam -o $bamf.20X.bam
samtools index -@ 200 $bamf.20X.bam &

bam=$bamf.20X.bam
nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I $bam -O ${bam}_gatk.vcf &

nohup bedtools genomecov -bga -ibam $bam > $bam.bedtools.nopc.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=($3-$2+1)*$4 }END{print SUM/2934876545}' $bam.bedtools.nopc.depth >> bedtools_samtools.depth.stat && \
echo "$bam.bedtools.nopc.depth done" >> bedtools_samtools.depth.stat  && echo >> bedtools_samtools.depth.stat &

nohup samtools depth $bam > $bam.samtools.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3 }END{print SUM/2934876545}' $bam.samtools.depth >> bedtools_samtools.depth.stat && \
echo "$bam.samtools.depth done" >> bedtools_samtools.depth.stat && echo  >> bedtools_samtools.depth.stat &

nohup samtools view -@ 200 -c $bam >> reads_number.txt && echo "$bam reads count done"  >> reads_number.txt && echo >> reads_number.txt &
nohup perl $depthV2 -l $fasta_non_gapped_bases $bam ./ > ${bam}_perl_depth.txt &

samtools view -@ 200 -s 0.28345 $rawbam -o $bamf.10X.bam
samtools index -@ 200 $bamf.10X.bam &

bam=$bamf.10X.bam
nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I $bam -O ${bam}_gatk.vcf &

nohup bedtools genomecov -bga -ibam $bam > $bam.bedtools.nopc.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=($3-$2+1)*$4 }END{print SUM/2934876545}' $bam.bedtools.nopc.depth >> bedtools_samtools.depth.stat && \
echo "$bam.bedtools.nopc.depth done" >> bedtools_samtools.depth.stat  && echo >> bedtools_samtools.depth.stat &

nohup samtools depth $bam > $bam.samtools.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3 }END{print SUM/2934876545}' $bam.samtools.depth >> bedtools_samtools.depth.stat && \
echo "$bam.samtools.depth done" >> bedtools_samtools.depth.stat && echo  >> bedtools_samtools.depth.stat &

nohup samtools view -@ 200 -c $bam >> reads_number.txt && echo "$bam reads count done"  >> reads_number.txt && echo >> reads_number.txt &
nohup perl $depthV2 -l $fasta_non_gapped_bases $bam ./ > ${bam}_perl_depth.txt &





[zhenyuluo@lx-basm-04 ~/work_path/01_stLFR/14_new_pcrfree_stlfr_bwa/G400_ECR6_stLFR-17/stLFR_Analysis/01_sub_bam 20:04:12]$nohup sh sub_bam.sh > sub_bam.sh.log 2>&1 &[1] 120622

[zhenyuluo@lx-basm-06 ~/work_path/01_stLFR/14_new_pcrfree_stlfr_bwa/G400_ECR6_stLFR-1/stLFR_Analysis/01_sub_bam 20:02:20]$nohup sh sub_bam.sh > sub_bam.sh.log 2>&1 &
[1] 74841



########  for  bcmap  #######################
software path: ~/work_path/git_biosoft/bcmap
sometest: ~/work_path/01_stLFR/14_new_pcrfree_stlfr_bwa/data/L01/test/03_10x_2_bcmap

Paired-end Linked-reads
Barcodes are stored in BX:Z: flag of read Ids
Sorted by barcode (use i.e. bcctools (only for 10x genomics linked-reads) or samtools)
To trimm, correct and sort barcodes with bcctools use the following command in the bcctools folder:

./script/run_bcctools -f fastq first.fq.gz second.fq.gz
/home/zhenyuluo/work_path/git_biosoft/bcctools/scripts/run_bcctools.sh -f fastq SampleName_S1_L001_I1_001.fastq.gz  SampleName_S1_L001_R1_001.fastq.gz
#############################################


03.23.2023
~/work_path/01_stLFR/14_new_pcrfree_stlfr_lariat/G400_ECR6_stLFR-1/data



 /research/rv-02/home/zhenyuluo/07_test/16_pcr_free_stlfr/
#  10x, 20x, 30x, rtg

/research/rv-02/home/zhenyuluo/07_test/16_pcr_free_stlfr/03_downsample_rm000




0313
Tasks: All comparisons should be against GIAB version 4.1.2
 specific-regions=low in pcr-free, high in stlfr

1/Test different amounts of PCR free and stLFR data to determine optimal combination. (Zhenyu)
parse all snp in 2 parts:
 1. pcr-free high region, ruch rtg on both (pcr-free.vcf, stlfr.lariat.vcf)
 2. specific-regions, run rtg on both
2/Test barcode aware mappers to see if FP removal can be improved. (Zhenyu)
Lariat
Bcmap (conda install gcc)
EMA
3/Determine by coverage, what regions of the PCR free BAM with low coverage might be improved by the addition of the barcode aware stLFR BAM. (Zhenyu)
4/Combine, either completely, or only specific regions, of stLFR barcode aware mapper BAM and PCR free BAM to see if improvements can be made in FN calls (Note FP cal
 1. of all pcr-free FN, how many can be called in stlFR
 2. of FN in pcr-free specific-regions, how many can be called in stlFR
5/Evaluate SV callers determine what improvements can be made to SV calls and what work might be needed to improve SV caller use of stLFR data.
need truth sv as benchmark,
LongRanger
Aquila
Others?
sz in-house
6/Determine what amounts of and programs for local de novo assembly can be used to improve the overall call rate of the stLFR and PCR free product.
Novel X
Others?
7/Combine the various aspects of the above processes into an integrated and shareable pipeline.





depthV2=/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/tools/depthV2.0.pl
ref=/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa
fasta_non_gapped_bases=2934876545

rawbam=data.sort.removedup_rm000.bam
bamf=$(basename $rawbam .removedup_rm000.bam)


bam=$bamf.30X.bam
nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I $bam -O ${bam}_gatk.vcf &

nohup bedtools genomecov -bga -ibam $bam > $bam.bedtools.nopc.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=($3-$2+1)*$4 }END{print SUM/2934876545}' $bam.bedtools.nopc.depth >> bedtools_samtools.depth.stat && \
echo "$bam.bedtools.nopc.depth done" >> bedtools_samtools.depth.stat  && echo >> bedtools_samtools.depth.stat &

nohup samtools depth $bam > $bam.samtools.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3 }END{print SUM/2934876545}' $bam.samtools.depth >> bedtools_samtools.depth.stat && \
echo "$bam.samtools.depth done" >> bedtools_samtools.depth.stat && echo  >> bedtools_samtools.depth.stat &

nohup samtools view -@ 200 -c $bam >> reads_number.txt && echo "$bam reads count done"  >> reads_number.txt && echo >> reads_number.txt &
nohup perl $depthV2 -l $fasta_non_gapped_bases $bam ./ > ${bam}_perl_depth.txt &


bam=$bamf.20X.bam
nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I $bam -O ${bam}_gatk.vcf &

nohup bedtools genomecov -bga -ibam $bam > $bam.bedtools.nopc.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=($3-$2+1)*$4 }END{print SUM/2934876545}' $bam.bedtools.nopc.depth >> bedtools_samtools.depth.stat && \
echo "$bam.bedtools.nopc.depth done" >> bedtools_samtools.depth.stat  && echo >> bedtools_samtools.depth.stat &

nohup samtools depth $bam > $bam.samtools.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3 }END{print SUM/2934876545}' $bam.samtools.depth >> bedtools_samtools.depth.stat && \
echo "$bam.samtools.depth done" >> bedtools_samtools.depth.stat && echo  >> bedtools_samtools.depth.stat &

nohup samtools view -@ 200 -c $bam >> reads_number.txt && echo "$bam reads count done"  >> reads_number.txt && echo >> reads_number.txt &
nohup perl $depthV2 -l $fasta_non_gapped_bases $bam ./ > ${bam}_perl_depth.txt &

samtools view -@ 200 -s 0.2490 $rawbam -o $bamf.10X.bam
samtools index -@ 200 $bamf.10X.bam &

bam=$bamf.10X.bam
nohup /home/eanderson/gatk-4.1.2.0/gatk HaplotypeCaller -R \
/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa -I $bam -O ${bam}_gatk.vcf &

nohup bedtools genomecov -bga -ibam $bam > $bam.bedtools.nopc.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=($3-$2+1)*$4 }END{print SUM/2934876545}' $bam.bedtools.nopc.depth >> bedtools_samtools.depth.stat && \
echo "$bam.bedtools.nopc.depth done" >> bedtools_samtools.depth.stat  && echo >> bedtools_samtools.depth.stat &

nohup samtools depth $bam > $bam.samtools.depth && \
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3 }END{print SUM/2934876545}' $bam.samtools.depth >> bedtools_samtools.depth.stat && \
echo "$bam.samtools.depth done" >> bedtools_samtools.depth.stat && echo  >> bedtools_samtools.depth.stat &

nohup samtools view -@ 200 -c $bam >> reads_number.txt && echo "$bam reads count done"  >> reads_number.txt && echo >> reads_number.txt &
nohup perl $depthV2 -l $fasta_non_gapped_bases $bam ./ > ${bam}_perl_depth.txt &


depthV2=/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/tools/depthV2.0.pl
ref=/research/rv-02/home/eanderson/CGI_WGS_Pipeline/Data_and_Tools/data/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa
fasta_non_gapped_bases=2934876545

nohup perl $depthV2 -l $fasta_non_gapped_bases $bam ./ > ${bam}_perl_depth.txt &







benchmark analysis of SNPs in four special regions compared with GIAB version 4.2.1


V300045667C-ESR20



Orange and blue

Some analyses for PCR free + stLFR data to answer the tasks 1 to 4



G400_ECR6_stLFR-1 






Advanced Whole Genome Sequencing Using a Complete PCR-free Massively Paralle



channels:
  - bioconda
  - r
  - conda-forge
  - biocore
  - defaults
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/pro
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/msys2
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/pro
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/r
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/free
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/main
  - https://mirrors.ustc.edu.cn/anaconda/cloud/menpo/
  - https://mirrors.ustc.edu.cn/anaconda/cloud/bioconda/
  - https://mirrors.ustc.edu.cn/anaconda/cloud/msys2/
  - https://mirrors.ustc.edu.cn/anaconda/cloud/conda-forge/
  - https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
  - https://mirrors.ustc.edu.cn/anaconda/pkgs/main/
  - conda-forge
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/main
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/r
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.bfsu.edu.cn/anaconda/cloud
  msys2: https://mirrors.bfsu.edu.cn/anaconda/cloud
  bioconda: https://mirrors.bfsu.edu.cn/anaconda/cloud
  menpo: https://mirrors.bfsu.edu.cn/anaconda/cloud
  pytorch: https://mirrors.bfsu.edu.cn/anaconda/cloud
  pytorch-lts: https://mirrors.bfsu.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.bfsu.edu.cn/anaconda/cloud
auto_activate_base: false
env_prompt: ({default_env})



$cat ~/.condarc 
ssl_verify: true

channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/pro
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/msys2
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/pro
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/r
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/free
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/main
  - https://mirrors.ustc.edu.cn/anaconda/cloud/menpo/
  - https://mirrors.ustc.edu.cn/anaconda/cloud/bioconda/
  - https://mirrors.ustc.edu.cn/anaconda/cloud/msys2/
  - https://mirrors.ustc.edu.cn/anaconda/cloud/conda-forge/
  - https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
  - https://mirrors.ustc.edu.cn/anaconda/pkgs/main/
  - conda-forge
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/main
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/r
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.bfsu.edu.cn/anaconda/cloud
  msys2: https://mirrors.bfsu.edu.cn/anaconda/cloud
  bioconda: https://mirrors.bfsu.edu.cn/anaconda/cloud
  menpo: https://mirrors.bfsu.edu.cn/anaconda/cloud
  pytorch: https://mirrors.bfsu.edu.cn/anaconda/cloud
  pytorch-lts: https://mirrors.bfsu.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.bfsu.edu.cn/anaconda/cloud















































