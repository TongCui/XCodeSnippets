# Git 重置

git reset --hard HEAD^

git config core.logallrefupdates # true

git reflog show ba-5317-usage-history-automation

重置master 为两次改变之前的值
git reset --hard master@{2}

```
git reset [--soft | --mixed | --head] [<commit>]
```

@1 替换引用的指向
@2 替换暂存区
@3 替换工作区

--hard 
  @1， @2， @3

--soft
  @1

--mixed
  @1, @2

git reset
git reset HEAD
git reset -- filename # git add filename  的逆操作
git reset --soft HEAD^
git reset --hard HEAD^



