



pip 安装失败的其他方法
安装第三方包
pip install xxx-package -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
pip install pysam -i http://pypi.doubanio.com/simple/ --trusted-host pypi.doubanio.com




pip install BCBio -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com


python -m ensurepip
python -m pip install --upgrade pip


pip install biopython==1.84 numpy==1.26.4 pandas==2.2.1 scipy==1.14 svglib==1.5.1


svision 1.4 requires intervaltree, which is not installed.
svision 1.4 requires pysam, which is not installed.
svision 1.4 requires pyvcf, which is not installed.
svision 1.4 requires scipy==1.5.4, which is not installed.
svision 1.4 requires tensorflow==1.14.0, which is not installed.


pip install pyvcf, 
