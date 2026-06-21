return {
	"nvim-pack/nvim-spectre",
	keys = {
		{
			"<leader>S",
			function()
				require("spectre").open()
			end,
			desc = "Spectre open",
		},
        {
			"<leader>sw",
			function()
                require("spectre").open_visual({select_word=true})
			end,
			desc = "Spectre open",
		},
        {
			"<leader>sp",
			function()
                require("spectre").open_file_search({select_word=true})
			end,
			desc = "Spectre open",
		},
	},
	config = function()
		require("spectre").setup({
			is_block_ui_break = true,
			open_cmd = "vnew", -- can be 'vnew' or 'new'
			live_update = true,
		})
	end,
}
