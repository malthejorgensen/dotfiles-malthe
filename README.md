dotfiles-malthe
===============
My hand-written dotfile setup.

Boostrapping a Macbook
----------------------
1. Install Homebrew
2. Set up an SSH key on Github
   - https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
   - https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

3. Install Homebrew packages:  
   `cat brew_list.txt | grep -v '^#' | grep -v '^$' | xargs -n1 brew install` 

4. Enable `fish` as a system shell:
   echo /opt/homebrew/bin/fish | tee -a /etc/shells

4. Switch to `fish` as the system shell:
   `chsh -s /opt/homebrew/bin/fish`

Install
-------

    cd ~
    git clone git@github.com:malthejorgensen/dotfiles-malthe.git dotfiles
    python install.py

Alternatives
------------

**chezmoi**  
I tried chezmoi and it immediately deleted a bunch of my files.
So that was a no-go.
