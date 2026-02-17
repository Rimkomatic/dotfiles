return {
	"leath-dub/snipe.nvim",
	keys = {
		{
			"<leader><Tab>",
			function()
				require("snipe").open_buffer_menu()
			end,
			desc = "Open Snipe buffer menu",
		},
	},
	opts = {},
	config = function(_, opts)
		require("snipe").setup({
			ui = {
				---@type integer
				max_height = -1, -- -1 means dynamic height
				---@type "topleft"|"bottomleft"|"topright"|"bottomright"|"center"|"cursor"
				position = "center",
				---@type vim.api.keyset.win_config
				open_win_override = {
					title = "Open Buffers",
					border = "rounded", -- use "rounded" for rounded border
				},

				---@type boolean
				preselect_current = false,

				---@type nil|fun(buffers: snipe.Buffer[]): number
				preselect = nil, -- function (bs: Buffer[] [see lua/snipe/buffer.lua]) -> int (index)

				---@type "left"|"right"|"file-first"
				text_align = "left",

				buffer_format = { "icon", "filename" },
			},
			hints = {
				---@type string
				dictionary = "1234567890",
			},
			navigate = {
				next_page = "<Right>",
				prev_page = "<Left>",

				under_cursor = "<cr>",

				---@type string|string[]
				cancel_snipe = "<esc>",
				close_buffer = "d",
				open_vsplit = "v",
				open_split = "h",
				change_tag = "C",
			},
			sort = "default",
		})
	end,
}
