return {
  "hedyhli/outline.nvim",
  config = function()
    vim.keymap.set("n", "<leader>oo", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

    require("outline").setup({
      outline_window = {
        position = "right",
        width = 30,
        show_border = false,
        show_cursorline = false, -- hide the cursorline
        show_line = true,        -- show vertical bar instead
      },
      outline_items = {
        show_symbol_details = false,
        icons = {
          File          = "󰈙",
          Module        = "󰆧",
          Namespace     = "󰅪",
          Package       = "󰏗",
          Class         = "󰌗",
          Method        = "󰆧",
          Property      = "󰜢",
          Field         = "󰄶",
          Constructor   = "",
          Enum          = "",
          Interface     = "",
          Function      = "󰊕",
          Variable      = "󰂡",
          Constant      = "󰏿",
          String        = "󰀬",
          Number        = "󰎠",
          Boolean       = "󰨙",
          Array         = "󰅨",
          Object        = "󰅩",
          Key           = "󰌋",
          Null          = "󰟢",
          EnumMember    = "",
          Struct        = "󰙅",
          Event         = "",
          Operator      = "󰆕",
          TypeParameter = "󰊄",
        },
      },
      preview_window = {
        auto_preview = true,
        open_hover_on_preview = true,
        width = 50,
        min_width = 50,
        relative_width = true,
        height = 50,
        min_height = 10,
        relative_height = true,
        border = "single",
        winhl = "NormalFloat:",
        winblend = 0,
        live = true,
      },
    })
  end,
}
