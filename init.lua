-- Set my theme
vim.cmd.colorscheme("habamax")

-- Set showing current and relative line numbers
vim.opt.number         = true
vim.opt.relativenumber = true

-- Show hidden characters
vim.opt.list           = true
vim.opt.listchars      = { eol = "$", tab = "→ ", space = "·", extends = ">", precedes = "<", trail = "▫" }
vim.opt.showbreak      = "↲"

-- Set locale to english UTF-8
vim.cmd.language("en_US.UTF-8")

-- Set nvim internal encoding
vim.opt.encoding = "utf-8"
if vim.fn.has("win32") then
    -- Use cp1251 (Windows Cyrillic) if not utf-8 when opening files
    vim.opt.fileencodings:remove { "latin1", "default" }
    vim.opt.fileencodings:append { "cp1251", }
end

-- Turn off annoying bell sound
vim.opt.belloff = "all"

--- Set tab options
-- Make \t appear as 8 spaces
vim.opt.tabstop     = 8
-- Allways indent by 4 when using tab. Every 8 spaces tab my potentially be used
vim.opt.softtabstop = 4
-- For > operator. Specifies amount of spaces added
vim.opt.shiftwidth  = 4
-- Always uses spaces even if tabs may be used.
vim.opt.expandtab   = true

-- Settings for Neovide

if vim.g.neovide then
    vim.opt.linespace = 0
end

-- Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        "tikhomirov/vim-glsl",
        enabled = true
    },
    {
        "rebelot/kanagawa.nvim",
        enabled = true,
        lazy = true
    },
    {
        "neovim/nvim-lspconfig",
        enabled = true
    }
}
require("lazy").setup(plugins)

-- Theme
require("kanagawa").setup({
    theme = "dragon"
})
vim.cmd.colorscheme("kanagawa")

-- LSP
local lspconfig = require("lspconfig")
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d',       vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d',       vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

lspconfig.glsl_analyzer.setup{}
lspconfig.lua_ls.setup{}
