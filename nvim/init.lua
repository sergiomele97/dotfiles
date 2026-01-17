-- Basic Neovim config

-- Sets
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

-- Remaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.CMD.Ex)

-- Basic search highlighting
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

print("🚀 Neovim de Sergio cargado!")
