# Git 里程碑

git tag
git tag -n1

git log --oneline --decorate

git describe

git name-rev HEAD
git name-rev HEAD --tags

创建tag

git tag
git tag -a
git tag -m [msg]


git tag mytag
git tag -l my*
git cat-file -t mytag
git cat-file -p mytag

git tag -m 'My first tag' mytag
git tag -l my* n1

git cat-file -t mytag2
git cat-file -p mytag2

git cat-file tag mytag2 |wc -c # 148

(printf "tag 148\000";git cat-file tag mytag2) | sha1sum
git rev-parse mytag2

# All same values
git rev-parse mytag2^{commit}
git rev-parse mytag2^{}
git rev-parse mytag2^0


删除tag

git tag -d mytag


共享tag
git ls-remote origin my*
git push origin mytag
git push origin refs/tags/*



更新
git tag -f -m "xxxx" mytag2 HEAD^


 删除远程tag
 git push origin :mytag2

git rev-parse mytag2~0