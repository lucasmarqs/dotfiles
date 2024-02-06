local prettier = require('formatter.defaults.prettier')

require('formatter').setup {
  filetype = {
    typescript = { prettier },
    typescriptreact = { prettier },
  }
}
