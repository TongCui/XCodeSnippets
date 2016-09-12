# Git 解决冲突

git pull # git fetch & git merge

git fetch
git merge refs/remotes/origin/master
git push

git log -1 -m --stat

git ls-files -s

当合并冲突发生后，会用到0以上的暂存区编号

git show :1:doc/README.txt
git show :2:doc/README.txt
git show :3:doc/README.txt

#### 树冲突

user1 git mv
user2 git mv

发生的冲突叫做树冲突

user1
git pull
git mv doc/README.txt readme.txt
git commit -m "xxx"
git push

user2
git pull
git mv doc/README.txt README
git commit -m "xxx"
git push # failed
git pull
git status
git ls-files -s
ls -l readme.txt README
git rm readme.txt
git rm doc/README.txt
git add README
git commit -m "xxx"
git push