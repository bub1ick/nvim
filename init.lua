-- Visuals
--vim.o.guifont = "ProggyVector:h14:w0"
vim.cmd.highlight({ "Comment", "gui=italic" })
vim.opt.linespace = 0

-- Set showing current and relative line numbers
vim.opt.number         = true
vim.opt.relativenumber = true

-- Show hidden characters
vim.opt.list           = true
vim.opt.listchars      = { eol = "$", tab = "→ ", space = "·", extends = ">", precedes = "<", trail = "▫" }
vim.opt.showbreak      = "↲"

-- Set maximum line length
vim.opt.textwidth = 100
vim.opt.colorcolumn = "+5"

-- Set locale to english UTF-8
vim.cmd.language("en_US.UTF-8")

-- Set nvim internal encoding
vim.opt.encoding = "utf-8"
if vim.fn.has("win32") then
    -- Use cp1251 (Windows Cyrillic) if not utf-8 when opening files
    vim.opt.fileencodings:remove { "latin1", "default" }
    vim.opt.fileencodings:append { "cp1251", }
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
vim.opt.tabstop     = 8
-- Allways indent by 4 when using tab. Every 8 spaces tab may potentially be used
vim.opt.softtabstop = 4
-- For > operator. Specifies amount of spaces added
vim.opt.shiftwidth  = 4
-- Always uses spaces even if tabs may be used.
vim.opt.expandtab   = true

--- Netrw settings
vim.g.netrw_sort_by = "name"
-- When sorting by name, order in which to sort
vim.g.netrw_sort_sequence = "[\\/]$,\\.h$,\\.c$,\\.hpp$,\\.cpp$,*,\\.o$,\\.obj$,\\.info$,\\.swp$,\\.bak$,\\~$"
-- Disable the banner on top of the screen
vim.g.netrw_banner = 0
-- On "v" command in netrw open the file on the right
vim.g.netrw_altv = 1
-- By default use "short" listing (w/o timestamps and etc.)
vim.g.netrw_liststyle = 0
-- Preview on the right on "p"
vim.g.netrw_preview = 1
-- Syntax highlighting for special file extensions (not sure if it works at all)
vim.g.netrw_special_syntax = 1

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

-- Set completion options
vim.opt.completeopt = { "menu", "menuone", "popup", "noinsert" }

-- All custom mappings
require("mappings")

vim.cmd.colorscheme("moonfly")

--vim.lsp.config("clangd")
vim.lsp.enable("clangd")
