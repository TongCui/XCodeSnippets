# Git 改变历史

git commit --amend -m "Remove hello.h, which is useless"

还原删除的 src/hello.h

git checkout HEAD^ -- src/hello.h

git reset --soft HEAD^^

#### cherry pick

git checkout C
git cherry-pick master^
git cherry-pick master
git checkout master
git reset --hard HEAD@{1}

----------

git checkout D
git reset --soft HEAD^^
git commit -C C
git cherry-pick E
git cherry-pick F
git checkout master
git reset --hard HEAD@{1}

#### git rebase
git rebase --onto `<newbase>` `<since>` `<till>`

git rebase --onto C E^ F
git checkout master
git reset --hard HEAD@{1}

git rebase -i D^
git rebase -i C^