-- Set my theme
local bamboo_theme = require("bamboo")
bamboo_theme.setup({style = "multiplex", })
bamboo_theme.load()

-- Make comments italisized
vim.cmd.highlight({ "Comment", "gui=italic" })

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
    include_paths = vim.fn.substitute(include_paths, "\\\\", "\\", "g")
    -- Replace \ with /
    include_paths = vim.fn.substitute(include_paths, "\\", "/", "g")
    -- Replace ; with ,
    include_paths = vim.fn.substitute(include_paths, ";", ",", "g")
    -- Replace <Space> with \\<Space>
    include_paths = vim.fn.substitute(include_paths, " ", "\\\\ ", "g")

    vim.opt.path:append(include_paths)
end

-- Settings for Neovide

if vim.g.neovide then
    vim.opt.linespace = 0
end

