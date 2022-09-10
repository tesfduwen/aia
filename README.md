# AIA
众所周知，arch linux 的安装比较麻烦，于是我就想：能不能写一个脚本，自动执行大多数安装步骤。于是，就有了AIA。  
AIA是Arch Linux installation assistant的缩写，这其实是我写的第一个shell脚本，之前也没接触过，就按照网上的教程一步步走，可能有许多不足之处。  
目前可以实现的功能：
*自动换国内源
*自动设置国内时区
*自动安装基础系统套件
*自动设置hostname（可自定义）
*自动创建普通用户（自定义用户名）
*自动配置sudo的wheel用户组权限
*自动本地化语言（英语）
*自动添加multilib和archlinuxcn
*自动安装intel/amd-ucode
*自动安装及配置grub
*自动安装archlinuxcn-keyring
*自动安装桌面环境（kde）
*自动安装中文输入法及字体
*自动配置输入法
*自动安装aur助手
未能实现：
*自动磁盘分区及挂载
*自由选择桌面环境（kde/gnome）
食用方法：  
wget https://api.tesf.top/download/archlinux/aia.sh  
chmod 777 aia.sh  
./aia.sh
