vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.showbreak = "↪ "
opt.termguicolors = true

opt.ignorecase = true
opt.smartcase = true
vim.opt.clipboard = "unnamedplus"

opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8

opt.undofile = true
opt.swapfile = false
opt.backup = false

opt.conceallevel = 2
opt.concealcursor = "nc"

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
