local map = require('tools.map')

local default_ops = { noremap=true, silent=true }

map('n', '<F7>', '<cmd>:FloatermNew<CR>', default_ops)
map('n', '<F12>', '<cmd>:FloatermToggle<CR>', default_ops)
map('t', '<F12>', '<cmd>:FloatermToggle<CR>', default_ops)

local function get_current_file()
  return vim.fn.expand('%')
end

local default_envvars = 'RAILS_ENV=test DATABASE_URL=$DATABASE_TEST_URL'

local function send_cmd_and_toggle_term(cmd)
  vim.api.nvim_command(string.format('FloatermSend %s %s', default_envvars, cmd))
  vim.api.nvim_command('FloatermToggle')
end

function Floaterm_rspec_current_line()
  local current_line = vim.fn.line('.')

  local cmd = string.format('bundle exec rspec %s:%s', get_current_file(), current_line)

  send_cmd_and_toggle_term(cmd)
end

function Floaterm_rspec_current_file()
  local cmd = string.format('bundle exec rspec %s', get_current_file())

  send_cmd_and_toggle_term(cmd)
end


map('n', '<leader>rc', '<cmd>lua Floaterm_rspec_current_line()<CR>', default_ops)
map('n', '<leader>rr', '<cmd>lua Floaterm_rspec_current_file()<CR>', default_ops)
