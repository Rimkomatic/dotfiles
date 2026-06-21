return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"saghen/blink.compat",
				optional = true,
				opts = {},
			},
		},
		opts_extend = {
			"sources.completion.enabled_providers",
			"sources.compat",
			"sources.default",
		},
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			keymap = {
				preset = "enter",
			},
			sources = {
				default = { "lazydev", "lsp", "snippets", "path", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			appearance = {
				use_nvim_cmp_as_default = false,
			},
			completion = {
				list = { selection = { preselect = false } },
				ghost_text = {
					enabled = false,
				},
				menu = {
					border = "single",
					scrollbar = false,

					draw = {
						treesitter = { "lsp" },
						columns = {
							{ "label", "label_description", gap = 2 },
							{ "kind_icon", "kind", gap = 2 },
						},
					},
				},
				documentation = {
					auto_show_delay_ms = 200,
					auto_show = true,
					window = {
						border = "rounded",
					},
				},
			},
			signature = {
				enabled = true,
				window = {
					border = "rounded",
					-- focusable = false,
				},
			},
		},
	},
	-- {
	-- 	"L3MON4D3/LuaSnip",
	-- 	dependencies = { "rafamadriz/friendly-snippets" },
	-- 	config = function()
	-- 		require("luasnip.loaders.from_vscode").lazy_load()
	-- 	end,
	-- },
	{
		"rafamadriz/friendly-snippets",
	},
	{
		"saghen/blink.compat",
		optional = true, -- make optional so it's only enabled if any extras need it
		opts = {},
	},
}
