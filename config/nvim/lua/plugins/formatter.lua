local util = require "formatter.util"

local biome = require('formatter.defaults.biome')

local function rubocop()
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

require('formatter').setup {
  filetype = {
    typescript = { biome },
    typescriptreact = { biome },
    ruby = { rubocop },
  }
}
