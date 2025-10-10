vim.g.mapleader = " "
vim.g.localmapleader = "\\"

-- Tab remaps
vim.keymap.set("n", "<C-t>", vim.cmd.tabnew, {noremap = true,})
vim.keymap.set("n", "<C-q>", vim.cmd.tabclose, {noremap = true,})
vim.keymap.set("n", "<C-s>", vim.cmd.pop, {noremap = true,})

vim.keymap.set("n", "<S-Left>",  "<C-w><", {noremap = true,})
vim.keymap.set("n", "<S-Right>", "<C-w>>", {noremap = true,})
vim.keymap.set("n", "<S-Up>",    "<C-w>+", {noremap = true,})
vim.keymap.set("n", "<S-Down>",  "<C-w>-", {noremap = true,})

vim.keymap.set("n", "<Leader>l", function() vim.opt.list = not vim.opt.list:get() end, {noremap = true,})

-- LSP
vim.api.nvim_create_autocmd( "LspAttach", {
    callback = function(args)
        vim.keymap.set("n", "<Leader>s", vim.lsp.buf.signature_help,       {noremap = true,})
        vim.keymap.set("n", "<Leader>i", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, {
            noremap = true,
        })
        vim.keymap.set("n", "<F2>",      vim.lsp.buf.rename,               {noremap = true,})
        vim.keymap.set("n", "gD",        vim.lsp.buf.declaration,          {noremap = true,})
        vim.keymap.set("n", "gd",        vim.lsp.buf.definition,           {noremap = true,})
        vim.keymap.set("n", "<F12>",     vim.lsp.buf.type_definition,      {noremap = true,})
        vim.keymap.set("n", "<Leader>f", vim.lsp.buf.workspace_symbol,     {noremap = true,})
        vim.keymap.set("n", "<Leader>o", vim.cmd.ClangdSwitchSourceHeader, {noremap = true,})
        vim.keymap.set("n", "<Leader>t", function()
                local id = args.data.client_id
                local client = vim.lsp.get_client_by_id(id)
                client:stop()
            end, {
            noremap = true
        })
    end,
})

-- Neovide keymaps
if vim.g.neovide then
    vim.g.neovide_fullscreen = false
    local toggle_fullscreen = function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end
    vim.keymap.set("!", "<F11>", toggle_fullscreen, {noremap = true})
    vim.keymap.set( "", "<F11>", toggle_fullscreen, {noremap = true})
end
