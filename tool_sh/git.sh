
##  配置 git
git config --global user.name "luozhenyu0911"
git config --global user.email "1018954087@qq.com"
git config --global user.password "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"

## firstly, push local to remote
git init
git add .
git status
git commit -m "first submit"
git remote add origin https://github.com/luozhenyu0911/Study.git
git push -u origin main

#####  end


ssh-keygen -t rsa -C "1018954087@qq.com"



# git push "something" to master
git config --list
git init
git config --list
git status
git add
git commit -a
git add CGI_WGS_nonstandard_Pipeline
git commit -m "chang some paths"
git push -u origin master

# git creat new branch and push something to it
git status
git init
git checkout -b lzy_stLFR
git status
git init
git branch
git push origin lzy_stLFR:lzy_stLFR
git add .
git commit -m "midification for "
git push origin lzy_stLFR:lzy_stLFR

#####   sj   bqsr  ####################
https://github.com/CGI-stLFR/dev.git

##  切换branch 并直接更新
https://blog.csdn.net/u014540717/article/details/54314126
git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/bqsr
  remotes/origin/lzy_stLFR
  remotes/origin/master
git branch
* master
git checkout -b bqsr origin/bqsr
Branch bqsr set up to track remote branch bqsr from origin.
Switched to a new branch 'bqsr'
# 再次切换
git checkout master
Switched to branch 'master'
# 如果在不保存直接更新切换的branch时：直接
git pull
Username for 'https://github.com': luozhenyu0911
Password for 'https://luozhenyu0911@github.com':
Already up-to-date.

#########################  
git checkout -b lzy_stLFR origin/lzy_stLFR

# # 再次切换
# git checkout master
# 如果在不保存直接更新切换的branch时：直接
git pull
############################



# 修改后push
git branch
git add .
git commit -m "modif calc_frag_len.smk and config.yaml(gcbias.py)"
git push origin bqsr:bqsr

#####################  end  ################

git stash # 但是该dev分支上还没有完成全部的修改，你不想提交。那么此时你就要选择 stash (存放)它们
git status # 显示没有东西需要提交，接着就可以在主分支master上创建并切换到新的分支去修复另一个Bug了


git checkout -b split_index remotes/origin/split_index

##########  10.19  modif bqsr #################

git add .
git commit -m "modif calc_frag_len.smk and config.yaml(gcbias.py)"
git push origin bqsr:bqsr

name = luozhenyu0911
        password = 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

########   update hapcut2  ######################



#####   push one local branch to another remote branch ###########

git stash
git checkout test
git branch
git stash pop
git status
git add .
git commit -m "set frag_len_max=3000 to a parameter and combine boxplot"
git branch
git push origin test:test


git push origin split_index:test




git push origin --delete test






############   02132023   github study ############
## creat a new repository and push something to it, then learn how to merge two branch
## first git add remote 
git init
git remote add origin https://github.com/luozhenyu0911/stlfr_pipeline.git
git branch -M master
git init
git add .
git commit -m "stlfr first push"
# if the remote bransh is main, you may need to execute "git push -u origin master:main"
# as for me, I like to rename the remote "main" branch to "master"
# and if it's not success, we should using "-f" parameter to force it to success
git push -u origin master:master
#####  first end ################################################

git remote add origin https://github.com/luozhenyu0911/stlfr_pipeline.git
git init
git add .
git commit -m "stlfr second push"
git checkout -b stlfr 
origin/stlfr
################### end ###########################

#############  git update/download submodule softlink
cd thisdir
git submodule update --init --recursive

#########  end  ################################


#####################  0423.2023 modif one branch and then push them to another branch   ###########################

# remove remote branch
git branch -a
* master
  remotes/origin/test

git push origin --delete test

# git creat new branch and push something to it
git status
git init
git checkout -b add_lariat
git status
git init
git branch
git add .
git commit -m "add lariat barcode aware mapper"
git push origin add_lariat:add_lariat

##############################  end  ##############################################################################

git status
git init
git checkout -b lzy_stLFR
git status
git init
git branch
git add .
git commit -m "0708.2023 update"
git push origin lzy_stLFR:lzy_stLFR



git checkout -b bqsr origin/bqsr


git add .
git commit -m "update"
git push origin main:main








git branch -a
git branch
git checkout -b sz origin/sz
git pull

git checkout -b sz
git status
git init
git branch
git add .
git commit -m "split combine log has been modified"
git push origin multisplit_lzy:multisplit_lzy





git add .
git commit -m "stLFR and phasing pipeline has been modified"
git push origin multisplit_lzy:multisplit_lzy





git checkout -b multisplit_lzy origin/multisplit_lzy


git clone https://github.com/CGI-stLFR/dev.git
cd dev
git checkout -b sz origin/sz
git pull





git remote add origin git@github.com:luozhenyu0911/RNA-seq.git




https://github.com/luozhenyu0911/RNA-seq.git




Host github.com
  Hostname ssh.github.com
  Port 443





git commit -m "split combine log has been modified"
git push origin multisplit_lzy:multisplit_lzy






git init
git checkout -b tmp
git status
git init
git branch
git add .
git commit -m "tmp"
git push origin tmp:tmp





## github远程连接
ssh-keygen -t rsa -C "1018954087@qq.com"
cat /home/lzy/.ssh/id_rsa.pub
ssh -T git@github.com
git remote -v
git remote add origin git@github.com:luozhenyu0911/Blood-viromes.git
git push origin main


git@github.com:luozhenyu0911/script.git


git config --global http.proxy 12.10.133.131:3128
git config --global https.proxy 12.10.133.131:3128


# Git-忽略规则(.gitignore配置）不生效原因和解决
git rm -r --cached .
git add .
git commit -m 'update .gitignore'
git push -u origin master



➜git:(test) git pull origin test
提示:您有不同的分支，需要指定如何协调它们。
提示:您可以通过在之前某个时间运行以下命令之一来做到这一点
提示:你的下一招:
提示:
提示:git config pull.rebase false 	# 合并(默认策略)
提示:git config pull.rebase true  	# Rebase
提示:git config pull.ff only	 	# 仅快进
提示:
提示:可以将“git config”替换为“git config——global”来设置默认值
提示:首选所有存储库。你也可以传递——rebase，——no-rebase，
提示:或命令行上的——ff-only，以覆盖配置的默认per
提示:调用。
fatal:需要指定如何协调不同的分支。


git log -2			# 查看最近2次提交的历史版本

# 根据历史版本记录，选择commit地址，回退到自己合并之前的版本
git reset --hard 33df706e780d10af6435bda1fee85430604eebfd
git merge dev

# git merge
# 分支合并发布流程：
git add .			# 将所有新增、修改或删除的文件添加到暂存区
git commit -m "版本发布" # 将暂存区的文件发版
git status 			# 查看是否还有文件没有发布上去
git checkout test	# 切换到要合并的分支
git pull			# 在test 分支上拉取最新代码，避免冲突
git merge dev   	# 在test 分支上合并 dev 分支上的代码
git push			# 上传test分支代码



git init
git add .
git commit -m "first commit"
git branch -M master
git remote add origin https://github.com/luozhenyu0911/snakemake_demo.git
git push -u origin master



#####  check the difference of two branch in github and then merge them
git diff branch1 branch2



####  A,B分支之间的提交，合并
# 已编辑分支为B

# B
git add xx
git commit -m xx
git checkout A
git pull
git checkout B
git merge A
git push

############################























