return {
  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        virtual_text_warning = require('onedarkpro.helpers').lighten('yellow', 12, 'onedark'),
      },
      options = {
        bold = true,
        italic = true,
        underline = true,
        undercurl = true,
        cursorline = true,
        transparent = false,
      }
    },
    config = function()
      vim.cmd([[colorscheme onelight]])
    end
  },
  {
    'kyazdani42/nvim-tree.lua',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {
      { '<leader>\\', '<cmd>NvimTreeToggle<cr>' },
      { '<leader>f\\',  '<cmd>NvimTreeFindFile<cr>' },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'onelight'
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    opts = {},
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-telescope/telescope.nvim',
    opts = {},
    keys = {
      { '<C-p>', '<CMD>Telescope find_files<CR>' },
      { '<C-n>', '<CMD>Telescope live_grep<CR>' },
    }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  }
}
