vim.g.mapleader = " "

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("n", "<leader>oi", ":Oil <CR>")

vim.keymap.set("n", "<C-w><Up>", "<C-w>k") -- Move up
vim.keymap.set("n", "<C-w><Down>", "<C-w>j") -- Move down
vim.keymap.set("n", "<C-w><Left>", "<C-w>h") -- Move left
vim.keymap.set("n", "<C-w><Right>", "<C-w>l") -- Move right

vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")

-- GO TO A FILE
vim.keymap.set("n", "<leader>gtf", function()
	local file = vim.fn.expand("<cfile>")
	if vim.fn.filereadable(file) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(file))
	else
		vim.notify("File not found: " .. file, vim.log.levels.WARN)
	end
end, { desc = "Go to file under cursor" })

-- DEFINATION AND IMPLEMNTATION
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show Hover" })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to Implementation" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Show References" })
