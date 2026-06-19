return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"j-hui/fidget.nvim",
	},
	config = function()
		require("codecompanion").setup({
			adapters = {
				acp = {
					opts = {
						show_presets = false,
					},
				},
				http = {
					opts = {
						show_presets = false,
					},
					qwen3_coder = function()
						return require("codecompanion.adapters").extend("ollama", {
							name = "qwen3_coder",
							schema = {
								model = {
									default = "qwen3-coder:30b",
								},
							},
						})
					end,

					qwen3_14b = function()
						return require("codecompanion.adapters").extend("ollama", {
							name = "qwen3_14b",
							schema = {
								model = {
									default = "qwen3:14b",
								},
							},
						})
					end,

					qwen25_coder = function()
						return require("codecompanion.adapters").extend("ollama", {
							name = "qwen25_coder",
							schema = {
								model = {
									default = "qwen2.5-coder:14b",
								},
							},
						})
					end,

					gpt_oss = function()
						return require("codecompanion.adapters").extend("ollama", {
							name = "gpt_oss",
							schema = {
								model = {
									default = "gpt-oss:20b",
								},
							},
						})
					end,
				},
			},

			strategies = {
				chat = {
					adapter = "qwen3_coder",
				},
				inline = {
					adapter = "qwen25_coder",
				},
			},
			-- ... the rest of your config remains the same
			interactions = {
				chat = {
					opts = {
						completion_provider = "blink", -- blink|cmp|coc|default
					},
				},
			},
			display = {
				chat = {
					show_settings = false,
					window = {
						layout = "vertical",
						width = 0.3,
						height = 0.8,
					},
				},
				action_palette = {
					width = 45,
					height = 10,
					prompt = "Prompt ",
					provider = "telescope",
					opts = {
						show_preset_actions = true,
						show_preset_prompts = true,
						title = "CodeCompanion actions",
					},
				},
			},
		})

		local progress = require("fidget.progress")
		local handles = {}
		local group = vim.api.nvim_create_augroup("CodeCompanionFidget", {})

		vim.api.nvim_create_autocmd("User", {
			pattern = "CodeCompanionRequestStarted",
			group = group,
			callback = function(e)
				handles[e.data.id] = progress.handle.create({
					title = "CodeCompanion",
					message = "Thinking...",
					lsp_client = { name = e.data.adapter.formatted_name },
				})
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "CodeCompanionRequestFinished",
			group = group,
			callback = function(e)
				local h = handles[e.data.id]
				if h then
					h.message = e.data.status == "success" and "Done" or "Failed"
					h:finish()
					handles[e.data.id] = nil
				end
			end,
		})
	end,
	keys = {
		-- The core keybinds
		{ "<leader>oa", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "CodeCompanion Inline" },
		{ "<leader>fo", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
		{ "<leader>oc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Chat" },

		-- Super useful bonus bind: Select code in visual mode and press 'ga' to add it to your open chat
		{ "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "CodeCompanion Add to Chat" },
	},
}
