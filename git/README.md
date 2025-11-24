## Hooks
We set `hooksPath` in the global `~/.gitconfig`. This makes it so that **hooks
in repositories are never run!**. So to ensure hooks in the invididual
repositories still work we have "shim" hooks that always call the hooks in the
local repository first. Then you can add any extra _global_ logic you'd like
after that initial call in the shims.

**References:**
- <https://github.com/pre-commit/pre-commit/issues/1198#issuecomment-547521278>

### Currently used hooks (non-shims)
- `pre-push`: Checks for "!", "fixup" and "WIP" in commits before pushing

## Tips & Tricks

### Exit vim with non-zero (error) exit code
To exit vim with a non-zero exit code, enter the command:

    :cq<Enter>

This is more of a `vim` tip but useful when you don't want to do that merge,
cherry-pick, interactive rebase or whatever it might be.

### How do I reformat all commits on a branch?

```bash
git rebase \
  --strategy-option=theirs \
  --exec '<formatting/linting command here>; git add --update; git commit --amend --no-edit' <base branch, e.g. "main" or "master">
```

**WARNING:** Using `cd <some directory` in `--exec` is _really_ dangerous. It will somehow
remove all files from the commit and you can't use `git rebase --abort` to get out.
If you end up in this situation do `git add (git ls-tree -r --name-only main)` and
then `git rebase --abort`. But maybe start by not getting into that situation in
the first place (by keeping `cd`) out of your `--exec`.

See: https://stackoverflow.com/questions/76945493/how-do-i-format-all-commits-in-a-branch/76945494#76945494

## Git internals (advanced)

### How do I read files in `.git/objects`?
Do

  git cat-file -p <hash>
