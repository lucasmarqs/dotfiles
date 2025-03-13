-- disable mouse
vim.opt.mouse = ''

-- Set relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight current line
vim.opt.cursorline = true

-- Set a ruler at 80th column
vim.opt.colorcolumn = '80'

-- Show hidden chars
vim.opt.list = true
vim.opt.listchars = { trail = '.' }

-- Use spaces instead tabs with width of 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time - temporarily disabled for testing
-- vim.opt.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set tab navigation shortcuts
vim.keymap.set('i', '<leader>n', '<cmd>:tabnew<CR>', {})
vim.keymap.set('i', '<leader>w', '<cmd>:tabclose<CR>', {})

vim.opt.termguicolors = true

-- disable netrw (NvimTree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- LSP configuration
vim.diagnostic.config({
  virtual_text = false,
})
vim.g.lsp_diagnostics_highlights_enabled = false
vim.api.nvim_exec2('highlight DiagnosticUnderlineInfo guifg=Azure3', {})
vim.api.nvim_exec2('highlight DiagnosticUnderlineWarn guifg=wheat', {})

-- Automations

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
