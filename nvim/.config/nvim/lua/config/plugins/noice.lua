return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },

  opts = {
    --------------------------------------------------------------------------------
    -- LSP SECTION – we disable hover/signature entirely to STOP focus stealing
    --------------------------------------------------------------------------------
    lsp = {
      -- Keep markdown formatting overrides (these are safe)
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },

      -- The two lines that FIX your cursor-jumping issue:
      hover = { enabled = false },
      signature = { enabled = false },
    },

    --------------------------------------------------------------------------------
    -- MESSAGE ROUTING + UI
    --------------------------------------------------------------------------------
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "notify",
      },
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
    },

    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = false,
    },
  },

  keys = {
    { "<leader>sn", "", desc = "+noice" },
    {
      "<S-Enter>",
      function()
        require("noice").redirect(vim.fn.getcmdline())
      end,
      mode = "c",
      desc = "Redirect Cmdline"
    },
    {
      "<leader>snl",
      function()
        require("noice").cmd("last")
      end,
      desc = "Noice Last Message"
    },
    {
      "<leader>snh",
      function()
        require("noice").cmd("history")
      end,
      desc = "Noice History"
    },
    {
      "<leader>sna",
      function()
        require("noice").cmd("all")
      end,
      desc = "Noice All"
    },
    {
      "<leader>snd",
      function()
        require("noice").cmd("dismiss")
      end,
      desc = "Dismiss All"
    },
    {
      "<leader>snt",
      function()
        require("noice").cmd("pick")
      end,
      desc = "Noice Picker"
    },

    -- Smooth scrolling inside Noice float windows (only if they exist)
    {
      "<c-f>",
      function()
        if not require("noice.lsp").scroll(4) then
          return "<c-f>"
        end
      end,
      silent = true,
      expr = true,
      mode = { "i", "n", "s" }
    },
    {
      "<c-b>",
      function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-b>"
        end
      end,
      silent = true,
      expr = true,
      mode = { "i", "n", "s" }
    },
  },

  config = function(_, opts)
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end

    require("noice").setup(opts)

    require("notify").setup({
      background_colour = "#000000",
    })
  end,
}
