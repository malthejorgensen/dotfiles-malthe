#
# Defines Malthes custom stuff
#
# Authors:
#   Malthe Jørgensen <malthe.jorgensen@gmail.com>
#

# Ensure 256 colors in vim and tmux
export TERM="xterm-256color"

# Force UTF8 in `less`
export LESSCHARSET='utf-8'

# Fix tmux
export LANG='en_US.UTF-8'
#

# autocd is a nice convenience. But it shadows binaries with the same name
# - and because of that; can be confusing
unsetopt autocd


# In tmux one often accidentally hits Ctrl-S. This freezes the screen. You can
# get it back by pressing Ctrl-Q. But... why even have the functionality in the
# first place?
# http://stackoverflow.com/questions/17991007/how-to-disable-keybinding-in-tmux
stty -ixon
stty stop undef

#
# Aliases
#

# Don't overwrite by default
alias mv='mv -i'
alias cp='cp -i'

# EZ-move: "duck it and move it"
autoload -U zmv
alias mmv='noglob zmv -W'

# X clipboard
alias xclip='xclip -selection clipboard'
alias xsel='xsel -b'

# `open` == `xdg-open` on Linux
if which xdg-open 2>&1 > /dev/null
then
  alias open='xdg-open'
fi

# Force color in the Silver Searcher
alias ag='ag --color'

#
# Functions
#

# Sensible trashing
rm() {
  # On OS X just use the plugin from oh-my-zsh to trash stuff
  if [ $(uname) = 'Darwin' ]; then
    trash $@
  # Otherwise, try to move it to the ~/trash directory
  else
    if [ -d $HOME/trash ]; then
      mv $@ $HOME/trash
    else
      echo "'$HOME/trash' does not exist, or is not a directory"
    fi
  fi
}

# Convienience function for restarting the shell
reshell() {
  exec $SHELL
}

# head that separates on NUL characters (\0) instead of newlines
head0() {
  mawk 'BEGIN {RS="\0"}; {print}' | head $@ | mawk 'BEGIN {ORS="\0"}; {print}'
}

#
# Source module files
#
source "${0:h}/vim.zsh"
