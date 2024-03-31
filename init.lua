-- Set my theme
vim.cmd.colorscheme("habamax")
-- Set showing current and relative line numbers
vim.o.number         = true
vim.o.relativenumber = true
-- Show hidden characters
vim.o.list           = true
vim.opt.listchars    = { eol = "$", tab = "→ ", space = "·", extends = ">", precedes = "<", trail = "▫" }
vim.o.showbreak      = "↲"
-- Set locale to english UTF-8
vim.cmd.language("en_US.UTF-8")
-- Map the leader key
vim.g.mapleader = " "
-- Map <leader>w(orking)d(irectory) to open netrw in current directory
vim.keymap.set("n", "<leader>wd", vim.cmd.Ex)
vim.opt.fileencodings:remove { "latin1", "default" }
vim.opt.fileencodings:append { "cp1251", }
if vim.g.neovide then
	vim.o.guifont = "Cascadia Mono:h10"
	vim.opt.linespace = 0
end
