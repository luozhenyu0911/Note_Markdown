




################################  03.25.2023 docker study ##############################
# reference
https://docker.easydoc.net/doc/81170005/cCewZWoN/AWOEX9XM

docker ps 查看当前运行中的容器
docker images 查看镜像列表
docker rm container-id 删除指定 id 的容器
docker stop/start container-id 停止/启动指定 id 的容器
docker rmi image-id 删除指定 id 的镜像
docker volume ls 查看 volume 列表
docker network ls 查看网络列表

#####################  end  ###################################################


##########################  03.25.2023 docker study in 组学大讲堂  ####################
https://study.163.com/course/courseLearn.htm?courseId=1210028910#/learn/video?lessonId=1284425217&courseId=1210028910
# reference
https://study.163.com/course/courseLearn.htm?courseId=1210028910#/learn/video?lessonId=1280831199&courseId=1210028910

# to see docker install information
docker info 

docker search omicsclass
# download image
docker pull omicsclass/samtoolls

# to check downloaded image
docker image ls == docker images

# 交互式运行
docker run --rm -it omicsclass/blast-plus:latest
# 退出
exit

# rm image
docker image rm IMAGE ID

# windows 中的D:\blast目录映射到linux容器的work目录
# linux 中直接用/home
docker run --rm -it -v D:\blast:/work omicsclass/blast-plus:latest
# -v 目录映射会直接将目录下已有的文件也会映射，进入交互式docker后，就可以直接运行软件命令了。

# 后台运行，怎么查看
docker ps
# 打印log
docker logs $NAMES

# 进入后台容器
docker attach $NAMES
# 交互式进入，执行bash
docker exec it $NAMES bash

# 如果image中没有work目录，会自动创建，但进入时的目录为image的默认目录；若有就会覆盖
# 如果要默认进入work目录可以加-w /work
# docker run --rm -it -m 20G --cpus 2 -w /work -v D:\blast:/work omicsclass/blast-plus:latest 
docker run --rm -it -m 20G --cpus 2 -v D:\blast:/work omicsclass/blast-plus:latest bash

# 直接使用docker image中的软件
docker run --rm -it -m 20G --cpus 2 -v D:\blast:/work omicsclass/blast-plus:latest bash
# 后面直接加软件命令，output file会直接输出在当前的执行命令的目录
docker run -it -m 20G --cpus 2 -v D:\blast:/work omicsclass/blast-plus:latest blastn 。。。。。。

### my test  #######
docker pull continuumio/conda-ci-linux-64-python2.7
docker run --rm -it -v /home/zhenyuluo/work_path/08_docker:/work continuumio/conda-ci-linux-64-python2.7:latest

# for Snakemake 
conda create -n Snakemake -y python=3
conda install bwa samtools 


conda config --add channels bioconda
conda config --add channels r
conda config --add channels conda-forge
conda config --add channels biocore

conda config --add 键 值
conda config --set 键 值

####################################  end ###################################

docker pull google/deepvariant:1.5.0
docker save -o deepvariant.tar google/deepvariant
docker load --input rocketmq.tar 或 docker load < rocketmq.tar


reference: https://cloud.tencent.com/developer/article/1915741


# install Docker in Unbuntu subsystem.

sudo cp /etc/apt/sources.list /etc/apt/sourses.list.bak

sudo vim /etc/apt/sources.list
    deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse





pip install vcf -i http://pypi.tuna.tsinghua.edu.cn/simple/ --trusted-host pypi.tuna.tsinghua.edu.cn
python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple vcf

https://pypi.org/project/PyVCF/

pip install vcf -i https://pypi.org/simple --trusted-host pypi.org

1/ install docker
# 系统内核
uname -r

cat /etc/os-release

# 1. 卸载就得版本
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
                  
# 2. 安装依赖环境
yum install -y yum-utils

# 3. 设置镜像的仓库
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo #  默认是国外的！
    
yum-config-manager \
    --add-repo \   
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo # 推荐使用 阿里云镜像

# 4. 更新软件包的索引
yum makecache fast

# 5. 安装最新版的 docker 引擎， docker-ce 社区版  ee 企业版 （也可以指定安装不停的版本）
yum install docker-ce docker-ce-cli containerd.io  

# 6. 启动 docker
systemctl start docker

# 7. 使用 docker version 查看是否启动成功
docker version

# 8. 启动一个镜像
docer run hello-world

# 9. 查看下载好的镜像
docker images

设置镜像
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

启动信息
systemctl start docker

docker version

#######  卸载docker  
# 两个步骤完成卸载
Uninstall Docker Engine
Uninstall the Docker Engine, CLI, and Containerd packages:

# 1. 卸载 docker 一些依赖
yum remove docker-ce docker-ce-cli containerd.io

Images, containers, volumes, or customized configuration files on your host are not automatically removed. To delete all images, containers, and volumes:

# 2. 删除目录，卸载资源
rm -rf /var/lib/docker

# 3. docker 的默认工作路径
/var/lib/docker

You must delete any edited configuration files manually

#####  设置阿里云镜像加速
1登录阿里云
2找到容器镜像服务
3配置镜像加速器

########   四、docker 常用命令

4.1 帮助命令
docker version # 显示 docker 的版本信息

docker info    # 显示 docker 的系统信息，包括镜像 和 容器的数量

docker --help # 帮助命令

4.2 镜像命令（search, download, remove, cat）

docker images 查看所有本地主机上的镜像
$docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              bf756fb1ae65        9 months ago        13.3kB

# 解释
REPOSITORY  镜像的仓库源
TAG		    镜像的标签
IMAGE ID    镜像的 ID
CREATED     镜像的创建时间
SIZE        镜像的大小

# 可选项
-a，--all   # 列出所有镜像
-q，--quiet # 只显示镜像的 id

docker search 搜索镜像

docker search mysql --filter STARS=300

docker pull 下载镜像

docker pull mysql:5.7

# 等价
docker pull mysql
docker pull docker.io/library/mysql:latest

# 指定版本下载（官方文档指定）
docker pull mysql:5.7

# 根据 ID 删除，也可以同时指定多个 ID
docker rmi -f  IMAGE ID,IMAGE ID,IMAGE ID

# 递归删除所有镜像
docker rmi -f $(docker images -aq)

4.3 容器命令
# 下载 centOS 镜像
docker pull centos

docker run [可选参数] image

# 参数说明
--name="Name" 容器名称 tomcat01 tomcat02 用来区分容器
-d			 后台方式运行
-it			 使用交互方式运行，进入容器查看内容
-P		 	 指定容器的端口 -p 8080:8080
	-p ip:主机端口:容器端口
	-p 主机端口：容器端口 （常用的）
	-p 容器端口
-p			 随机指定端口
 
# 测试  启动并进入容器
$docker run -it centos /bin/bash
$ls  # 查看容器内的 centos，基础版本，很多命令都不是完善的
bin  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var


# 查看运行中的容器
# docker ps 命令
	# 列出当前正在运行的容器
-a  # 列出当前正在运行的容器 + 带出历史运行过的容器
-n=7 # 显示最近创建容器的个数
-q  # 只显示容器编号

列出所有运行的容器
docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                          PORTS               NAMES
f3f9e8b9045f        centos              "/bin/bash"         3 minutes ago       Exited (0) About a minute ago                       festive_hawking
44fe79a9cfc5        bf756fb1ae65        "/hello"            3 hours ago         Exited (0) 3 hours ago                              romantic_pike


退出容器
exit # 直接容器停止并退出
Ctrl + p + q # 容器不停止退出

docer rm 容器ID 	# 删除指定的容器，不能删除正在运行的容器
docer rm -f ${docker ps -aq} # 删除所有的容器
docker ps -a -q |xargs docker rm # 删除所有容器

docker start 容器 id  # 启动容器
docker restart 容器id	# 
docker stop 容器id
docker kill 容器id

后台启动容器
# docker run -d centos
091ca119820ea987ca43ae2f608a628ce2c2af9cb364274a3eadfb65f93ffa8d
# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
# 

# 问题 docker ps，发现 centos 停止了

# 常见的坑，docker 容器使用后台运行，就必须要有一个前台进行，docker 发现没有应用，就会自动停止

# nginx. 容器启动后，发现自己没有提供服务，就会立刻停止，就是没有程序了

查看日志
docker logs -f -t --tail 容器，没有日志

# 自己编写一段 shell 脚本
docker ps

# 显示日志
-tf			 # 显示日志
--tail number # 显示日志的条数
docker logs -tf --tail 10 容器 ID

查看容器中进程的信息 ps
docker top

# docker top 3e77e2715543
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                31464               31448               0                   15:28               pts/0               00:00:00            /bin/bash

查看镜像的元数据

# 命令
docker inspect 容器id

# 我们通常容器都是使用后台方式运行的，需要进入容器，修改一些配置

# 命令
docker exec -it 容器id /bin/bash  /sh

# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
3e77e2715543        centos              "/bin/bash"         12 minutes ago      Up 12 minutes                           admiring_visvesvaraya

# docker exec -it 3e77e2715543 /bin/bash
[root@3e77e2715543 /]# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 07:28 pts/0    00:00:00 /bin/bash
root        19     0  0 07:41 pts/1    00:00:00 /bin/bash
root        32    19  0 07:41 pts/1    00:00:00 ps -ef

# 方式二
docker attach 容器Id  # 进入当前正在进行的命令行

# docker exec # 进入容器后开启一个新的终端，可以在里面操作（常用）
# docker attach # 进入容器正在执行的终端，不会启动新的进程！

从容器内拷贝文件到主机上
docker cp 容器id: 容器内路径 主机路径

[root@VM_0_15_centos ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
ed828f6c65d8        centos              "/bin/bash"         8 minutes ago       Up 8 minutes                            beautiful_swanson
[root@VM_0_15_centos ~]# docker attach 3e77e2715543
You cannot attach to a stopped container, start it first
[root@VM_0_15_centos ~]# docker attach ed828f6c65d8
[root@ed828f6c65d8 home]# ls
a.java

# ctrl + p + q 后台运行
[root@VM_0_15_centos ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
ed828f6c65d8        centos              "/bin/bash"         9 minutes ago       Up 9 minutes                            beautiful_swanson
[root@VM_0_15_centos ~]# cd /home/
[root@VM_0_15_centos home]# ls
apache-tomcat-9.0.30  java  node  Python-3.7.1  Python-3.7.1.tgz  wget-log
[root@VM_0_15_centos home]# mkdir docker
[root@VM_0_15_centos home]# ls
apache-tomcat-9.0.30  docker  java  node  Python-3.7.1  Python-3.7.1.tgz  wget-log
[root@VM_0_15_centos ~]# docker cp ed828f6c65d8:/home/a.java /home/docker/
[root@VM_0_15_centos ~]# cd /home/
[root@VM_0_15_centos home]# cd docker/
[root@VM_0_15_centos docker]# ls
a.java

# 拷贝是一个手动过程，未来我们使用 -V 卷的技术，可以实现同步 /home








































































