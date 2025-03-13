local lsp_names = {
  'ts_ls',
  'cssls',
  'ruby_lsp',
  'pyright',
  'lua_ls',
  'terraformls',
}

local specialized_commands = {}

function specialized_commands.TS_organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
  }
  vim.lsp.buf.execute_command(params)
end

return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    priority = 999,
    opts = {
      auto_install = true,
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    priority = 998,
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function ()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

      for _, lsp in ipairs(lsp_names) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
        }

        if lsp == 'ts_ls' then
          vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(ev)
              local client = vim.lsp.get_client_by_id(ev.data.client_id)
              if client.name == "ts_ls" then
                vim.api.nvim_create_user_command("LspOrganizeImports", specialized_commands.TS_organize_imports, {desc = 'Organize Imports'})
              end
            end
          })
        end

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, {})
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, {})
        vim.keymap.set('n', '<space>[d', vim.diagnostic.goto_prev, {})
        vim.keymap.set('n', '<space>]d', vim.diagnostic.goto_next, {})
        vim.keymap.set('n', '<space>f', vim.lsp.buf.format, {})
      end
    end
  }
}
