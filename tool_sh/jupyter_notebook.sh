


####  jupyter notebook python 运行和终端不一致：导致无法导入python包

# check 
import sys
print(sys.executable)

jupyter kernelspec list

# solution
pip 重新安装ipython


#########   端口问题

alias jp='jupyter notebook --no-browser --port=8783 --ip=0.0.0.0'
# alias tojp='ssh zhenyuluo@10.103.32.42 -L127.0.0.1:8000:127.0.0.1:8888'

#########   end


## Jupyter Notebook的16个超棒插件！
conda install -c conda-forge jupyter_nbextensions_configurator
conda install -c conda-forge jupyter_contrib_nbextensions
https://mp.weixin.qq.com/s/5oQjFGdlfRRSurCw-pIsFg


