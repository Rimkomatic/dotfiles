return {
	{
		"echasnovski/mini.nvim",
		name = "mini",
		version = false,
		config = function()
			require("mini.pairs").setup()
			require("mini.indentscope").setup()
			require("mini.icons").setup()
			require("mini.surround").setup({
				mappings = {
					add = "a",
					delete = ",d",
					find = ",f",
					find_left = ",F",
					highlight = ",h",
					replace = ",r",
					update_n_lines = ",n",
					suffix_last = "l",
					suffix_next = "n",
				},
				n_lines = 20,
				respect_selection_type = false,
				search_method = "cover",
				silent = false,
			})

			local mini_files = require("mini.files")
			mini_files.setup({
				windows = {
					preview = true,
					width_focus = 30,
					width_preview = 50,
				},
				mappings = {
					close = "q",
					go_in = "<Right>",
					go_in_plus = "L",
					go_out = "<Left>",
					go_out_plus = "H",
					mark_goto = "'",
					mark_set = "m",
					reset = "<BS>",
					reveal_cwd = "@",
					show_help = "g?",
					synchronize = "=",
					trim_left = "<",
					trim_right = ">",
				},
			})

			vim.keymap.set("n", "<leader>mf", function()
				mini_files.open(vim.api.nvim_buf_get_name(0))
			end, { desc = "Mini Files" })

			-- Custom mappings inside mini.files
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					-- vertical split
					vim.keymap.set("n", "<leader>ov", function()
						vim.cmd("vsplit")
						local win_id = vim.api.nvim_get_current_win()
						require("mini.files").set_target_window(win_id)
						require("mini.files").go_in()
					end, { buffer = args.data.buf_id, desc = "Open file in vertical split" })

					-- horizontal split
					vim.keymap.set("n", "<leader>oh", function()
						vim.cmd("split")
						local win_id = vim.api.nvim_get_current_win()
						require("mini.files").set_target_window(win_id)
						require("mini.files").go_in()
					end, { buffer = args.data.buf_id, desc = "Open file in horizontal split" })
				end,
			})
		end,
	},
}
