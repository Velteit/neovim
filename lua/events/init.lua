local rx = require("core.rx");


local Events = { events = {} };

function Events:get(event_name, group, group_opts)
  if self.events[event_name] == nil then
    self.events[event_name] = {}
  end

  if self.events[event_name][group] == nil then
    self.events[event_name][group] = rx.Observable:new();

    vim.api.nvim_create_autocmd(event_name, {
      group = vim.api.nvim_create_augroup(group, group_opts or {}),
      callback = function(ev)
        self.events[event_name][group]:next(ev)
      end
    })
  end

  return self.events[event_name][group];
end


return Events;
