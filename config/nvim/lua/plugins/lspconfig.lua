local map = require('tools.map')

local keymaps = function()
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
  map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  map('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

local nvim_lsp = require('lspconfig')
local capabilities = require('plugins.nvim-cmp').capabilities

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local lsp_names = require('configs').lsp_names
for _, lsp in ipairs(lsp_names) do
  if lsp == 'tsserver' then
    goto continue
  end
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = function (client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      keymaps()
    end,
    flags = {
      debounce_text_changes = 150,
    }
  }
  ::continue::
end

require('typescript').setup {
  server = {
    on_attach = function (client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      keymaps()

      -- Run CodeAction on save
      local augroup = vim.api.nvim_create_augroup("TypescriptActions", {})
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWrite", {
        group = augroup,
        buffer = bufnr,
        command = 'TypescriptOrganizeImports!',
      })
    end,
    flags = {
      debounce_text_changes = 150,
    },
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  }
}
