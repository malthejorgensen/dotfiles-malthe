function wk
    if test (count $argv) -ge 1 -a "$argv[1]" = delete
        # `tee /dev/stderr` mirrors output to terminal while still capturing it; `[-1]` grabs the last line (the repo root)
        set repo_root (wk_impl delete | tee /dev/stderr)[-1] && cd $repo_root
    else
        # `tee /dev/stderr` mirrors output to terminal while still capturing it; `[-1]` grabs the last line (the worktree path)
        set wt (wk_impl $argv | tee /dev/stderr)[-1] && cd $wt
    end
end
