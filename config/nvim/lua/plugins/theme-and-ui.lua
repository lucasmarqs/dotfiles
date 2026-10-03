return {
  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
    config = function ()
      require('onedarkpro').setup({
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
      })
      vim.cmd([[colorscheme onelight]])
    end,
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
    'nvim-telescope/telescope-ui-select.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
    keys = {
      { '<C-p>', '<CMD>Telescope find_files<CR>' },
      { '<C-n>', '<CMD>Telescope live_grep<CR>' },
    },
    opts = {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown({})
        }
      }
    },
    config = function ()
      require('telescope').load_extension('ui-select')
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  }
}
