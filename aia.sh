#!/bin/bash
clear
echo " █████╗ ██╗ █████╗ "
echo "██╔══██╗██║██╔══██╗"
echo "███████║██║███████║"
echo "██╔══██║██║██╔══██║"
echo "██║  ██║██║██║  ██║"
echo "╚═╝  ╚═╝╚═╝╚═╝  ╚═╝"
echo "                     Made By TESF_Duwen"
sleep 1
echo "Welcome to Arch Linux install assistant script made by TESF_Duwen."
echo "Because the Linux terminal cannot display Chinese well, we will use English for prompts and interactions."
echo " "
sleep 1
echo "Are you in Chinese Mainland? (if you are in Chinese Mainland, the China mirror source will be added.)"
read -p "[Y/n]" region
case $region in
	yes | y* | Y* | *)
		echo " Changing China mirror source..."
		sed -i '11i Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist
		sed -i '12i Server = https://mirrors.163.com/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist
		pacman -Syy
		echo -e " \E[32mdone.\E[0m "
		echo "Synchronizing time..."
		timedatectl set-ntp true
		echo -e " \E[32mdone.\E[0m "
		;;
	no | n* | N*)
		echo "Synchronizing time..."
		timedatectl set-ntp true
		echo -e " \E[32mdone.\E[0m "
esac
sleep 1
clear
echo -e " \E[31mAttention:please make sure that your disk is mounted in the /mnt directory.\E[0m"
sleep 5
echo " Installing basic system Suite..."
pacstrap /mnt base linux linux-firmware dhcpcd iwd vim sudo bash-completion nano net-tools openssh man git wget zsh fish
genfstab -U /mnt >> /mnt/etc/fstab
echo -e " \E[32mdone.\E[0m "
echo " Downloading satellite script..."
wget -P /mnt/ https://api.tesf.top/download/archlinux/sate.sh
chmod 777 /mnt/sate.sh
echo -e " \E[32mdone.\E[0m "
sleep 1
clear
echo " Starting Arch Linux(please manually ./sate.sh)"
echo -e " \E[31mPlease execute it manually: ./sate.sh\E[0m"
sleep 1
echo -e " \E[31mPlease execute it manually: ./sate.sh\E[0m"
sleep 1
echo -e " \E[31mPlease execute it manually: ./sate.sh\E[0m"
arch-chroot /mnt