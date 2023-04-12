require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    typescript = {
      require('formatter.filetypes.typescript').prettier,
      require('typescript').actions.organizeImports,
      require('typescript').actions.fixAll,
    },
    typescriptreact = {
      require('formatter.filetypes.typescript').prettier,
      require('typescript').actions.organizeImports,
      require('typescript').actions.fixAll,
    },
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

local FormatAutogroup = vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'FormatWrite',
  group = FormatAutogroup,
})
