





 1046  conda create -n mrna -y python=3
 1047  conda create -n RNA-seq -y python=3
 1048  conda activate RNA-seq
 1049  conda install hisat2
 1050  conda install samtools



gunzip GRCh38_latest_genomic.gff.gz
~/anaconda3/envs/python3/bin/gffread -T GRCh38_latest_genomic.gff -o GRCh38_latest_genomic.gtf

extract_exons.py GRCh38_latest_genomic.gff > GRCh38.exons.gtf 
extract_splice_sites.py GRCh38_latest_genomic.gff > GRCh38.splice_sites.gtf 

hisat2-build -p 100 --ss GRCh38.splice_sites.gtf --exon GRCh38.exons.gtf  GRCh38_latest_genomic.fa GRCh38_latest_genomic.fa
















