-- ===== Editor options =====
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.termguicolors = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Files
opt.swapfile = false
opt.undofile = true

opt.clipboard = "unnamedplus"
opt.mouse = "a"
