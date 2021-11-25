## Linux （Arch）配置列表

### Linux 发行版

**OS**：[Arch](https://archlinux.org)

EDIT：neovim

bash：zsh



### 系统安装

#### 1. 分区

##### 1.1 检查硬盘

查看硬盘状态和需要分区的硬盘的id

```
lsblk
```

##### 1.2 建立分区

将步骤1中找到的硬盘进行分区

```
cfdisk /dev/sd*
```

建议至少三个区 `EFI` `SWAP` `\`

| 分区 |     作用     |   类型（Type）   |       大小       |
| :--: | :----------: | :--------------: | :--------------: |
| EFI  | 启动引导分区 |    EFI System    |      260M+       |
| SWAP |   交换空间   |    Linux SWAP    | 依情况而定 512M+ |
|  \   |    根分区    | Linux filesystem |       随意       |

假设：EFI：sda1，SWAP：sda2，根分区：sda3

##### 1.3 格式化建立的分区

格式化 EFI 分区

```
mkfs.fat -F32 /dev/sda1
```

格式化 SWAP 分区

```
mkswap /dev/sda2
swapon /dev/sda2
```

格式化系统分区

```
mkfs.ext4 /dev/sda3
```

#### 2. 准备

##### 2.1 换源

编辑 `/etc/pacman.d/mirrorslist` 文件，添加国内源到最上面

##### 2.2 挂载

首先将 根分区挂载到 `/mnt` 目录下

```
mount /dev/sda3 /mnt
```

然后挂载 EFI 分区

```
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
```

#### 3. 安装

使用 `pacstrap` 安装系统

```
pacstrap /mnt base base-devel linux linux-firmware neovim sudo
```

生成 `fstab` 文件

```
genfstab -U /mnt >> /mnt/etc/fstab
```



#### 4. 配置 1

##### 4.1 切换到安装好的系统

```
arch-chroot /mnt
```

##### 4.2 设置时区

```
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
```

##### 4.3 本地化，设置locale

```
nvim /etc/locale.gen
```

删除 `en_US.UTF-8` `zh_CN.UTF-8` 前面的 #，然后生成 locale

```
locale-gen
```

编辑 `/etc/locale.conf` 文件，加入

```
/etc/locale.conf
```

##### 4.4 设置 hostname 和 hosts

编辑主机名字

```
nvim /etc/hostname
```

修改hosts

```
nvim /etc/hosts

127.0.0.1	localhost
::1			localhost
127.0.1.1	{hostname}.localdomain	{hostname}
```

##### 4.5 创建用户并设置密码

为root用户创建密码

```
passwd
```

创建用户并设置密码

```
useradd -m -G wheel username
passwd username
```

添加用户root执行权限

```
EDITOTR=nvim visudo
```

删除`#wheel ALL=(ALL) ALL` 前面的 # 号 



##### 4.6 创建启动器

安装grub

```
pacman -S grub efibootmgr
grub-install -recheck /dev/sda
```



##### 4.7 退出，重启

输入 `exit` 或按 `Ctrl+d` 退出 chroot 环境。

可选用 `umount -R /mnt` 手动卸载被挂载的分区。

最后，通过执行 `reboot` 重启系统。

#### 4. 配置 2

后续配置进入系统后先安装 git

然后执行 [还原和后续修改提交](#### 还原和后续修改提交)

```
pacman -S git
git clone https://github.com/yaojia25/dotfiles.git
```

然后执行对应的`.sh`文件

### 基础配置清单

|      配置       |                            软件名                            |              包名               | AUR  |
| :-------------: | :----------------------------------------------------------: | :-----------------------------: | :--: |
|      桌面       |   [~~i3-gaps~~](https://wiki.archlinux.org/title/I3) bspwm   |         i3-gaps，bspwm          |      |
| 快捷键（bspwm） |                            sxhkd                             |              sxhkd              |      |
|     状态栏      |     [polybar](https://wiki.archlinux.org/title/Polybar)      |             polybar             |  Y   |
|     启动器      |                             rofi                             |              rofi               |      |
|     渲染器      |                            picom                             |              picom              |      |
|      终端       |                          alacritty                           |            alacritty            |      |
|      壁纸       |                            feh，                             |               feh               |      |
|      通知       |                            dunst                             |              dunst              |      |
|     输入法      | [fcitx5](https://wiki.archlinux.org/title/Fcitx5_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)) | fcitx5-im fcitx5-chinese-addons |      |
|    AUR 助手     |                        paru / ~~yay~~                        |                                 |      |

桌面环境依赖：`xorg-server`  `xorg-xinit` `xorg-xsetroot (可选)`

以下命令可以获取窗口的class

```
xprop | grep WM_CLASS
```



### 字体配置清单

|   用处   |      字体名       |                             包名                             | AUR  |
| :------: | :---------------: | :----------------------------------------------------------: | :--: |
| 中文字体 |     更沙黑体      |                      ttf-sarasa-gothic                       |  Y   |
| 中文宋体 |     思源宋体      |               adobe-source-han-serif-otc-fonts               |      |
| 终端字体 | 等距更沙黑体 Nerd | [Sarasa-Mono-SC-Nerd](https://github.com/laishulu/Sarasa-Mono-SC-Nerd) （github） |      |
| 代码字体 |  JetBrains Mono   |                      ttf-jetbrains-mono                      |  Y   |
| 图标字体 |   Iosevka Nerd    |                       ttf-iosevka-nerd                       |  Y   |
|   表情   |       emoji       |                       noto-fonts-emoji                       |      |

手动安装字体时将字体移到`/usr/share/fonts` 文件夹下，然后执行以下命令刷新字体缓存

```
fc-cache -vf
```



### 常用软件清单

|   软件名    |          包名          | AUR  |
| :---------: | :--------------------: | :--: |
| 文件管理器  |         thunar         |      |
| EDGE 浏览器 | microsoft-edge-dev-bin |  Y   |
|   VSCode    | visual-studio-code-bin |  Y   |
|   Typora    |         typora         |      |
| 火狐浏览器  |        firefox         |      |



### 美化配置清单

|     用途      |       软件       |         包名          | AUR  |
| :-----------: | :--------------: | :-------------------: | :--: |
|  GTK主题管理  |   lxappearance   |     lxappearance      |      |
|    GTK主题    |       Arc        |     arc-gtk-theme     |      |
|   图标主题    |      Paper       |   paper-icon-theme    |  Y   |
|  输入法主题   |  Material Color  | fcitx5-material-color |      |
|  QT主题管理   |      qt5ct       |         qt5ct         |      |
| QT使用GTK主题 | qt5-styleplugins |   qt5-styleplugins    |  Y   |



### git 管理配置文件

#### 首次使用

```bash
git init --bare $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc

config status
config add .vimrc 
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push

config remote add origin https://github.com/yaojia25/dotfiles.git
config branch -M main
config push -u origin main
```

#### 还原和后续修改提交

把仓库里的内容下载下来：
```bash
git clone --bare <git-repo-url> $HOME/.dotfiles
```

设置 alias：
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```
checkout 云端的配置文件到你的 $HOME 目录下：
```bash
config checkout
```
如果配置文件存在会冲突，可以先删除相应的配置文件



同样把 status.showUntrackedFiles 关闭：

```bash
config config --local status.showUntrackedFiles no
```

之后每次修改完 add 命令使用以下来添加，可以只添加已经跟踪的文件：

```
config add -u
```

