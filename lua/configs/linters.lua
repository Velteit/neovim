-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls = require("null-ls");
local rx = require("core.rx");
local servers = require("configs.servers");
local LangConfig = require("core.lang-config");
local events = require("events");
local names = require("events.names");
local configs = {}

servers:where(LangConfig.get_enabled())
  :foreach(function(cfg)
    table.insert(configs, cfg);
  end)

return {
  configs = configs,
  base_config = {}
}
