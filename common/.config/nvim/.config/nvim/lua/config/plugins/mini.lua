return {
	{
		"echasnovski/mini.nvim",
		name = "mini",
		version = false,

		keys = {
			{
				"<leader>mf",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0))
				end,
				desc = "Mini Files",
			},
		},

		event = "VeryLazy",

		config = function()
			require("mini.pairs").setup()
			require("mini.indentscope").setup()
			require("mini.icons").setup()

			require("mini.sessions").setup({
				autoread = false,
				autowrite = false,
				directory = vim.fn.stdpath("state") .. "/sessions",
				file = "",
			})

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
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					vim.keymap.set("n", "<leader>ov", function()
						vim.cmd("vsplit")
						local win_id = vim.api.nvim_get_current_win()
						require("mini.files").set_target_window(win_id)
						require("mini.files").go_in()
					end, { buffer = args.data.buf_id })

					vim.keymap.set("n", "<leader>oh", function()
						vim.cmd("split")
						local win_id = vim.api.nvim_get_current_win()
						require("mini.files").set_target_window(win_id)
						require("mini.files").go_in()
					end, { buffer = args.data.buf_id })
				end,
			})

			----------------------------------------------------------------
			-- Tmux Session Integration
			----------------------------------------------------------------

			local function get_tmux_session()
				if vim.env.TMUX == nil then
					return nil
				end

				-- Formats the string as: SessionName_WindowIndex_PaneIndex
				local session = vim.fn.system("tmux display-message -p '#S_#I_#P'"):gsub("\n", "")

				if session == "" then
					return nil
				end

				return session
			end
			vim.api.nvim_create_user_command("TmuxSessionSave", function()
				local session = get_tmux_session()

				if not session then
					vim.notify("Not inside tmux", vim.log.levels.WARN)
					return
				end

				require("mini.sessions").write(session)
				vim.notify("Saved session: " .. session, vim.log.levels.INFO)
			end, {})

			vim.api.nvim_create_user_command("TmuxSessionLoad", function()
				local session = get_tmux_session()

				if not session then
					vim.notify("Not inside tmux", vim.log.levels.WARN)
					return
				end

				local ok = pcall(function()
					require("mini.sessions").read(session)
				end)

				if ok then
					vim.notify("Loaded session: " .. session, vim.log.levels.INFO)
				else
					vim.notify("No session found: " .. session, vim.log.levels.WARN)
				end
			end, {})

			vim.keymap.set("n", "<leader>ss", "<cmd>TmuxSessionSave<CR>", {
				desc = "Save tmux session",
			})

			vim.keymap.set("n", "<leader>sl", "<cmd>TmuxSessionLoad<CR>", {
				desc = "Load tmux session",
			})

			vim.defer_fn(function()
				local session = get_tmux_session()

				if session then
					pcall(function()
						require("mini.sessions").read(session, { force = true })
					end)
				end
			end, 100)
		end,
	},
}
