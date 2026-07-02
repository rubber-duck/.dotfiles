-- ===== Neovim config entrypoint =====
-- Plugins are managed by vim.pack, Neovim's built-in package manager (0.12+).
-- No bootstrap step required: vim.pack.add clones missing plugins on startup.

-- Leader keys must be set before any plugin or keymap is loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.plugins")
