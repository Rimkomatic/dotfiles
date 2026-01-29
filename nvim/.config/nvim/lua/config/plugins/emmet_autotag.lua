return{
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },

  -- Emmet-like expansion (div>ul>li*3 etc.)
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescriptreact", "javascriptreact" },
    init = function()
      vim.g.user_emmet_leader_key = "<C-Z>"
    end,
  },

  -- Optional: auto close unmatched HTML tags
  {
    "alvan/vim-closetag",
    ft = { "html", "xhtml", "javascriptreact", "typescriptreact" },
    init = function()
      vim.g.closetag_filenames = "*.html,*.xhtml,*.jsx,*.tsx"
    end,
  },
} 
