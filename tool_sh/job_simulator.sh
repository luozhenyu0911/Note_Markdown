




cat /home/ycai/hm/dev/notes/simulator.txt




/home/ycai/hm/dev/notes


df -h | awk '{ if(NF==1){getline;print $3} ; if(NF==6) {print $4} }'


follow up of 0905 meeting
1/ github repo
there are 3 main pipelines
https://github.com/CGI-stLFR/CGI_WGS_Pipeline is standard pipeline in SJ
SZ pipeline in /dev repo
https://github.com/CGI-stLFR/wgs_se100_pipeline is for  SE100 data in SJ
for private repo, you'll need to be member of CGI-stLFR group
2/ simulator Docker config file 你参照新旧2个看一下 旧的很详细, 新的有改动
new example
/home/ycai/hm/dev/simulator/simulator_ellis/100BP_0Error_100Cells_40M/simImager.config
old with more detailed instruction 
/research/rv-02/InternalProjects/PerfectHumanGenome/simulator_code/SimImager/SimImager.config 
3/ I'll run V350114043 
L01 R2 =42BC +79 adapter +79gDNA
L02-L04= 42BC +45 adapter +113gDNA
in the future, you may first check Q30 patter in summary_report.html, then confirm with lab
local cofig.yml  for wgs_se100_pipeline here:
/home/ycai/hm/dev/pipeline/wgs_se100_pipeline/config.yaml
you may use 'git remote show origin' to check the repo on github, if any.


/home/ycai/hm/dev/simulator/simulator_new/T2T-CHM13/ref/snp







