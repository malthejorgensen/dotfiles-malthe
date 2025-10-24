### Hooks
We set `hooksPath` in the global `~/.gitconfig`. This makes it so that **hooks
in repositories are never run!**. So to ensure hooks in the invididual
repositories still work we have "shim" hooks that always call the hooks in the
local repository first. Then you can add any extra _global_ logic you'd like
after that initial call in the shims.

**References:**
- <https://github.com/pre-commit/pre-commit/issues/1198#issuecomment-547521278>

### Exit vim with non-zero (error) exit code
This is more of a `vim` tip but useful when you don't want to do that merge,
cherry-pick, interactive rebase or whatever it might be.

:cq
