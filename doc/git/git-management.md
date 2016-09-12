# Git库管理

git show-ref

find .git/refs/ -type f
git pack-refs --all
find .git/refs/ -type f
head -5 .git/packed-refs

git fsck
git prune
git gc