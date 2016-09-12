# Git 分支

git branch
git branch `branchname`
git branch `branchname` `start-point`
git branch -d `branchname`
git branch -D `branchname`
git branch -m `oldbranchname` `newbranch`
git branch -M `oldbranchname` `newbranch`


git cherry 查看哪些提交领先

git branch -r

#### 远程版本库

git remote add new-remote file:///path/to/repos/hello.git
git remote -v
git fetch new-remote

git remote rename new-remote user2

git remote
origin
user2

git remote update

git remote rm user2