# Git基本操作

git stash
git stash apply

git rm xxx

git ls-files --with-tree=HEAD^

git cat-file -p HEAD^:welcome.txt

git add -u

### 恢复删除的文件

git cat-file -p HEAD~1:welcome.txt > welcome.txt

git show HEAD~1:welcome.txt > welcome.txt

git checkout HEAD~1 -- welcome.txt

git describe

git log --oneline --decorate -4

#### .gitignore

git config --global core.excludesfile /home/jiangxin/.gitigonre
git config core.excludesfile