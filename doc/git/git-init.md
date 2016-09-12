# Git 初始化

## Version

git --version


## Config

git config --global user.name 'Author'
git config --global user.email 'xxx@xxx.com'

sudo git config --system alias.st status
sudo git config --system alias.ci commit
sudo git config --global alias.ci commit

git config --global color.ui true

## Init

mkdir repo
cd repo
git init

## .git

```
git rev-parse --show-toplevel
# /Users/tcui/Documents/AppAnnie/ios-app1
git rev-parse --git-dir
# /Users/tcui/Documents/AppAnnie/ios-app1/.git
git rev-parse --show-prefix
# APIV1/Swizzle/
git rev-parse --show-cdup
# ../../
pwd
# /Users/tcui/Documents/AppAnnie/ios-app1/APIV1/Swizzle
```

## git config

git config -e
git config -e --global
git config -e --system

git config core.bare # false
git config a.b something











