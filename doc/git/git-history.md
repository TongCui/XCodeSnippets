# Git 历史穿梭

git rev-list HEAD | wc -l

git rev-parse --symbolic --branches
git rev-parse --symbolic --tags

git rev-parse HEAD

git describe
git rev-parse A-1-g1231231

git rev-list HEAD --oneline

git rev-list --oneline ^fea_usage_intelligence ba-5317-usage-history-automation

(^ 取反)

git rev-list --oneline fea_usage_intelligence..ba-5317-usage-history-automation

git rev-list --oneline fea_usage_intelligence...ba-5317-usage-history-automation

git log --graph --oneline

git config --global alias.glog "log --graph"

git log -p -1
git log --stat --oneline I..C

git show xxxx --stat

#### git diff

比较tag A tag B  
git diff A B
比较工作区和 tag A
git diff A
比较暂存区 和 tag A
git diff --cached A
比较工作区和暂存区
git diff
比较暂存区和HEAD
git diff --cached
比较工作区和HEAD
git diff HEAD


#### git blame

git blame README
git blame -L 6,+5 README

#### git bisect

git bisect start
git bisect bad
git bisect good G
git bisect good
git describe
git bisect reset

如果错了
git bisect log >logfile

git bisect reset 
git bisect replay logfile

跑一个脚本
git bisect run sh good-or-bad.sh










