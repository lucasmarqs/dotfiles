local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = true,
  on_attach = function (client, bufnr)
    -- Format on save
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function ()
          vim.lsp.buf.format({
            bufnr = bufnr
          })
        end,
      })
    end
  end,

  sources = {
    -- Formatting
    null_ls.builtins.formatting.prettier.with({
      prefer_local = 'node_modules/.bin',
    }),

    -- Code Actions
    require('typescript.extensions.null-ls.code-actions'),
    null_ls.builtins.code_actions.eslint.with({
      prefer_local = 'node_modules/.bin',
    }),
  }
})
