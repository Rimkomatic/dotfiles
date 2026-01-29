local hl = vim.api.nvim_set_hl

-- General UI
hl(0, "Normal", { bg = "none" })
hl(0, "SignColumn", { bg = "none" })
hl(0, "FoldColumn", { bg = "none" })
hl(0, "NormalFloat", { bg = "none" })
hl(0, "NormalNC", { bg = "none" })
hl(0, "NormalSB", { bg = "none" })
hl(0, "FloatBorder", { bg = "none" })
hl(0, "FloatTitle", { fg = "#F2F3F5", bg = "none" })

-- WinBar
hl(0, "WinBar", { bg = "none" })
hl(0, "WinSeparator", { fg = "#F2F3F5", bg = "none" })
hl(0, "WinBarNC", { bg = "none" })
hl(0, "WhichKeyFloat", { bg = "none" })

-- Telescope
hl(0, "TelescopeBorder", { bg = "none" })
hl(0, "TelescopePromptTitle", { bg = "none" })
hl(0, "TelescopePromptBorder", { bg = "none" })
hl(0, "TelescopeNormal", { bg = "none" })

-- Diagnostics
hl(0, "DiagnosticVirtualTextHint", { fg = "#F2F3F5", bg = "none" })
hl(0, "DiagnosticVirtualTextWarn", { fg = "#e0af68", bg = "none" })
hl(0, "DiagnosticVirtualTextInfo", { fg = "#9ece6a", bg = "none" })
hl(0, "DiagnosticVirtualTextError", { fg = "#bd2c00", bg = "none" })

-- NeoTree / NvimTree
hl(0, "NeoTreeNormal", { bg = "none" })
hl(0, "NeoTreeNormalNC", { bg = "none" })
hl(0, "NeoTreeTabInactive", { bg = "none" })
hl(0, "NeoTreeTabSeperatorActive", { fg = "#F2F3F5", bg = "none" })
hl(0, "NeoTreeTabSeperatorInactive", { fg = "#F2F3F5", bg = "none" })
hl(0, "NvimTreeTabSeperatorActive", { fg = "#F2F3F5", bg = "none" })
hl(0, "NvimTreeTabSeperatorInactive", { fg = "#F2F3F5", bg = "none" })
hl(0, "MiniTabLineFill", { fg = "#F2F3F5", bg = "none" })

-- Spectre
hl(0, "DiffChange", { fg = "#F2F3F5", bg = "#050a30" })
hl(0, "DiffDelete", { fg = "#F2F3F5", bg = "#bd2c00" })

-- StatusLine
hl(0, "StatusLine", { fg = "#191919", bg = "none" })
hl(0, "StatusLineNC", { fg = "#F2F3F5", bg = "none" })
hl(0, "StatusLineTerm", { fg = "#F2F3F5", bg = "none" })
hl(0, "StatusLineTermNC", { fg = "#F2F3F5", bg = "none" })
hl(0, "VertSplit", { fg = "#393939", bg = "none" })

-- QuickFixLine
hl(0, "QuickFixLine", { bg = "none" })

-- TabLine
hl(0, "TabLine", { bg = "none" })
hl(0, "TabLineSel", { bg = "none" })
hl(0, "TabLineFill", { bg = "none" })

-- Cursor & Line
hl(0, "CursorLineNr", { fg = "#ffffff", bg = "none" })
hl(0, "CursorLine", { bg = "none" })
hl(0, "ColorColumn", { bg = "none" })

-- Search
hl(0, "Search", { fg = "red" })
hl(0, "IncSearch", { fg = "red" })

-- Pmenu
hl(0, "Pmenu", { bg = "none" })
hl(0, "PmenuSel", { bg = "none" })
hl(0, "PmenuSbar", { bg = "none" })
hl(0, "PmenuThumb", { bg = "none" })

-- Notifications
hl(0, "NotifyINFOBody", { bg = "none" })
hl(0, "NotifyWARNBody", { bg = "none" })
hl(0, "NotifyERRORBody", { bg = "none" })
hl(0, "NotifyDEBUGBody", { bg = "none" })
hl(0, "NotifyTRACEBody", { bg = "none" })
hl(0, "NotifyINFOBorder", { bg = "none" })
hl(0, "NotifyWARNBorder", { bg = "none" })
hl(0, "NotifyERRORBorder", { bg = "none" })
hl(0, "NotifyDEBUGBorder", { bg = "none" })
hl(0, "NotifyTRACEBorder", { bg = "none" })
hl(0, "NotifyBackground", { bg = "#000000" })

-- Line numbers
vim.api.nvim_set_hl(0, "LineNr", { fg = "#393939" }) -- Inactive line numbers
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff" })

vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#000000", bg = "#DB2B72", bold = true })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#000000", bg = "#30A1EC", bold = true })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#000000", bg = "#12D368", bold = true })
-- vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#45475a", bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })

vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#393939", bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#393939", bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#393939", bg = "NONE" })

vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#000000", bg = "#DB2B72", bold = true })

-- Set a custom blue color in Ayu Dark theme
-- vim.cmd [[
--   highlight Normal guibg=NONE guifg=#D0D0D0
--   highlight Comment guifg=#7C7C7C
--   highlight Statement guifg=#81A1C1  -- Light blue for statements
--   highlight Type guifg=#88C0D0  -- Lighter blue for types
--   highlight Keyword guifg=#81A1C1  -- Light blue for keywords
--   highlight Identifier guifg=#88C0D0  -- Light blue for identifiers
--   highlight Constant guifg=#81A1C1  -- Blue for constants
--   highlight PreProc guifg=#81A1C1  -- Blue for preprocessing commands
-- ]]

-- You can also update other groups for the blue tone

-- TODO: Remove this for colorings

-- vim.api.nvim_set_hl(0, "Function", { fg = "#ff2e33" }) -- bright cyan-blue
-- vim.api.nvim_set_hl(0, "Keyword", { fg = "#ff2e33" }) -- vivid reddish pink
-- vim.api.nvim_set_hl(0, "String", { fg = "#12D368" }) -- electric green
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#9ea7b8" }) -- soft but brighter gray
-- vim.api.nvim_set_hl(0, "Constant", { fg = "#ff9f1c" }) -- glowing orange
-- vim.api.nvim_set_hl(0, "Type", { fg = "#30A1EC" }) -- neon teal
-- vim.api.nvim_set_hl(0, "Identifier", { fg = "#ffe227" }) -- bright yellow
-- vim.api.nvim_set_hl(0, "Statement", { fg = "#de32fb" }) -- vibrant purple
--
-- vim.api.nvim_set_hl(0, "Delimiter", { fg = "#FFFF00" }) -- bright yellow
-- vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#FFFF00" }) -- bright yellow
-- vim.api.nvim_set_hl(0, "@constructor", { fg = "#ff2e33" }) -- bright yellow
-- vim.api.nvim_set_hl(0, "@tag.html", { fg = "#ff2e33" })
-- vim.api.nvim_set_hl(0, "@tag.delimiter.html", { fg = "#ff2e33" })
-- vim.api.nvim_set_hl(0, "@tag", { fg = "#ff2e33" })
-- vim.api.nvim_set_hl(0, "@variable", { fg = "#30A1EC" })

-- Place this AFTER your colorscheme command
vim.api.nvim_set_hl(0, "PmenuSel", {
	fg = "#CDD6F4", -- Choose a suitable foreground text color (e.g., from Catppuccin Mocha Text)
	bg = "#313244", -- Choose a distinct background color (e.g., from Catppuccin Mocha Surface0)
	-- You can also add style if desired:
	-- bold = true,
	-- italic = true,
})

-- Optional: Ensure the base menu has a background too
vim.api.nvim_set_hl(0, "Pmenu", {
	fg = "#CDD6F4", -- Choose a suitable foreground text color
	bg = "#1E1E2E", -- Choose a base background color (e.g., Catppuccin Mocha Base)
})


vim.api.nvim_set_hl(0, "Comment", { italic = true })
vim.api.nvim_set_hl(0, "@variable.builtin", { italic = true })
