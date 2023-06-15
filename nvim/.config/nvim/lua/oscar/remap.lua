--  Set Leader Key
vim.g.mapleader = " "

-- File Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Ctrl C acts like Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable Q in normal mode
vim.keymap.set("n", "Q", "<nop>")
