-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("v", "y", [["+y]], { desc = "Yank visual selection to system clipboard" })
vim.keymap.set("v", "p", [["+p]], { desc = "Paste system clipboard over visual selection" })
