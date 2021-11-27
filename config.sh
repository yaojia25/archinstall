#!/bin/bash

# 换源
echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo 'Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch ' >> /etc/pacman.d/mirrorlist

# Archlinuxcn
echo '[archlinuxcn]' >> /etc/pacman.conf
echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> /etc/pacman.conf
pacman -Syy --noconfirm archlinuxcn-keyring

# AUR helper
pacman -S --noconfirm paru

# wm
pacman -S --noconfirm bspwm sxhkd xorg-server xorg-xinit xorg-xsetroot
# system
pacman -S --noconfirm rofi picom alacritty feh fcitx5-im fcitx5-chinese-addons dunst
pacman -S --noconfirm pulseaudio network-manager-applet nm-connection-editor
pacman -S --noconfirm thunar gvfs thunar-volman thunar-archive-plugin thunar-thumbnailers 
paru -S --noconfirm thunar-shares-plugin polybar
pacman -S --noconfirm ranger neofetch figlet lazygit
pacman -S --noconfirm ranger typora

# 字体
pacman -S --noconfirm ttf-sarasa-gothic adobe-source-han-serif-otc-fonts noto-fonts-emoji
paru -S --noconfirm ttf-sarasa-gothic ttf-jetbrains-mono ttf-iosevka-nerd


# 美化
pacman -S --noconfirm arc-gtk-theme qt5ct lxappearance
paru -S --noconfirm papirus-icon-theme-git qt5-styleplugins

# 软件
paru -S --noconfirm visual-studio-code-bin microsoft-edge-stable-bin 

# 安装更沙黑体 Nerd
git clone https://github.com/laishulu/Sarasa-Mono-SC-Nerd
rm -rf ./Sarasa-Mono-SC-Nerd/screenshots ./Sarasa-Mono-SC-Nerd/scripts
rm -f ./Sarasa-Mono-SC-Nerd/LICENSE ./Sarasa-Mono-SC-Nerd/README.md
mv -r ./Sarasa-Mono-SC-Nerd /usr/bin/fonts
fc-cache -vf
