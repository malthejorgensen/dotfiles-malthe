#!/usr/bin/env fish

# Print difference `brew_list.txt` and actually installed formulas in Homebrew
diff (cat brew_list.txt | sed -E '/^#/d;/^$/d' | sort | psub) (brew leaves | sort | psub)
