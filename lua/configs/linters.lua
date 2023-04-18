-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls = require("null-ls");
local servers = require("configs.servers");
local LangConfig = require("core.lang-config");
local sources = {}

servers:where(LangConfig.get_enabled())
  :map(LangConfig.get_null_ls())
  :foreach(function(getter)
    local values = getter(null_ls);
    for key, value in ipairs(values or {}) do
      if not(sources[value]) then
        table.insert(sources, value)
      end
    end
  end)

return {
  sources = sources
}
