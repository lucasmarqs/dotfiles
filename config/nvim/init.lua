local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local map = require('tools.map')

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Themes
  use 'EdenEast/nightfox.nvim';             -- a theme
  use 'olimorris/onedarkpro.nvim';          -- current theme with light option

  -- LSP
  use {
    "williamboman/mason.nvim",  -- LSP Package Manager
    run = ":MasonUpdate",        -- :MasonUpdate updates registry contents
    requires = {'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig'}
  };

  -- tree-sitter
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'};    -- syntax highlight
  use 'nvim-treesitter/nvim-treesitter-textobjects';

  -- auto completion
  use {
     'hrsh7th/nvim-cmp',
     'hrsh7th/cmp-nvim-lsp',
     'hrsh7th/cmp-buffer',
     'hrsh7th/cmp-path',
  }
  use {
    {'L3MON4D3/LuaSnip', run = 'make install_jsregexp'},
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets', -- VSCode snippets style
  }
  -- Formatter && Code diagnostics
  use 'mhartington/formatter.nvim'
  use 'mfussenegger/nvim-lint'

  -- UI
  use 'lukas-reineke/indent-blankline.nvim'                     -- add indentation guides to all lines
  use {
    'hoob3rt/lualine.nvim',                                     -- faster status line
    requires = {{'kyazdani42/nvim-web-devicons', opt = true}}
  }
  use {
    'kyazdani42/nvim-tree.lua',                                 -- faster directory tre
    requires = {{'kyazdani42/nvim-web-devicons', opt = true}}
  }
  use {
    'nvim-telescope/telescope.nvim',                            -- fuzzy finder
    requires = {'nvim-lua/plenary.nvim'}
  };
  use {
    'lewis6991/gitsigns.nvim',                                  -- async git signs
    version = '0.9.0',
    requires = {'nvim-lua/plenary.nvim'}
  };


  use 'christoomey/vim-system-copy';        -- system cliboard cp
  use 'tpope/vim-commentary';               -- better comments
  use 'tpope/vim-fugitive';                 -- git commands
  use 'tpope/vim-repeat';                   -- dot command
  use 'tpope/vim-surround';                 -- parentheses, brackets, quotes, XML tags...
  use 'mattn/emmet-vim';                    -- no pain html

  use 'mzlogin/vim-markdown-toc';           -- create table of content in markdown

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use 'voldikss/vim-floaterm'

  use 'godlygeek/tabular'

  use "zbirenbaum/copilot.lua"
end)

-- disable mouse
opt.mouse = ''

-- Set relative numbers
opt.number = true
opt.relativenumber = true

-- Highlight current line
opt.cursorline = true

-- Set a ruler at 80th column
opt.colorcolumn = '80'

-- Show hidden chars
opt.list = true
opt.listchars = { trail = '.' }

-- Use spaces instead tabs with width of 2
opt.expandtab = true
opt.shiftwidth = 2

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Decrease update time
opt.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
-- opt.background = 'dark'
opt.termguicolors = true
vim.cmd("colorscheme onelight")
local onedark = require('onedarkpro')
local color = require('onedarkpro.helpers')
onedark.setup {
  colors = {
    virtual_text_warning = color.lighten('yellow', 12, 'onedark'),
  },
  options = {
    bold = true, -- Use the themes opinionated bold styles?
    italic = true, -- Use the themes opinionated italic styles?
    underline = true, -- Use the themes opinionated underline styles?
    undercurl = true, -- Use the themes opinionated undercurl styles?
    cursorline = true, -- Use cursorline highlighting?
    transparent = false, -- Use a transparent background?
  }
}
onedark.load()

-- Set statusbar
require('lualine').setup {
  options = {
    theme = 'onelight'
  }
}

-- Set git signs
require('gitsigns').setup {}

-- Remap , as leader
g.mapleader = ','
g.maplocalleader = ','

-- Set tab navigation shortcuts
map('n', '<leader>n', ':tabnew<CR>')
map('n', '<leader>w', ':tabclose<CR>')

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Trim whitespace before save
vim.api.nvim_exec(
  [[
    autocmd BufWritePre * :%s/\s\+$//e
  ]],
  false
)

-- Telescope configuration
local telescope = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = telescope.close -- immediately close with <Esc>
      }
    },
  },
}
-- Add shortcuts
map('n', '<C-p>', ':Telescope find_files<CR>')
map('n', '<C-n>', ':Telescope live_grep<CR>')

-- Nvim Tree configuration
require('nvim-tree').setup {
}

require("ibl").setup()

-- Add leader shortcuts
map('n', '<leader>\\', ':NvimTreeToggle<CR>')
map('n', '<leader>f\\', ':NvimTreeFindFile<CR>')

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = 'gnn',
  --     node_incremental = 'grn',
  --     scope_incremental = 'grc',
  --     node_decremental = 'grm',
  --   },
  -- },
  -- indent = {
  --   enable = false,
  -- },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    -- move = {
    --   enable = true,
    --   set_jumps = true, -- whether to set jumps in the jumplist
    --   goto_next_start = {
    --     [']m'] = '@function.outer',
    --     [']]'] = '@class.outer',
    --   },
    --   goto_next_end = {
    --     [']M'] = '@function.outer',
    --     [']['] = '@class.outer',
    --   },
    --   goto_previous_start = {
    --     ['[m'] = '@function.outer',
    --     ['[['] = '@class.outer',
    --   },
    --   goto_previous_end = {
    --     ['[M'] = '@function.outer',
    --     ['[]'] = '@class.outer',
    --   },
    -- },
  },
}
-- LSP configuration
vim.diagnostic.config({
  virtual_text = false,
})
vim.g.lsp_diagnostics_highlights_enabled = false
vim.api.nvim_exec2('highlight DiagnosticUnderlineInfo guifg=Azure3', {})
vim.api.nvim_exec2('highlight DiagnosticUnderlineWarn guifg=wheat', {})

require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = require('configs').mason_managed_lsps,
}
require('plugins.copilot')
require('plugins.lspconfig')
require('plugins.formatter')
require('plugins.nvim-lint')
require('plugins.floaterm')
