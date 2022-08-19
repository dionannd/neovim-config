-- Bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print('Installing packer close and reopen Neovim...')
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand reload modif plugins
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Configuration
local status, packer = pcall(require, 'packer')
if (not status) then return end

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim' -- Common utilities
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use 'hoob3rt/lualine.nvim' -- Statusline
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*'
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'neovim/nvim-lspconfig' -- LSP
  use 'glepnir/lspsaga.nvim'
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use 'L3MON4D3/LuaSnip' -- Snipet
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion

  use 'windwp/nvim-ts-autotag'
  use 'windwp/nvim-autopairs'
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
  use 'norcalli/nvim-colorizer.lua'

  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-telescope/telescope-media-files.nvim' -- Only support on linux

  use({
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
  })

  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim'

  use 'numToStr/Comment.nvim'
  use 'folke/zen-mode.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
