return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettierd" },
				css = { "prettier" },
				json = { "prettier" },
				go = { "gofumpt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				java = { "google-java-format" },
				php = { "phpcbf" },
				bash = { "shfmt" },
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = false,
			},
		},
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format()
				end,
				desc = "Code Format",
			},
		},
	},
}
