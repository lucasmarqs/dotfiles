local function rubocop()
  local util = require('formatter.util')

  return {
    exe = "bin/rubocop",
    args = {
      "--fix-layout",
      "--stdin",
      util.escape_path(util.get_current_buffer_file_name()),
      "--format",
      "files",
      "--stderr",
    },
    stdin = true,
  }
end

return {
  {
    'mhartington/formatter.nvim',
    opts = {
      filetype = {
        ruby = { rubocop },
        terraform = { require('formatter.filetypes.terraform').terraformfmt },
        typescript = { require('formatter.defaults.biome') },
        typescriptreact = { require('formatter.defaults.biome') },
      }
    }
  }
}
