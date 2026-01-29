return {
	"chrisgrieser/nvim-chainsaw",
	opts = {
		visuals = {
			icon = "󰹈",
		},
		preCommitHook = {
			enabled = true,
			dontInstallInDirs = { "**/nvim-chainsaw" },
		},
		logStatements = {
			variableLog = {
				nvim_lua = "Chainsaw({{var}}) -- {{marker}}",
				lua = 'print("{{marker}} {{var}}: " .. hs.inspect({{var}}))',
			},
			assertLog = {
				lua = 'assert({{var}}, "")',
			},
			objectLog = {
				typescript = "new Notice(`{{marker}} {{var}}: ${{{var}}}`, 0)",
				zsh = 'osascript -e "display notification \\"{{marker}} ${{var}}\\" with title \\"{{var}}\\""',
				nvim_lua = "print({{var}}) -- {{marker}}",
			},
			clearLog = {
				lua = "hs.console.clearConsole() -- {{marker}}",
			},
			sound = {
				lua = 'hs.sound.getByName("Sosumi"):play() ---@diagnostic disable-line: undefined-field -- {{marker}}',
			},
		},
	},
	config = function(_, opts)
		require("chainsaw").setup(opts)
	end,
	keys = {
		{
			"<leader>lr",
			function()
				require("chainsaw").removeLogs()
			end,
			mode = { "n", "x" },
			desc = "󰅗 remove logs",
		},
		{
			"<leader>ll",
			function()
				require("chainsaw").variableLog()
			end,
			mode = { "n", "x" },
			desc = "󰀫 variable",
		},
		{
			"<leader>lo",
			function()
				require("chainsaw").objectLog()
			end,
			mode = { "n", "x" },
			desc = "⬟ object",
		},
		{
			"<leader>lt",
			function()
				require("chainsaw").typeLog()
			end,
			mode = { "n", "x" },
			desc = "󰜀 type",
		},
		{
			"<leader>lc",
			function()
				require("chainsaw").clearLog()
			end,
			desc = "󰃢 clear console",
		},
	},
}
