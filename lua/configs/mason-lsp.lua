local servers = require("configs.servers");
local LangConfig = require("core.lang-config");

return {
  ensure_installed = servers:where(LangConfig.get_enabled()):map(LangConfig.get_name()):to_array(),
  automatic_installation = true
}
