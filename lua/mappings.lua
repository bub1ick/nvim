vim.g.mapleader = " "
vim.g.localmapleader = "\\"

-- Tab remaps
vim.keymap.set("n", "<C-t>", vim.cmd.tabnew, {noremap = true,})
vim.keymap.set("n", "<C-q>", vim.cmd.tabclose, {noremap = true,})
vim.keymap.set("n", "<C-s>", vim.cmd.pop, {noremap = true,})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.keymap.set("n", "<Leader>h",  vim.lsp.buf.signature_help,       {noremap = true,})
        vim.keymap.set("!", "<C-h>",      vim.lsp.buf.signature_help,       {noremap = true,})
        vim.keymap.set("n", "<F2>",       vim.lsp.buf.rename,               {noremap = true,})
        vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,          {noremap = true,})
        vim.keymap.set("n", "gd",         vim.lsp.buf.definition,           {noremap = true,})
        vim.keymap.set("n", "gi",         vim.lsp.buf.implementation,       {noremap = true,})
        vim.keymap.set("n", "<F12>",      vim.lsp.buf.type_definition,      {noremap = true,})
        vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action,          {noremap = true,})
        vim.keymap.set("n", "<Leader>r",  vim.lsp.buf.references,           {noremap = true,})
        vim.keymap.set("n", "<Leader>s",  vim.lsp.buf.workspace_symbol,     {noremap = true,})
        vim.keymap.set("n", "<Leader>o",  vim.cmd.ClangdSwitchSourceHeader, {noremap = true,})
    end,
})

-- Neovide keymaps
if vim.g.neovide then
    vim.g.neovide_fullscreen = false
    toggle_fullscreen = function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end
    vim.keymap.set("!", "<F11>", toggle_fullscreen, {noremap = true})
    vim.keymap.set( "", "<F11>", toggle_fullscreen, {noremap = true})
end
