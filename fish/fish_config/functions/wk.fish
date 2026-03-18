function wk
    # `tee /dev/stderr` mirrors output to terminal while still capturing it; `[-1]` grabs the last line (the worktree path)
    set wt (wk_impl $argv | tee /dev/stderr)[-1] && cd $wt
end
