vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

require("config.lazy")
require("chadrc")
require("colors")
require("keymap")
--require("/hime/rik/.config/nvim/plugin/floaterminal")

vim.opt.expandtab = true
vim.opt.shiftwidth = 0
vim.opt.tabstop = 4
vim.opt.softtabstop = 0

vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes:1"

vim.o.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

vim.keymap.set({ "n", "v" }, "d", '"_d')
vim.keymap.set({ "n", "v" }, "D", '"_D')

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yank a text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#393939" }) -- Inactive line numbers
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff" })

vim.diagnostic.config({
	virtual_text = true, -- Inline errors
	signs = true,
	underline = true,
	update_in_insert = false,
})

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true }) -- optional: scroll up with centering
-- For single statusline
vim.o.laststatus = 3 -- Required to make globalstatus work
vim.cmd([[highlight Visual guibg=#393939]])

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function(args)
		if vim.bo[args.buf].filetype == "mini.files" then
			-- Ensure tabline logic sees it as “not a regular buffer”
			vim.bo[args.buf].bufhidden = "wipe"
			vim.bo[args.buf].buflisted = false
		end
	end,
})

-- show only WARN / ERROR as virtual_text
vim.diagnostic.config({
	virtual_text = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	signs = true,
	underline = false,
	update_in_insert = true,
})
