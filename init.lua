function change_scale(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta 
end
function reset_scale()
	vim.g.neovide_scale_factor = 1.0
end
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
if vim.g.neovide then
	vim.o.guifont = "Cascadia Mono:h10"
	vim.opt.linespace = 0
	reset_scale()
	vim.keymap.set({"!"}, "<C-=>", function() change_scale(1.1) end)
	vim.keymap.set({"!"}, "<C-->", function() change_scale(1/1.1) end)
end
