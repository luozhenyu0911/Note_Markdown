## vscode 更新后在终端wsl中无法tab补全

vscode更新后，在wsl中无法tab补全，原因是vscode的终端默认使用的是wsl，而wsl中默认没有安装bash-completion，导致tab补全功能失效。

解决方法：

1. 安装bash-completion：

```
sudo apt-get install bash-completion
```

2. 在.bashrc文件中添加以下内容：

   ```
   if [ -f /etc/bash_completion.d/bash-completion.sh ]; then
       . /etc/bash_completion.d/bash-completion.sh
   fi
   ```

3. 重启vscode，即可正常使用tab补全功能。    