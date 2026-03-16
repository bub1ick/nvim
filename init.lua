-- Visuals
vim.cmd.colorscheme("lunaperche")
if vim.fn.has("win32") then
    vim.o.guifont = "Cascadia_Mono:h11:w0"
end
vim.opt.linespace = 0

if vim.g.neovide then
	vim.g.neovide_position_animation_length = 0
	vim.g.neovide_cursor_animation_length = 0.00
	vim.g.neovide_cursor_trail_size = 0
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_scroll_animation_far_lines = 0
	vim.g.neovide_scroll_animation_length = 0.00
end

-- Set showing current and relative line numbers
vim.opt.number         = true
vim.opt.relativenumber = true

-- Show hidden characters
vim.opt.listchars = {
    eol = "$",
    tab = "→ ",
    space = "·",
    extends = ">",
    precedes = "<",
    trail = "▫"
}
vim.opt.showbreak = "↲"

-- Set maximum line length
--vim.opt.textwidth   = 100
vim.opt.colorcolumn = "80,100,120"

-- Set locale to english UTF-8
vim.cmd.language("en_US.UTF-8")

-- Set nvim internal encoding
vim.opt.encoding = "utf-8"
if vim.fn.has("win32") then
    -- Use cp1251 (Windows Cyrillic) if not utf-8 when opening files
    vim.opt.fileencodings:remove({ "latin1", "default" })
    vim.opt.fileencodings:append({ "cp1251", })
end

-- Add lang mapping
--                (        rus;eng  ),
vim.opt.langmap = "№;#," ..
--                (         rus;eng        ),
                  "йцукенгшщзхъ;qwertyuiop[]," ..
--                (         rus;eng        ),
                  "ЙЦУКЕНГШЩЗХЪ;QWERTYUIOP{}," ..
--                (        rus;eng          ),
                  "фывапролджэ;asdfghjkl\\;\'," ..
--                (        rus;eng          ),
                  "ФЫВАПРОЛДЖЭ;ASDFGHJKL:\\\"," ..
--                (      rus;eng       ),
                  "ячсмитьбю;zxcvbnm\\,.," ..
--                (      rus;eng     )
                  "ЯЧСМИТЬБЮ;ZXCVBNM<>"

-- Turn off annoying bell sound
vim.opt.belloff = "all"

--- Set tab options
-- Make \t appear as 8 spaces
vim.opt.tabstop     = 4
-- Allways indent by 4 when using tab. Every 8 spaces tab may potentially be used
vim.opt.softtabstop = 4
-- For > operator. Specifies amount of spaces added
vim.opt.shiftwidth  = 4
-- Always uses spaces even if tabs may be used.
vim.opt.expandtab   = true


-- Add working directory recursively
vim.opt.path:prepend("**")

-- Settings for C/C++
if vim.env.INCLUDE and vim.fn.has("win32") then
    -- Add include directory to path for easy go-to-file functionality
    local include_paths = vim.env.INCLUDE
    -- For some reason some paths have \\ in them. We need to replace them with single \
    include_paths = vim.fn.substitute(include_paths, "\\\\\\\\", "\\", "g") -- LMAO this \
    -- Replace \ with /
    include_paths = vim.fn.substitute(include_paths, "\\\\", "/", "g")
    -- Replace ; with ,
    include_paths = vim.fn.substitute(include_paths, ";", ",", "g")
    -- Replace <Space> with \\<Space>
    include_paths = vim.fn.substitute(include_paths, " ", "\\\\ ", "g")

    vim.opt.path:append(include_paths)
end

-- Set foldmethod
vim.opt.foldmethod = "syntax"
-- If supported by language server fold using it
vim.api.nvim_create_autocmd( 'LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method('textDocument/foldingRange') then
            vim.opt.foldmethod = "expr"
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end
    end,
})
-- Set completion options
vim.opt.completeopt = { "menu", "menuone", "popup", "noinsert", "fuzzy" }

-- Disable Netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- nvim-tree.lua
require("nvim-tree").setup({
    sync_root_with_cwd = true,
    view = {
        side = "left",
        width = {
            min = 20,
            max = 100,
        }
    },
    renderer = {
        add_trailing = true,
        group_empty = true,
    },
    git = {
        enable = false,
    }
})

-- All custom mappings
require("mappings")

-- Status Line construction
require("statusline")

vim.lsp.enable("clangd")
vim.lsp.enable("csharp-ls")

vim.cmd.packloadall()

-- Tree sitter configuration
vim.treesitter.language.register("html", "html")
vim.treesitter.language.register("css", "css")
vim.treesitter.language.register("javascript", "javascript")
vim.treesitter.language.register("c_sharp", "cs")
