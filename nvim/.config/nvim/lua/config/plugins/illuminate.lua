return {
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			delay = 200,
			large_file_cutoff = 2000,
			large_file_overrides = {
				providers = { "lsp" },
			},
			filetypes_denylist = { "dirbuf", "dirvish", "fugitive" },
			under_cursor = true,
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
		keys = {
			{
				"<leader>i]",
				function()
					require("illuminate").goto_next_reference(false)
				end,
				desc = "Next Reference",
			},
			{
				"<leader>i[",
				function()
					require("illuminate").goto_prev_reference(false)
				end,
				desc = "Prev Reference",
			},
		},
	},
}
