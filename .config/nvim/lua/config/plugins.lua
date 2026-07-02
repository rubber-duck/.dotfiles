-- ===== Plugins (managed by vim.pack) =====
-- vim.pack is Neovim's built-in package manager (0.12+). It clones missing
-- plugins from git on startup and records exact revisions in
-- ~/.config/nvim/nvim-pack-lock.json (commit that file to pin versions).
--   :lua vim.pack.update()  -> update plugins (or <leader>pu)
--   :lua vim.pack.get()     -> inspect installed plugins (or <leader>pl)
local map = vim.keymap.set

vim.pack.add({
  -- Colorscheme (matches the gruvbox tmux theme).
  -- Pinned to a personal fork so upstream can't change what we pull.
  -- Prerequisite: `gh repo fork ellisonleao/gruvbox.nvim --clone=false`
  { src = "https://github.com/rubber-duck/gruvbox.nvim" },

  -- Shared dependencies
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  -- UI
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },

  -- Editing
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
  { src = "https://github.com/windwp/nvim-autopairs" },

  -- Fuzzy finder
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = vim.version.range("0.1") },

  -- LSP + completion
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1") },
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

-- ----- Statusline -----
require("lualine").setup({
  options = { theme = "gruvbox", globalstatus = true, section_separators = "", component_separators = "" },
})

-- ----- File explorer -----
require("nvim-tree").setup({
  view = { width = 34 },
  renderer = { group_empty = true },
  filters = { dotfiles = false },
})
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

-- ----- Git signs -----
require("gitsigns").setup()
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview git hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
map("n", "]c", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next git hunk" })
map("n", "[c", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous git hunk" })

-- ----- Autopairs -----
require("nvim-autopairs").setup()

-- ----- Treesitter -----
-- Rebuild parsers whenever the plugin is installed or updated by vim.pack.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind ~= "delete" then
      vim.schedule(function() vim.cmd("TSUpdate") end)
    end
  end,
})
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vim", "vimdoc", "bash", "python", "javascript", "typescript", "json", "yaml", "toml", "markdown", "markdown_inline" },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})

-- ----- Telescope -----
local telescope = require("telescope.builtin")
map("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
map("n", "<leader>fg", telescope.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", telescope.buffers, { desc = "Find buffers" })
map("n", "<leader>fh", telescope.help_tags, { desc = "Help tags" })
map("n", "<leader>fr", telescope.oldfiles, { desc = "Recent files" })
map("n", "<leader>fd", telescope.diagnostics, { desc = "Diagnostics" })

-- ----- Completion -----
require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = { nerd_font_variant = "normal" },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
})

-- ----- LSP -----
require("mason").setup()

-- Add completion capabilities from blink.cmp to every server.
vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

-- Enable servers here. Install their binaries with :Mason.
vim.lsp.config("lua_ls", {
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
vim.lsp.enable({ "lua_ls" })

-- Buffer-local LSP keymaps, set once a server attaches.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
  callback = function(ev)
    local opts = function(desc) return { buffer = ev.buf, desc = desc } end
    map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
    map("n", "gr", vim.lsp.buf.references, opts("References"))
    map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
    map("n", "K", vim.lsp.buf.hover, opts("Hover documentation"))
    map("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
    map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts("Format buffer"))
    map("n", "[d", vim.diagnostic.goto_prev, opts("Previous diagnostic"))
    map("n", "]d", vim.diagnostic.goto_next, opts("Next diagnostic"))
  end,
})
