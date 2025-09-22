


1/ HapCUT2: robust and accurate haplotype assembly for diverse sequencing technologies
input, output file format
## Linked Reads (10X Genomics, stLFR, etc)
Phasing using Linked reads require an extra step to link the short reads together into barcoded molecules.


2/ transfer docker image to singularity image

https://www.jianshu.com/p/ab94ec11bcea

######################  install singularity  ############################
sudo apt-get update && sudo apt-get install -y \
         build-essential  \
         uuid-dev  \
         libgpgme-dev  \
         squashfs-tools  \
         libseccomp-dev  \
         wget  \
         pkg-config  \
         git  \
         cryptsetup-bin

wget https://golang.org/dl/go1.14.12.linux-amd64.tar.gz
tar -xzvf go1.14.12.linux-amd64.tar.gz
rm go1.14.12.linux-amd64.tar.gz
export PATH="/research/rv-02/home/zhenyuluo/git_biosoft/go/bin:$PATH"

wget https://github.com/hpcng/singularity/releases/download/v3.7.2/singularity-3.7.2.tar.gz
tar -xzf singularity-3.7.2.tar.gz
cd singularity

./mconfig
cd builddir
make
sudo make install

###################     END     ########################################


###################    将docker镜像push到docker hub上   #################################

docker login
Login with your Docker ID to push and pull images from Docker Hub. 
Username: luozhenyu114
Password:

# rename docker images tag dockerHub required (username/images)
docker tag phg-compose_phg luozhenyu114/phg-compose_phg
docker push luozhenyu114/phg-compose_phg


/share/app/singularity/3.8.1/bin/singularity build ./phg-compose_phg.sif docker://luozhenyu114/phg-compose_phg:latest
#######################               END                  ##############################



export SINGULARITY_TMPDIR=/hwfssz8/MGI_CG_SZ/USER/luozhenyu/tmp
export TMPDIR=/hwfssz8/MGI_CG_SZ/USER/luozhenyu/tmp

singularity instance start --nv -B /hwfssz8/MGI_CG_SZ/USER/luozhenyu:/home phg-compose_phg.sif simulator_lzy

singularity instance list

singularity shell instance://simulator_lzy

export PhgDataRoot=/home/luozhenyu

cp /tools/simImager.config /home/luozhenyu

##################### RUN A DOCKER/singularity CONTAINER  #######################

cd ../phg-compose

To start the container, run the script ./run.sh.  It will bring up a container in the
background.  To obtain a shell on the container, first obtain the container id with
"docker container ls", then get a shell with
        docker exec -it $ContainerId bash

To run the phg application, first set the env variable PhgDataRoot to be the folder where
the work will be performed.  Typically this would be the same as 'PathInsideContainer'
that was defined in the docker-compose.yml file.
        export PhgDataRoot=/path/to/work

copy the sample /tools/simImager.config into $PhgDataRoot
copy your genome file into $PhgDataRoot, can use either docker cp or do the copy directly on
the parent host to the dir 'PathOnParentHost' previously defined in docker-compose.yml.
Edit the file $PhgDataRoot/simImager.config.  At a minimum, set the genome parameter to point
to the genome file.

Run the script
        /tools/parallel.sh
multiple instances of SimImager will run in the background, writing to $PhgDataRoot/data_N
(where N is instance #).  Wait until 'ps -ef' shows these are done and there are no errors
(check in data_N and look at nohup.out,err,out files).
If successful, run the script
        /tools/combine.sh
If combine.sh was successful, do these steps
        cd $PhgDataRoot
        /tools/convert2fq.py --length 100
                where N is the read length
output will be stored in simulated_read1.fq and simulated_read2.fq files in $PhgDataRoot






##########   执行实例   ###################
singularity exec instance://test1 sh /tools/parallel.sh


singularity build ./deepvariant.sif docker://google/deepvariant:"1.5.0"

pull

singularity pull docker://google/deepvariant:"1.5.0"



###################    将docker镜像push到docker hub上   #################################

docker login
Login with your Docker ID to push and pull images from Docker Hub. 
Username: luozhenyu114
Password:

# rename docker images tag dockerHub required (username/images)
docker tag google/deepvariant luozhenyu114/deepvariant
docker push luozhenyu114/deepvariant


/share/app/singularity/3.8.1/bin/singularity build ./deepvariant.sif docker://google/deepvariant:"1.5.0"
#######################               END                  ##############################




deepvariant_1.5.0.sif


singularity instance start --nv -B ~:/home deepvariant_1.5.0.sif simulator_lzy




export SINGULARITY_TMPDIR=/home/zhenyuluo/tmp
export TMPDIR=/home/zhenyuluo/tmp









