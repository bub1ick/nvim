vim.g.mapleader = " "
vim.g.localmapleader = "\\"

-- Tab remaps
vim.keymap.set("n", "<C-t>", vim.cmd.tabnew, {noremap = true,})
vim.keymap.set("n", "<C-q>", vim.cmd.tabclose, {noremap = true,})
vim.keymap.set("n", "<C-s>", vim.cmd.pop, {noremap = true,})

-- Window Resizing
vim.keymap.set("n", "<S-Left>",  "<C-w><", {noremap = true,})
vim.keymap.set("n", "<S-Right>", "<C-w>>", {noremap = true,})
vim.keymap.set("n", "<S-Up>",    "<C-w>+", {noremap = true,})
vim.keymap.set("n", "<S-Down>",  "<C-w>-", {noremap = true,})

-- Toggle hidden characters
vim.keymap.set("n", "<Leader>l", function() vim.opt.list = not vim.opt.list:get() end, {noremap = true,})

-- Change working directory to that of current file's directory
vim.keymap.set("n", "<Leader>cd",  ":cd %:p:h<CR>:pwd<CR>", {noremap = true,})
vim.keymap.set("n", "<Leader>tcd", ":tcd %:p:h<CR>:pwd<CR>", {noremap = true,})
vim.keymap.set("n", "<Leader>lcd", ":lcd %:p:h<CR>:pwd<CR>", {noremap = true,})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.keymap.set("n", "<Leader>s", vim.lsp.buf.signature_help,       {noremap = true,})
        vim.keymap.set("n", "<F2>",      vim.lsp.buf.rename,               {noremap = true,})
        vim.keymap.set("n", "gD",        vim.lsp.buf.declaration,          {noremap = true,})
        vim.keymap.set("n", "gd",        vim.lsp.buf.definition,           {noremap = true,})
        vim.keymap.set("n", "<F12>",     vim.lsp.buf.type_definition,      {noremap = true,})
        vim.keymap.set("n", "<Leader>f", vim.lsp.buf.workspace_symbol,     {noremap = true,})
        vim.keymap.set("n", "<Leader>o", vim.cmd.ClangdSwitchSourceHeader, {noremap = true,})
        vim.keymap.set(
            "n", "<Leader>k",
            function()
                local id = args.data.client_id
                local client = vim.lsp.get_client_by_id(id)
                client:stop()
            end,
            {noremap = true}
        )
        vim.keymap.set(
            "n", "<Leader>i",
            function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end,
            {noremap = true,}
        )
    end,
})

-- nvim-tree
local nvim_tree_api = require("nvim-tree.api")
vim.keymap.set(
    "n", "<Leader>p",
    function()
        nvim_tree_api.tree.toggle({find_file = true,})
    end,
    {noremap = true,}
)

-- Neovide keymaps
if vim.g.neovide then
    vim.g.neovide_fullscreen = false
    local toggle_fullscreen = function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end

    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor or 1.0
    local change_scale = function (delta)
        local default = 1.0
        local scales = {0.25, 0.33, 0.5, 0.67, 0.75, 0.8, 0.9, 1.0, 1.1, 1.25, 1.33, 1.4, 1.5, 1.75, 2.0}

        if delta == 0 then
            vim.g.neovide_scale_factor = default
            return
        end

        local current = vim.g.neovide_scale_factor
        local index = 1

        for i, step in ipairs(scales) do
            if step >= current then
                index = i
                break
            end
            index = 1
        end

        index = math.max(1, math.min(#scales, index + delta))
        vim.g.neovide_scale_factor = scales[index]
    end

    vim.keymap.set("l", "<F11>", toggle_fullscreen, {noremap = true})
    vim.keymap.set( "", "<F11>", toggle_fullscreen, {noremap = true})

    vim.keymap.set( "", "<C-=>", function() change_scale(1)  end, {noremap = true})
    vim.keymap.set( "", "<C-->", function() change_scale(-1) end, {noremap = true})
    vim.keymap.set( "", "<C-0>", function() change_scale(0)  end, {noremap = true})
    vim.keymap.set("l", "<C-=>", function() change_scale(1)  end, {noremap = true})
    vim.keymap.set("l", "<C-->", function() change_scale(-1) end, {noremap = true})
    vim.keymap.set("l", "<C-0>", function() change_scale(0)  end, {noremap = true})
end
