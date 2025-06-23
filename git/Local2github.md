## Ubuntu与GitHub的远程连接
### 1. 通过命令在本地生成公钥和私钥
```
ssh-keygen -t rsa -C "your_email@example.com"
```
### 2. 将公钥上传到GitHub
```
cat ~/.ssh/id_rsa.pub
```
复制公钥内容，登录GitHub，点击左上角的头像，选择`Settings`，选择`SSH and GPG keys`，点击`New SSH key`，将公钥内容粘贴到`Key`文本框，输入`Title`，点击`Add SSH key`，完成。
### 3. 连接GitHub
```
ssh -T git@github.com
```
如果连接成功，会出现`Hi username! You've successfully authenticated, but GitHub does not provide shell access.`字样，表示连接成功。