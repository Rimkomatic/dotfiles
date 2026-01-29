return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        config = function()
        end,
    },
    {
        "MeanderingProgrammer/treesitter-modules.nvim",
        config = function()
            require('treesitter-modules').setup({
                ensure_installed = {},
                ignore_install = {},
                sync_install = false,
                auto_install = false,
                fold = {
                    enable = false,
                    disable = false,
                },
                highlight = {
                    disable = false,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<Enter>',
                        node_incremental = '<Enter>',
                        scope_incremental = false,
                        node_decremental = '<Backspace>',
                    },
                },
                indent = {
                    enable = true,
                },
            })
        end,

    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        config = function ()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    enable = true,
                    lookahead = true,
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>',
                    },
                    include_surrounding_whitespace = false,
                },
            })
      end 
  }
}
