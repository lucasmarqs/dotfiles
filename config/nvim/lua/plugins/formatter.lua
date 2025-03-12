local util = require "formatter.util"

local biome = require('formatter.defaults.biome')
local terraform = require('formatter.filetypes.terraform')

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
    ruby = { rubocop },
    terraform = { terraform.terraformfmt },
    typescript = { biome },
    typescriptreact = { biome },
  }
}
