## sudo gem install githug

-------
Name: rm_cached
Level: 12
Difficulty: **

A file has accidentally been added to your staging area, find out which file and remove it from the staging area.  *NOTE* Do not remove the file from the file system, only from git.

git rm --cached file

--------
level18

There are tags in the repository that aren't pushed into remote repository. Push them now.

git push --tags

-------
Name: commit_in_future
Level: 20
Difficulty: **

Commit your changes with the future date (e.g. tomorrow).

git commit --date=25.11.2016 -m 'feature'

-------
Name: repack
Level: 41
Difficulty: **

Optimise how your repository is packaged ensuring that redundant packs are removed.

git repack -d

-------

level46

Merge all commits from the long-feature-branch as a single commit.

git merge --squash long-feature-branch
git commit -m 'merge'