
iTerm2 stores it's preferences in `~/Library/Preferences/com.googlecode.iterm2.plist`
but doesn't allow symlinks or even hardlinks to function there (they're always
overwritten -- yes, even hardlinks).

The solution is to tell iTerm2 to store its preferences in `~/dotfiles/iTerm2`
(this directory).

See https://gitlab.com/gnachman/iterm2/-/issues/7921#note_1005276811 and observe
that the commit only fixes symlink behavior in the case where preferences are
stored in a custom location -- not when stored in the default location (as far
as I can tell).
