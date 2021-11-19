## Linux （Arch）配置列表

### Linux 发行版

**OS**：[Arch](https://archlinux.org)

edit：neovim

bash：zsh

### 桌面环境 - i3
wm：i3-gaps
> 依赖：xorg-server xorg-xinit xsetroot(鼠标指针)
>
>渲染器：picom
>
> 状态栏：polybar
>
> 壁纸：feh
>
> 终端：alacritty
>
> 启动：rofi
>
> 通知（可选）：dunst
>
> papirus-icon-theme arc-gtk-theme

### 系统软件
文件管理器：thunar

主题管理：lxappearance

### 终端环境 - zsh
插件框架：zplug

### EDIT配置 - neovim
插件框架：vim-plug

### 字体
#### 中文字体
更沙黑体 ttf-sarasa-gothic

#### 中文宋体
思源宋体 adobe-source-han-serif-otc-fonts

#### 终端字体
等距更沙黑体 [Sarasa-Mono-SC-Nerd](https://github.com/laishulu/Sarasa-Mono-SC-Nerd)

DejaVuMono Nerd FONT

#### 其它字体
表情 noto-fonts-emoji

nerd-fonts-complete

otf-font-awesome

ttf-material-icons 

### git 管理

#### 备份

```bash
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc

config status
config add .vimrc 
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push

config remote add origin https://github.com/FlintyLemming/FlintyConfig.git
config branch -M main
config push -u origin main
```

#### 还原

把仓库里的内容下载下来：
```bash
git clone --bare <git-repo-url> $HOME/.cfg
```

设置 alias：
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```
checkout 云端的配置文件到你的 $HOME 目录下：
```bash
config checkout
```
上面这步可能会报错，就像这样：
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting

这是因为你的 $HOME 目录已经有这些文件了，发生了冲突。解决方法很简单：如果你不需要原来的文件，删掉即可；如果需要，就备份一下。这边提供一个冲突文件自动备份到特定文件夹下的方法：
```bash
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```
然后重新 checkout
```bash
config checkout
```
同样把 status.showUntrackedFiles 关闭：
```bash
config config --local status.showUntrackedFiles no
```
