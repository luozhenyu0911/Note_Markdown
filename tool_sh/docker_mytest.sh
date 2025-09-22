










docker exec -it f7dcb6d92b25 bash

docker commit d81abcfd2e3b demo:v1.3

### my test  #######
docker pull continuumio/conda-ci-linux-64-python2.7
docker run -it -v /home/zhenyuluo/work_path/08_docker:/work continuumio/conda-ci-linux-64-python2.7:latest

# for Snakemake 
conda create -n Snakemake -y python=3
conda install bwa samtools 


conda config --add channels bioconda
conda config --add channels r
conda config --add channels conda-forge
conda config --add channels biocore



1、docker ps 查看正在运行的容器.



 2、docker exec –it d81abcfd2e3b bash 进入正在运行的容器内

3、进入容器后，就可以修改镜像了，比如修改镜像中已经部署的代码或者安装新的软件或包等，修改完成之后，exit 退出容器

4、docker commit d81abcfd2e3b demo:v1.3 提交你刚才修改的镜像，新的镜像名称为demo，版本为v1.3，期间容器不能停止。






















