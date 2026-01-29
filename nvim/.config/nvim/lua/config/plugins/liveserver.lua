return {
	"d-vegapunk/live-server.nvim",
	keys = {
		{
			"<leader>L",
			"<cmd>:LiveServerToggle<CR>",
			desc = "Toggle Live Server",
		},
	},
	-- build = "npm install -g live-server", -- Make sure you have Node.js
	config = function()
		require("live-server").setup({
			liveserver_args = {},
			integration = {
				lualine = {
					supported_filetypes = { "html", "css", "javascript", "javascriptreact" },
					icons = {
						disconnected = "✖",
						connected = "✔",
					},
					colors = {
						disconnected = "#559dd7", --blue
						connected = "#00c234", --green
					},
				},
			},
		})
	end,
	cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
}
