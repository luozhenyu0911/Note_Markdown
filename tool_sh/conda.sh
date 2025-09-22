##########  构建一个conda包

source /BIGDATA2/gzfezx_shhli_2/miniconda3/etc/profile.d/conda.sh 
source ~/BIGDATA2/gzfezx_shhli_2/miniconda3/bin/activate manta2



conda config --set auto_activate_base false

安装打包conda环境的软件：conda install -c conda-forge conda-pack
使用conda-pack打包环境：conda pack -n 虚拟环境名称 -o output.tar.gz


###  conda activate env change the PS1
conda config --set env_prompt "({default_env})[\u@\h \W]$"
#cancel set 
conda config --remove-key env_prompt


###  创建环境  并安装
conda create --name manta3 -y manta -c bioconda
conda remove -n mtoolbox_py2.7 --all

## remove env
conda remove -n mtoolbox-ark --all -y

conda create -n R3.1.2 r-base=3.1.2
conda create -n mtoolbox_py2.7 -y python=2.7
###########################   update gcc 7.2.0 not in root path
conda create -n Snakemake -y python=3
conda create -n CC_base -y
conda activate CC_base
conda install  -c conda-forge cxx-compiler
conda create -n mtoolnote -y python=3.7
conda create -n mtoolnote2 -y python=3

##########################################################

### 在脚本中运行
source /BIGDATA2/gzfezx_shhli_2/miniconda3/etc/profile.d/conda.sh
conda activate manta

conda create -n metasv -y metasv

#########################  conda for docker for stlfr pipeline  ####################
conda create -n RNA-seq -y python=3

conda install -c bioconda deepvariant=1.5.0

conda create -n 项目名 python=版本号创建一个全局环境，用于安装一些常用的软件，例如bwa、samtools、seqkit等。然后用如下命令将环境导出成yaml文件

conda env export -n base -f environment.yaml

那么当你到了一个新的环境，你就可以用下面这个命令重建出你的运行环境
conda env create -f viromes2.envs.yaml

# To test this, could you try running curl to retrieve the current_repodata.json file:
# if not, the failed would due to the sever network
# maybe, you can unset unset socks_proxy if you just open the client
curl -O https://repo.anaconda.com/pkgs/main/linux-64/current_repodata.json

channels:
  - defaults
  - bioconda
  - conda-forge
  - ursky
  - r
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
ssl_verify: false
report_errors: true
show_channel_urls: true
#proxy_servers:
#  http: http://12.10.133.131:3128
#  https: http://12.10.133.131:3128


#!/bin/bash
source ~/anaconda3/etc/profile.d/conda.sh
conda activate wrfpy && python test.py

# 在shell中直接使用目标环境下python的绝对路径
~/anaconda3/envs/wrfpy/bin/python test.py

#!/bin/bash
source ~/anaconda3/bin/activate wrfpy && python test.py

conda create -n cnvnator python=3.6
source activate cnvnator
conda install -c conda-forge root_base=6.20 -y 
conda install -c conda-forge -c bioconda cnvnator -y



conda create -n manta manta -c bioconda ##建立一个新的环境
conda install manta -c bioconda  ##安装manta软件



conda env export -n manta -f manta_environment.yaml
conda env export -n breakseq2 -f breakseq2_environment.yaml




conda create -n pdf2zh python=3.12 



##############################   build a conda package 
conda create -n conda_build conda-build anaconda-client setuptools



conda install convert2bed gff2bed gff2starch -y

conda install r=4.4 -y -c conda-forge


conda env create -f viromes2.envs.yaml 


conda create -n Mediation -c conda-forge r=4.4 -y

