local rx = require("core.rx");
local List = require("core.list");

local Events = { events = {} };

function Events:get(event_name, group, opts, group_opts)
  if self.events[event_name] == nil then
    self.events[event_name] = {}
  end

  if self.events[event_name][group] == nil then
    self.events[event_name][group] = rx.Observable:new();

    opts = opts or {};
    -- print(event_name)
    -- print(vim.inspect(opts))

    opts.group = vim.api.nvim_create_augroup(group, group_opts or {});
    opts.callback = function(ev)
      self.events[event_name][group]:next(ev)
    end;

    vim.api.nvim_create_autocmd(event_name, opts)
  end

  return self.events[event_name][group];
end

return Events;
