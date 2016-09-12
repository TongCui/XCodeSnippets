# Git 对象

提交 commit
文件内容 blob
目录树 tree

git cat-file -t xxx
git cat-file -p xxx


find .git -name master -o -name HEAD

git rev-parse master
git rev-parse refs/heads/master
git rev-parse HEAD

如何计算 哈希值

git cat-file commit master

```
Equal:


git cat-file commit HEAD |wc -c  #234

(printf "commit 234\000" ; git cat-file commit HEAD) | sha1sum

git rev-parse HEAD

```

git cat-file blob HEAD:welcome.txt


Git 提供了很多方法可以方便地访问Git库中的对象

1. 采用部分SHA1哈希值  4位以上
2. master = refs/heads/master = heads/master
3. HEAD 代表最近一次提交
4. ^代表版本库的上一次提交，也就是最近一次提交的父提交
    HEAD^
    HEAD^^
    a1234^2
    HEAD^1
5. ~<n> 代表父提交
6. 树对象 
    a12314^{tree}
7. 某一次提交对应的文件
    a123124:path/to/file
8. 缓存区的文件对象
    :path/to/file
    git cat-file blob :APIV1/NSArray+AATool.m










