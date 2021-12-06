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

# xorg
pacman -S --noconfirm xorg-server xorg-xinit xorg-xsetroot
# bspwm
pacman -S --noconfirm bspwm sxhkd
# system base
pacman -S --noconfirm rofi picom alacritty feh dunst
# input
pacman -S --noconfirm fcitx5-im fcitx5-chinese-addons 
# network and audio
pacman -S --noconfirm pulseaudio network-manager-applet nm-connection-editor
# thunar
pacman -S --noconfirm thunar gvfs gvfs-smb thunar-volman thunar-archive-plugin thunar-thumbnailers thumbler

# terminal
pacman -S --noconfirm zsh ranger neofetch figlet lazygit

# fonts
pacman -S --noconfirm ttf-sarasa-gothic adobe-source-han-serif-otc-fonts noto-fonts-emoji

# beauty
pacman -S --noconfirm arc-gtk-theme pop-gtk-theme qt5ct lxappearance

# Nerd font
git clone https://github.com/laishulu/Sarasa-Mono-SC-Nerd
mv ./Sarasa-Mono-SC-Nerd /usr/bin/fonts
fc-cache -vf



