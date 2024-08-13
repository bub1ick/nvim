vim.g.mapleader = " "
vim.g.localmapleader = "\\"
-- vim.keymap.del("n", "<C-t>")
vim.keymap.set("n", "<C-t>", vim.cmd.tabnew, {noremap = true,})
vim.keymap.set("n", "<C-q>", vim.cmd.tabclose, {noremap = true,})
vim.keymap.set("n", "<C-s>", vim.cmd.pop, {noremap = true,})

vim.keymap.set("i", "<C-b>", vim.lsp.buf.signature_help, {noremap = true,})
vim.keymap.set("n", "<Leader>s", vim.lsp.buf.signature_help, {noremap = true,})
