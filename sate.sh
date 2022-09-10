#!/bin/bash
echo " Installation of system basic kit is completed!"
sleep 1
echo " Please set your hostname(default:arch)."
touch /etc/hostname
read -p " Enter your hostname:" hostname
if [ ! -n "$hostname" ]; then
    echo " Setting your hostname as arch..."
    echo "arch" >> /etc/hostname
    echo -e " \E[32mdone.\E[0m "
else
    echo " Setting your hostname as $hostname..."
    echo "$hostname" >> /etc/hostname
    echo -e " \E[32mdone.\E[0m "
fi
echo -e " \E[36mPlease set your root password.\E[0m "
passwd
echo " Please creat a uaer."
read -p " Enter your new user's name:" username
if [ ! -n "$username" ]; then
    echo " Creating new user... name: arch"
    useradd -m -G wheel -s /bin/bash arch
    echo " Please set user:arch's password:"
    passwd arch
    echo -e " \E[32mdone.\E[0m "
else
    echo " Creating new user... name: $username"
    useradd -m -G wheel -s /bin/bash $username
    echo " Please set user:$username's password:"
    passwd $username
    echo -e " \E[32mdone.\E[0m "
fi
sed -i '$i %wheel ALL=(ALL:ALL)ALL' /etc/sudoers
echo " Setting the time zone..."
echo " Do you want to set the time zone in China?"
read -p "[Y/n]" time
case $time in
	yes | Y* | y* | *)
		ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
		hwclock --systohc
		;;
	no | N* | n*)
		hwclock --systohc
		;;
esac
echo -e " \E[32mdone.\E[0m "
echo " Setting locale."
sed -i "6i en_US.UTF-8 UTF-8" /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo -e " \E[32mdone.\E[0m "
echo " Configuring pacman..."
sed -i '$a [multilib]' /etc/pacman.conf
sed -i '$a Include = /etc/pacman.d/mirrorlist' /etc/pacman.conf
sed -i '$a [archlinuxcn]' /etc/pacman.conf
sed -i '$a Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch' /etc/pacman.conf
sed -i '$a Server = http://mirrors.163.com/archlinux-cn/$arch' /etc/pacman.conf
pacman -Syu
echo -e " \E[32mdone.\E[0m "
clear
echo -e " \E[36mPlease enter your cpu type(I-->intel | A-->amd | default:intel):\E[0m"
read -p "[I/A]" cpu
case $cpu in
    I* | i* | *)
        echo " Installing Intel CPU microcode and boot software..."
        pacman -S intel-ucode grub efibootmgr os-prober
        echo -e " \E[32mdone.\E[0m "
        ;;
    A* | a*)
        echo " Installing AMD CPU microcode and boot software..."
        pacman -S amd-ucode grub efibootmgr os-prober
        echo -e " \E[32mdone.\E[0m "
        ;;
esac
clear
echo " Installing grub..."
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-install
grub-mkconfig -o /boot/grub/grub.cfg
clear
echo " Do you want to install KDE desktop,font,browser and other software packages?"
read -p "[Y/n]" softwares
case $softwares in
    yes | Y* | y* | *)
        echo " Installing..."
        pacman -S archlinuxcn-keyring
        rm -rf /etc/pacman.d/gnupg
        pacman-key --init
        pacman-key --populate archlinux
        pacman-key --populate archlinuxcn
        pacman -S plasma konsole dolphin ntfs-3g os-prober
        pacman -S adobe-source-han-serif-cn-fonts adobe-source-han-sans-cn-fonts wqy-zenhei wqy-microhei noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-dejavu
        pacman -S firefox ark gwenview packagekit-qt5 packagekit appstream-qt appstream man neofetch net-tools networkmanager openssh git wget
        pacman -S fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-moegirl fcitx5-pinyin-zhwiki fcitx5-material-color
        systemctl enable NetworkManager sddm sshd
        echo -e " \E[32mdone.\E[0m "
        sleep 1
        clear
        echo " Initializing input method..."
        sed -i '$a GTK_IM_MODULE=fcitx' /etc/environment
        sed -i '$a QT_IM_MODULE=fcitx' /etc/environment
        sed -i '$a XMODIFIERS=@im=fcitx' /etc/environment
        sed -i '$a SDL_IM_MODULE=fcitx' /etc/environment
        echo -e " \E[32mdone.\E[0m "
        sleep 1
        clear
        echo " Installing AUR assistant Author..."
        pacman -S yay paru
        echo -e " \E[32mdone.\E[0m "
        sleep 1
        clear
        ;;
    no | N* | n*)
        echo " Only installing AUR assistant Author..."
        pacman -S archlinuxcn-keyring
        rm -rf /etc/pacman.d/gnupg
        pacman-key --init
        pacman-key --populate archlinux
        pacman-key --populate archlinuxcn
        pacman -S yay paru
        echo -e " \E[32mdone.\E[0m "
        clear
        ;;
esac
echo " Congratulations, all the installation has been completed!"
echo " Please reboot your computer."
sleep 1
exit