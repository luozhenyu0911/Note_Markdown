

/home/ycai/hm/dev/Project_stLFR/BGI/pipeline_analysis_for_combined_lanes/ZY20180118lib-O-NA1287850M50p11C-16_combine

/home/ycai/hm/dev/simulator/simulator_new/T2T-CHM13/test/se10k/align_CHM13/Make_Vcf/step2_benchmarking/snp_compare


nohup ./start.sh &    默认输出到nohup.out文件
nohup ./start.sh >output 2>&1 &  指定输出到output文件

qsub -cwd -l vf=<mem>G,p=<num_proc> -binding linear:<num_proc> -P <project_code> -q mgi.q shell.sh

/hwfssz8/MGI_CG_SZ/DATA/MGISEQ-2000/V350114043

~/03_simulator/test_simulator/PerfectHumanGenome



################  occupancy   ########################
nextflow run ~/nextflow/zebra_occu/main.nf --images_folder ~/02_occupancy/data/V350131074 \
--slide V350131074 --start 1 --range 10 --output ~/02_occupancy/zebra_output/2022291074 -profile sge

nextflow run ~/nextflow/subsetting_mod/zebra.nf --images_folder ~/02_occupancy/V350130971 \
--slide V350130971 --start 1 --range 200 --output ~/02_occupancy/occu_out/202209290971 \
--qmin 0 --qmax 30 --cwsta 1 --cwend 191 --qt 18 --thresh 4 -profile sge

###############    end     ###########################















