return{
  "smjonas/inc-rename.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>rn",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      expr = true,
      desc = "Incremental Rename"
    },
  },
  config = function()
    require("inc_rename").setup({
      input_buffer_type = "dressing", -- or "plain" if you don't use dressing.nvim
    })
  end,
}
