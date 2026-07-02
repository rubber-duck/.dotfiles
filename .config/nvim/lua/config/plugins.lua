-- ===== Plugins (managed by vim.pack) =====
-- vim.pack is Neovim's built-in package manager (0.12+). It clones missing
-- plugins from git on startup and records exact revisions in
-- ~/.config/nvim/nvim-pack-lock.json (commit that file to pin versions).
--   :lua vim.pack.update()    -> update plugins
--   :lua vim.pack.get()       -> inspect installed plugins
--   :lua vim.pack.del({...})  -> remove plugins

vim.pack.add({
  -- Colorscheme (matches the gruvbox tmux theme).
  -- Pinned to a personal fork so upstream can't change what we pull.
  -- Prerequisite: `gh repo fork ellisonleao/gruvbox.nvim --clone=false`
  { src = "https://github.com/rubber-duck/gruvbox.nvim" },

  -- Add more plugins here, e.g.:
  --   { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
})

-- ----- Colorscheme -----
-- No bold or italic styling anywhere (per preference).
require("gruvbox").setup({
  contrast = "hard",
  bold = false,
  italic = {
    strings = false,
    emphasis = false,
    comments = false,
    operators = false,
    folds = false,
  },
})
vim.o.background = "dark"
vim.cmd.colorscheme("gruvbox")
