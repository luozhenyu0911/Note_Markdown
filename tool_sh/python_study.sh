


########  python 多线程模板
def make_info_bam(path, suffix, output_file, read_length):
    with open(output_file, 'w') as f:
        bam_files = glob.glob(os.path.join(path, "**", '*.'+suffix), recursive=True)
        os.makedirs("input", exist_ok=True)
        pool = Pool(processes=24)
        all_info = []
        for bam_file in bam_files:
            str = pool.apply_async(mul_process, args=(bam_file, read_length))# 当只传入一个参数时，后面加个逗号
            all_info.append(str)
        for info in all_info:
            name, size, read_length = info.get()
            f.write(name + "\t" + size + "\t" + read_length + "\n")
        pool.close()
        pool.join()

#####################################################


1. 之前结果的更新和已报道研究的对比

3.MtDNA变异calling的工具探索

##########   11.18  将dict保存起来生成文件，再load

import pickle

with open('bc_fq_dict', 'wb') as fp:
        pickle.dump(bc_fq_dict, fp)

 with open (input, 'rb') as fp:
        bc_fq_dict = pickle.load(fp)
############  end ######################



####   多级dict 转数据库
nested_dict = {'ID 1':{'Method 1': {'Attr 1': 1,'Attr 2': 1},
                       'Method 2': {'Attr 1': 1,'Attr 2': 1}},
               'ID 2':{'Method 1': {'Attr 1': 1,'Attr 2': 1},
                       'Method 2': {'Attr 1': 1,'Attr 2': 1}}}
pd.DataFrame.from_dict({(i, j): nested_dict[i][j]
                        for i in nested_dict.keys()
                        for j in nested_dict[i].keys()},
                        orient='index')
orient='index' # 与数据库的行列转换有关

####  pandas DataFrame表格(列)拼接（concat,append,join,merge） ####

## concat
axis：拼接轴方向，默认为0，沿行拼接；若为1，沿列拼接
join：默认外联’outer’，拼接另一轴所有的label，缺失值用NaN填充；内联’inner’，只拼接另一轴相同的label；

df_concat = pd.concat([df_aa,df_zz])    # 行堆叠     # 默认沿axis=0，join=‘out’的方式进行concat
df_igno_idx = pd.concat([df_aa,df_zz], ignore_index=True)
'''
# 重新设定index(效果类似于pd.concat([df1,df2]).reset_index(drop=True))
'''
df_col = pd.concat([df_aa,df_zz], axis=1) # 列堆叠

#####  从文件中提取指定行 #############################
import linecache
text = linecache.getline('./00114031182M22BFF2', 18)
print(text.strip().split(' ')[-1])


##### shell cmd ##################
cmd = 'bowtie2 --fast -p ' + str(cores) + ' -q -x ' + Index + ' -1 ' + InFile1 + ' -2 ' + InFile2 + ' -S ' + MappedOut + '.sam --un-conc ' + UnmappedOut
subprocess.call(cmd,shell=True)

###########  判断文件夹是否存在 ##################
import subprocess
import random as random
import shutil
if os.path.isdir('TrinityAssembly') is True:
    shutil.rmtree('TrinityAssembly')
    print('Old TrinityAssembly tempfiles removed')
os.makedirs('Trinit

os.remove('topblasthits.txt')








