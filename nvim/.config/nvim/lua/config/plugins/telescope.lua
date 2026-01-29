return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "echasnovski/nvim-web-devicons", lazy = true },
			{
				"nvim-telescope/telescope-frecency.nvim",
				version = "*",
				config = function()
					require("telescope").load_extension("frecency")
				end,
			},
		},
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					prompt_title = "Find Files ",
					prompt_prefix = "  󱐋 ",
					selection_caret = "  ",
					entry_prefix = "  ",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							preview_width = 0.6,
							results_width = 0.4,
						},
						height = 0.8,
						width = 0.9,
						preview_cutoff = 120,
						prompt_position = "top",
					},
					border = {},
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
				},
				pickers = {
					find_files = {
						prompt_title = "Find Files ",
						previewer = true,
						layout_config = {
							preview_width = 0.6,
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					frecency = {
						db_safe_mode = false,
						auto_validate = true,
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("frecency")

			-- Keymaps
			vim.keymap.set("n", "<leader>fh", function()
				require("telescope.builtin").help_tags({ prompt_title = "Help Tags " })
			end)

			vim.keymap.set("n", "<leader>ff", "<cmd>Telescope frecency workspace=CWD<cr>", { desc = "Find Files " })

			vim.keymap.set("n", "<leader>fc", function()
				require("telescope.builtin").find_files({
					prompt_title = "Find Config ",
					cwd = vim.fn.stdpath("config"),
				})
			end)

			vim.keymap.set("n", "<leader>fp", function()
				require("telescope.builtin").find_files({
					prompt_title = "Find Plugins ",
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
				})
			end)

			vim.keymap.set("n", "<leader>fr", function()
				require("telescope.builtin").oldfiles({ prompt_title = "Recent Files " })
			end)

			vim.keymap.set("n", "<leader>fb", function()
				require("telescope.builtin").buffers({ prompt_title = "Buffers " })
			end)

			require("config.telescope.multigrep").setup()
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}

