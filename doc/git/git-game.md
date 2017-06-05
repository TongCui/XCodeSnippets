Level 1: ```$ git ls-files | xargs wc -l```

Level 2: ```$ git show *commit hash*```

Level 3: ```$ git shortlog```

Level 4: ```$ git describe```

Level 5: ```$ git log --pretty=format: ''tree hash: %t --> subject: %s'' ```

Level 6: ```$ git submodule init #then $ git submodule update```

Level 7: ```$ git grep "@hint" $(git rev-list history) ```

Level 8: ```$ git cherry-pick arachnid~4 insect~3```

Level 9: ```$ git bisect``` [Following the tutorial is best](http://www.metaltoad.com/blog/beginners-guide-git-bisect-process-elimination)

git log --all --full-history -- *message*



