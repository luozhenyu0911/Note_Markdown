








mkdir V350130971 V350131074




dir=/hwfssz8/MGI_CG_SZ/DATA/MGISEQ-2000/V350131074
samp=V350131074

mkdir L01 L02 L03 L04
arr=("L01" "L02" "L03" "L04")

for line in "${arr[@]}"
do
cd $line
mkdir fastq  stLFR_Analysis
cd fastq
ln -s $dir/$line ${samp}_${line}
cd ../../
done

## check fq gz file 
for fq in `find $dir/ -name "*gz"`
do
gzip -t $fq >> fq_check.txt && echo "gzip -t $fq" >> fq_check.txt
done


# qsub -cwd -l vf=1G,num_proc=1 -P P21Z18000N0016 -q mgi.q link_check.sh




dir=/hwfssz8/MGI_CG_SZ/DATA/MGISEQ-2000/V350130971
samp=V350130971

#mkdir L01 L02 L03 L04
arr=("L01" "L02" "L03" "L04")

for line in "${arr[@]}"
do
cd $line
# mkdir fastq  stLFR_Analysis
cd fastq
# ln -s $dir/$line ${samp}_${line}
cd ../stLFR_Analysis
cp ~/software/git_pipeline/dev/CGI_WGS_nonstandard_Pipeline/config.yaml .
cp ~/software/git_pipeline/dev/CGI_WGS_nonstandard_Pipeline/run_snakemake.sh .

cd ../../
done


~/software/git_pipeline/dev/CGI_WGS_nonstandard_Pipeline



config.yaml run_snakemake.sh



V350131074_L01




gzip -t /hwfssz8/MGI_CG_SZ/DATA/MGISEQ-2000/V350130971/L04/V350130971_L04_read_1.fq.gz

docker-compose down





arr=("L01" "L02" "L03" "L04")

for line in "${arr[@]}"
do
cd $line
# mkdir fastq  stLFR_Analysis
cd fastq
# ln -s $dir/$line ${samp}_${line}
cd ../stLFR_Analysis
cp ~/software/git_pipeline/dev/CGI_WGS_nonstandard_Pipeline/config.yaml .
cp ~/software/git_pipeline/dev/CGI_WGS_nonstandard_Pipeline/run_snakemake.sh .

cd ../../
done


arr=("L01" "L02" "L03" "L04")

for line in "${arr[@]}"
do
head -n 5 ./$line/stLFR_Analysis/split_stat_read1.log

done



arr=("L01" "L02" "L03" "L04")
for line in "${arr[@]}"
do
cd $line
cd stLFR_Analysis
rm -r .snakemake
qsub -cwd -l vf=500G,num_proc=30 -P P21Z18000N0016 -q mgi_supermem.q run_snakemake.sh
cd ../../
done






cat ./L01/stLFR_Analysis/snakemake.err.txt
cat ./L02/stLFR_Analysis/snakemake.err.txt
cat ./L03/stLFR_Analysis/snakemake.err.txt
cat ./L04/stLFR_Analysis/snakemake.err.txt

7512392 0.25155 run_snakem luozhenyu    r     09/29/2022 08:49:12 mgi_supermem.q@cngb-supermem-f     1
7512395 0.25155 run_snakem luozhenyu    r     09/29/2022 08:49:37 mgi_supermem.q@cngb-supermem-f     1
7512400 0.25155 run_snakem luozhenyu    r     09/29/2022 08:49:37 mgi_supermem.q@cngb-supermem-f     1
7512403 0.25155 run_snakem luozhenyu    r     09/29/2022 08:49:37 mgi_supermem.q@cngb-supermem-f     1
7512471 0.25155 run_snakem luozhenyu    r     09/29/2022 08:49:37 mgi_supermem.q@cngb-supermem-f     1
7512477 0.25155 run_snakem luozhenyu    r     09/29/2022 08:49:37 mgi_supermem.q@cngb-supermem-f     1
7512480 0.25155 run_snakem luozhenyu    r     09/29/2022 08:49:37 mgi_supermem.q@cngb-supermem-f     1





qstat -j 7512392 |grep sge_o_workdir
qstat -j 7512395 |grep sge_o_workdir
qstat -j 7512400 |grep sge_o_workdir
qstat -j 7512403 |grep sge_o_workdir
qstat -j 7512471 |grep sge_o_workdir
qstat -j 7512477 |grep sge_o_workdir
qstat -j 7512480 |grep sge_o_workdir


nextflow run ~/nextflow/subsetting_mod/zebra.nf --images_folder ~/02_occupancy/V350130971 \
--slide V350130971 --start 1 --range 200 --output ~/02_occupancy/occu_outdir/202209290971 --qmin 0 --qmax 30

nextflow run ~/nextflow/subsetting_mod/zebra.nf --images_folder ~/02_occupancy/V350131074 \
--slide V350131074 --start 1 --range 200 --output ~/02_occupancy/occu_outdir/202209291074 --qmin 0 --qmax 30





nextflow run ~/nextflow/subsetting_mod/zebra.nf --images_folder ~/02_occupancy/V350130971 \
--slide V350130971 --start 1 --range 200 --output ~/02_occupancy/occu_out/202209290971 \
--qmin 0 --qmax 30 --cwsta 1 --cwend 191 --qt 18 --thresh 4 -profile sge


nextflow run ~/nextflow/subsetting_mod/zebra.nf --images_folder ~/02_occupancy/V350131074 \
--slide V350131074 --start 1 --range 200 --output ~/02_occupancy/occu_out/202209291074 \
--qmin 0 --qmax 30 --cwsta 1 --cwend 191 --qt 18 --thresh 4 -profile sge


nextflow run ~/nextflow/zebra_occu/main.nf --images_folder ~/02_occupancy/V350130971 \
--slide V350130971 --start 1 --range 10 --output ~/02_occupancy/zebra_output/202209290971 -profile sge


nextflow run ~/nextflow/zebra_occu/main.nf --images_folder ~/02_occupancy/V350130971 \
--slide V350130971 --start 1 --range 10 --output ~/02_occupancy/zebra_output/202209290971 -profile sge

nextflow run ~/nextflow/zebra_occu/main.nf --images_folder ~/02_occupancy/V350130971 \
--slide V350130971 --start 1 --range 10 --output ~/02_occupancy/zebra_output/202209290971 -profile sgels







cat ./L01/stLFR_Analysis/summary_report.txt |awk -F":" '{print $2}' > V350130971-L01.csv
cat ./L02/stLFR_Analysis/summary_report.txt |awk -F":" '{print $2}' > V350130971-L02.csv
cat ./L03/stLFR_Analysis/summary_report.txt |awk -F":" '{print $2}' > V350130971-L03.csv
cat ./L04/stLFR_Analysis/summary_report.txt |awk -F":" '{print $2}' > V350130971-L04.csv


cat ./L01/stLFR_Analysis/summary_report.txt |awk -F":" '{print $2}' > V350131074-L01.csv
cat ./L02/stLFR_Analysis/summary_report.txt |awk -F":" '{print $2}' > V350131074-L02.csv
cat ./L03/stLFR_Analysis/summary_report.txt |awk -F":" '{print $2}' > V350131074-L03.csv
cat ./L04/stLFR_Analysis/summary_report.txt |awk -F":" '{print $2}' > V350131074-L04.csv















