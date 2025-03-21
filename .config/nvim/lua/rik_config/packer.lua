-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
  	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	-- or                            , branch = '0.1.x',
  	requires = { {'nvim-lua/plenary.nvim'} }
  }

  use "EdenEast/nightfox.nvim" -- Nightfox Theme

  use ({
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		vim.cmd("colorscheme rose-pine")
	end
  })

  use( 'nvim-treesitter/nvim-treesitter', {run=':TSUpdate'})   -- treesitter for nvim
  use('ThePrimeagen/harpoon')
  use('mbbill/undotree')
  use("tpope/vim-fugitive")

  use {
 	 'VonHeikemen/lsp-zero.nvim',
  	requires = {
    	-- LSP Support
    		{'neovim/nvim-lspconfig'},
    		{'williamboman/mason.nvim'},
    		{'williamboman/mason-lspconfig.nvim'},

    	-- Autocompletion
    		{'hrsh7th/nvim-cmp'},
    		{'hrsh7th/cmp-buffer'},
    		{'hrsh7th/cmp-path'},
    		{'saadparwaiz1/cmp_luasnip'},
    		{'hrsh7th/cmp-nvim-lsp'},
    		{'hrsh7th/cmp-nvim-lua'},

    	-- Snippets
    		{'L3MON4D3/LuaSnip'},
	-- Snippet Collection (Optional)
    		{'rafamadriz/friendly-snippets'},
  		}
	}
  use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
  }

  use {
     'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use('xiyaowong/transparent.nvim')


end)
