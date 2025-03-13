return {
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { 'ruby', 'typescript', 'css', 'html', 'lua', 'json', 'yaml' },
        sync_index = false,
        highlight = {
          enable = true,
          -- additional_vim_regex_highlighting = false,
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
        },
        indent = {
          enable = true,
        },
      })
    end,
  }
}
