return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = function ()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true
    end,
    config = function ()
      require("nvim-treesitter-textobjects").setup({})
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    -- lazy = false,
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { 'ruby', 'typescript', 'css', 'html', 'lua', 'json', 'yaml', 'go' },
        sync_index = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['ib'] = '@block.inner',
              ['ab'] = '@block.outer',
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
