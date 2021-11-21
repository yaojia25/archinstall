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

# i3-gaps
pacman -S --noconfirm i3-gaps xorg-server xorg-xinit
pacman -S --noconfirm polybar rofi picom alacritty feh fcitx5-im fcitx5-chinese-addons 
pacman -S --noconfirm thunar gvfs lxappearance neofetch
pacman -S --noconfirm ranger qt5ct typora

# 字体
pacman -S --noconfirm ttf-sarasa-gothic adobe-source-han-serif-otc-fonts noto-fonts-emoji


# 美化
pacman -S --noconfirm arc-gtk-theme
paru -S ttf-sarasa-gothic ttf-jetbrains-mono ttf-iosevka-nerd
paru -S paper-icon-theme qt5-styleplugins

# 软件
paru -S visual-studio-code-bin typora microsoft-edge-dev-bin

# 安装更沙黑体 Nerd
git clone https://github.com/laishulu/Sarasa-Mono-SC-Nerd
rm -rf ./Sarasa-Mono-SC-Nerd/screenshots ./Sarasa-Mono-SC-Nerd/scripts
rm -f ./Sarasa-Mono-SC-Nerd/LICENSE ./Sarasa-Mono-SC-Nerd/README.md
mv -r ./Sarasa-Mono-SC-Nerd /usr/bin/fonts
fc-cache -vf
