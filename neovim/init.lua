-- FROM: https://medium.com/unixification/must-have-neovim-keymaps-51c283394070
function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Command mode on Space
Map("n", "<Space>", ":")
Map("v", "<Space>", ":")

-- Easily go to the beginning and of line
Map("n", ":", "$")
Map("n", "J", "^")

-- Home-row navigation
Map("n", "j", "h")
Map("n", "k", "j")
Map("n", "l", "k")
Map("n", ";", "l")
-- Danish
Map("n", "æ", "l")
Map("n", "-", "/")

Map("n", ",j", "J")

-- Window navigation (splits)
Map("n", "<C-W>j", "<C-W>h")
Map("n", "<C-W>k", "<C-W>j")
Map("n", "<C-W>l", "<C-W>k")
Map("n", "<C-W>;", "<C-W>l")
