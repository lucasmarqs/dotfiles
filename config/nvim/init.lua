local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'EdenEast/nightfox.nvim';             -- a theme
  use 'olimorris/onedarkpro.nvim';          -- current theme with light option
  use 'neovim/nvim-lspconfig';
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'};    -- syntax highlight
  use 'nvim-treesitter/nvim-treesitter-textobjects';
  use 'nvim-telescope/telescope.nvim';      -- fuzzy finder
  use 'nvim-lua/plenary.nvim';              -- required by telescope, gitsigns
  use 'hoob3rt/lualine.nvim';               -- faster status line
  use 'kyazdani42/nvim-tree.lua';           -- faster directory tree
  use 'hrsh7th/nvim-cmp';                   -- completion plugin
  use 'hrsh7th/cmp-nvim-lsp';
  -- use 'saadparwaiz1/cmp_luasnip';
  -- use 'L3MON4D3/LuaSnip'; -- Snippets plugin
  use 'lewis6991/gitsigns.nvim';             -- async git signs
  use 'lukas-reineke/indent-blankline.nvim'  -- add indentation guides to all lines

  use 'christoomey/vim-system-copy';        -- system cliboard cp
  use 'tpope/vim-commentary';               -- better comments
  use 'tpope/vim-fugitive';                 -- git commands
  use 'tpope/vim-repeat';                   -- dot command
  use 'tpope/vim-surround';                 -- parentheses, brackets, quotes, XML tags...
  use 'mattn/emmet-vim';                    -- no pain html

  use 'mzlogin/vim-markdown-toc'; -- create table of content in markdown

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })


  use {'kyazdani42/nvim-web-devicons', opt = true}; -- required by nvim-tree + lualine

  use 'wakatime/vim-wakatime'; -- tracking time

  use 'slim-template/vim-slim'; -- syntax highlighting for Slim lang
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
opt.listchars = { eol = '¬', tab = '>~', trail = '.' }

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
opt.background = 'dark'
opt.termguicolors = true
local onedark = require('onedarkpro')
onedark.setup {
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
    theme = 'onedark'
  }
}

-- Set git signs
require('gitsigns').setup {}

-- Remap , as leader
g.mapleader = ','
g.maplocalleader = ','

-- Set tab navigation shortcuts
map('n', '<tab>', ':tabnext<CR>')
map('n', '<s-tab>', ':tabprevious<CR>')
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
  filters = {
    custom = { "^.git$" }
  }
}

require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
}

-- Add leader shortcuts
map('n', '<leader>\\', ':NvimTreeToggle<CR>')
map('n', '<leader>f\\', ':NvimTreeFindFile<CR>')

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = false,
  },
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
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}
-- LSP configuration
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local capabilities = require('plugins.nvim-cmp').capabilities

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'solargraph' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require('lspconfig').tsserver.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}
