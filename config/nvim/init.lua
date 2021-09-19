local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

require 'paq-nvim' {
  'savq/paq-nvim';

  'EdenEast/nightfox.nvim';             -- current theme
  'neovim/nvim-lspconfig';
  {'nvim-treesitter/nvim-treesitter', run = fn[':TSUpdate']};    -- syntax highlight
  'nvim-treesitter/nvim-treesitter-textobjects';
  'nvim-telescope/telescope.nvim';      -- fuzzy finder
  'nvim-lua/plenary.nvim';              -- required by telescope
  'hoob3rt/lualine.nvim';               -- faster status line
  'kyazdani42/nvim-tree.lua';           -- faster directory tree
  'hrsh7th/nvim-cmp';                   -- completion plugin
  'hrsh7th/cmp-nvim-lsp';
  'saadparwaiz1/cmp_luasnip';
  'L3MON4D3/LuaSnip'; -- Snippets plugin
  'lewis6991/gitsigns.nvim';             -- async git signs

  'christoomey/vim-system-copy';        -- system cliboard cp
  'tpope/vim-commentary';               -- better comments
  'tpope/vim-fugitive';                 -- git commands
  'tpope/vim-repeat';                   -- dot command
  'tpope/vim-surround';                 -- parentheses, brackets, quotes, XML tags...
  'mattn/emmet-vim';                    -- no pain html

  {'iamcco/markdown-preview.nvim', run = fn['mkdp#util#install']}; -- preview markdown
  'mzlogin/vim-markdown-toc'; -- create table of content in markdown


  {'kyazdani42/nvim-web-devicons', opt = true}; -- required by nvim-tree + lualine
  'nvim-lua/plenary.nvim'; -- required by gitsigns

  'wakatime/vim-wakatime'; -- tracking time
}

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
opt.termguicolors = true
require('nightfox').set()

-- Set statusbar
require('lualine').setup {
  options = {
    theme = "nightfox"
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
g.nvim_tree_ignore = { '.git', '.github' }
g.nvim_tree_gitignore = 1

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
    enable = true,
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

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'solargraph' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
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

-- luasnip setup
local luasnip = require 'luasnip'
-- nvim-cmp configurations
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
