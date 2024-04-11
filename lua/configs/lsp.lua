local servers = require("configs.servers");
local LangConfig = require("core.lang-config");
local M = {}

local on_attach = function(client, bufnr)
  if client.server_capabilities["documentSymbolProvider"] then
    require("nvim-navic").attach(client, bufnr)
  end
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts_ = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts_)
    end
  })
end

function M.apply_config(lsp)
  local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  );
  servers:where(LangConfig.get_enabled()):foreach(function(conf)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities
    };
    for key, value in pairs(conf.opts) do
      opts[key] = value;
    end

    lsp[conf.name].setup(opts)
  end)
end

return M;
