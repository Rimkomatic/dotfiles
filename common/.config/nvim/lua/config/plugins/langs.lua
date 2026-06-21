return {
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			completion = {
				cmp = { enabled = false }, -- Since you use blink.cmp
				blink = { enabled = true }, -- Enable blink.cmp integration!
			},
		},
		config = function(_, opts)
			require("crates").setup(opts)

			-- Optional: Keymaps for Cargo.toml
			local map = vim.keymap.set
			map("n", "<leader>cu", function()
				require("crates").upgrade_all_crates()
			end, { desc = "Upgrade all crates" })
			map("n", "<leader>cv", function()
				require("crates").show_versions_popup()
			end, { desc = "Show crate versions" })
		end,
	},
}
