return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			notifier = { enabled = true },

			scroll = {
				animate = {
					duration = { step = 15, total = 250 },
					easing = "linear",
				},
				enabled = true,
				animate_repeat = {
					delay = 100,
					duration = { step = 5, total = 50 },
					easing = "linear",
				},
				filter = function(buf)
					return vim.g.snacks_scroll ~= false
						and vim.b[buf].snacks_scroll ~= false
						and vim.bo[buf].buftype ~= "terminal"
				end,
			},

			zen = {
				zoom = {
					win = {
						backdrop = false,
						width = 0,
					},
				},
			},

			dashboard = {
				enabled = true,
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = function()
								require("telescope.builtin").find_files()
							end,
						},
						{
							icon = " ",
							key = "n",
							desc = "New File",
							action = ":ene | startinsert",
						},
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = function()
								require("telescope.builtin").live_grep()
							end,
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = function()
								require("telescope.builtin").oldfiles()
							end,
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = function()
								require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
							end,
						},
						{
							icon = " ",
							key = "x",
							desc = "Restore Session",
							action = function()
								require("mini.sessions").select()
							end,
						},
						{
							icon = "󰒲 ",
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{
							icon = " ",
							key = "q",
							desc = "Quit",
							action = ":qa",
						},
					},
					header = [[
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⠤⠄⣀⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠒⠁⠀⠠⣶⣿⣿⣿⣿⢿⡶⣶⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣶⠟⠛⠓⠆⠙⠁⠉⠀⠀⠀⠀⠐⠸⣾⠿⡦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⢀⣠⢴⡾⡻⢖⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⠷⢀⡄⢀⠈⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠰⣟⣅⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡤⠍⢥⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⣠⡜⠛⠂⠀⠀⠀⠀⣀⣄⣠⣤⣤⠤⢠⢄⣮⠤⠴⠦⠀⠀⠀⠀⠀⠑⠌⠀⢓            
        ⠀⠀⠀⠀⠰⠉⠀⠀⠀⠀⠀⠀⠈⡉⠀⠀⠁⠀⣉⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⣿           
        ⠀⠀⠀⠀⠠⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣟          
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣤⣴⣐⣀⣤⣾⣿⣷⡿⣧⣤⣶⣭⣽⣿⡆⠀⠀⠀⠀⠀⠀⣰⣿          
        ⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡯⠛⠛⠛⢺⣿⣿⣿⣿⣿⠑⠀⠀⠀⠀⠀⠀⠿           
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢘⠫⣺⣿⣿⣿⣿⣷⣄⠀⠀⢸⣿⣿⣿⣿⡋⡤⠄⠀⠀⠀⠀⠀⠀           
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⢉⢿⣿⣿⡟⠟⣭⡤⠀⢝⢛⣽⣿⢯⢳⡐⠉⠀⠀⠀⠀⠀⠀⠄⠀⢀⠀⠀⠀⠀⠀⠀⠀ 
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⢋⣿⣿⣿⣿⣤⣤⣬⣽⣿⣿⣟⣶⢳⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠊⢀⣿⣿⣿⣿⣿⣿⣿⡛⣻⣿⣿⢿⠲⠂⠀⠀⠀⢘⣿             
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣽⣍⣙⠙⢛⣿⣿⡏⢛⣕⡢⠀⠁⠀⣀⠀⠀⣼              
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣷⣼⣿⣯⣼⣿⣿⣆⣀⣤⣾⣿⣄⠀               
        ]],
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1 },
					-- { title = "Recent Files", section = "recent_files", cwd = true, indent = 2, padding = { 2, 2 } },
					{ section = "startup" },
				},
			},
		},

		keys = {
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>Z",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom",
			},
			{
				"<leader>n",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>cR",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
				mode = { "n", "v" },
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
		},

		styles = {
			notifier = {
				border = "rounded",
				zindex = 100,
				ft = "markdown",
				wo = {
					winblend = 5,
					wrap = false,
					conceallevel = 2,
					colorcolumn = "",
				},
				bo = { filetype = "snacks_notif" },
			},

			zen = {
				enter = true,
				fixbuf = false,
				minimal = true,
				width = 120,
				height = 0,
				backdrop = { transparent = true, blend = 40 },
				keys = { q = false },
				zindex = 40,
				wo = {
					winhighlight = "NormalFloat:Normal",
				},
				w = {
					snacks_main = true,
				},
			},
		},
	},
}
