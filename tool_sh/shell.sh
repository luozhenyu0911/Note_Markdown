







ctrl+z //挂起当前任务

jobs //查看任务，返回任务编号n和进程号

bg %n //将编号为n的任务转后台运行


## for bash
export PS1="\e[33m\][\[\e[33m\]\u@\h] \e[32m\]\t \e[31m\]\w\\n$\[\e[0m\] "
[gzfezx_shhli_2@ln42] 16:50 /BIGDATA2/gzfezx_shhli_2/USER/luozhenyu

## for zsh
export PS1="%D %* [%n@%1~] $ "
20-11-22 15:43:41 [username@~] $

autoload -U colors && colors 

PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[green]%}%1|%~ %{$reset_color%}%#>"     

PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[green]%}%1|%~ ${$'\n'}%{$reset_color%}$"



NEWLINE=$'\n'
PROMPT="%{$fg[green]%}%d %t %{$reset_color%}%# ${NEWLINE}"

PROMPT="%{$fg[green]%}%d %t ${NEWLINE}%{$reset_color%}%"


PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg[cyan]%}%1|%~ ${NEWLINE}%{$reset_color%}$"


PROMPT="%F{9}[%n%{$reset_color%}%F{190}@%F{40}%m] %F{197}[%*] %F{226}%1|%~ ${NEWLINE}%{$reset_color%}$"

NEWLINE=$'\n'
PROMPT="# %F{9}%n%{$reset_color%}%F{190}@%F{40}%m %{$fg[cyan]%}[%*] %F{226}%1|%~ ${NEWLINE}%{$reset_color%}$ "

export PS1="\e[33;1m\][\[\e[33;1m\]\u@\h]\e[32;1m\] 👻\d\t👻 \e[31m\]\w\\n$\[\e[0m\] "

#########  create function
function run_xx(){
    xx=$1; xx=$2
    shell cmd
}

if [ -s/e xx ]; then
    xx
else
    xx
fi



###################################  for html sites ##############################################

FTPDIR=ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/AshkenazimTrio/HG002_NA24385_son/PacBio_CCS_15kb/
# for fastq in $(curl -s -l ${FTPDIR} | grep -E '.fastq$'); do curl -s ${FTPDIR}${fastq} > fastqs/${fastq}; done
for fastq in $(curl -s -l ${FTPDIR} | grep -E '.md5$')
do
echo "curl -s ${FTPDIR}${fastq} > fastqs/${fastq} " |sed 's/curl -s ftp/wget -c http/g; s/>/-O/g' >> fq_download_md5.sh
# curl -s ${FTPDIR}${fastq} > fastqs/${fastq} &
done
echo "wait" >> fq_download_md5.sh

###################################################################################################


############   parallel  #################
#!/bin/bash
# yhbatch -N 1 -n 24 -p rhenv
n=0
for i in `cat fastq.list`
do
    if ((n >= 24));then
        wait
        n=-1
    else
        # id=$(basename $i .vcf)
        gzip $i &
    ((n++))
    fi
done
wait




#################   判断文件夹是否存在  ###########################
if [ ! -d "/data/" ];then
mkdir /data
else
echo "文件夹已经存在"
fi


FILE="yourfile.txt"

if [ -e "$FILE" ]; then
    echo "$FILE exists."
else
    echo "$FILE does not exist."
fi



















