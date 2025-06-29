Jujutsu `jj` -- a new DVCS
==========================

Jujutsu auto-tracks **everything** in the repository, and thus does not deal
well with messy repositories.

See:
- https://github.com/jj-vcs/jj/issues/323
- https://github.com/jj-vcs/jj/issues/3493
- https://jj-vcs.github.io/jj/prerelease/FAQ/#how-can-i-keep-my-scratch-files-in-the-repository-without-committing-them

First, turn off auto-tracking (this is already in my config)

    jj config set --user snapshot.auto-track 'none()'

Then in the repository untrack all the newly added files:

    for f in (jj status | grep '^A ' | cut -d ' ' -f 2)
        jj file untrack "$f"
    end
