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
