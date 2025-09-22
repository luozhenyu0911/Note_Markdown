


###########################   de novo   #######################################

#  de novo assembly with spades
nohup /home/ycai/tools/SPAdes-3.14.0-Linux/bin/spades.py -s ${bc}.fq.gz -o ./spades --phred-offset 55 &


# get the max fasta from de novo contig.fasta with custom script
python3 /home-02/zhenyuluo/script/get_max_fa.py -f spades/contigs.fasta -m spades/contigs_max.fasta
# evaluate de nove result with quast software
nohup /home/eanderson/quast/quast.py ${scaf} -o quast_contig -r ${ref} --min-contig 100 --no-snps --threads 4 --eukaryote --space-efficient &












tar -xvzf SPAdes-3.15.4-Linux.tar.gz



































