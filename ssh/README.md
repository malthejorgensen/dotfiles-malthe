If you have `fish` and `ssh` dotfiles installed then

- `ssh-agent` should already be running
- all keys in `~/.ssh` should be picked up by `ssh-agent`

then all you need to do is run:

    ssh-keygen -t ed25519 -C "malthe.jorgensen@gmail.com"

and that key should already be picked up by `ssh-agent`.

If not see the full guide on Github: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

