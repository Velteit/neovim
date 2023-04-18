local List = require("core.list")
-- functional general
local do_nothing = function(input) end;
local id = function(inp) return inp; end;

-- Subscription
local Subscription = { unsub = do_nothing }

function Subscription:new(o)
  o = o or {};

  setmetatable(o, self);

  self.__index = self;

  return o;
end

function Subscription:unsubscibe()
  self.unsub();
end

-- Observer
local Observer = { on_next = do_nothing, on_error = do_nothing, on_stop = do_nothing };

function Observer:new(o)
  o = o or {};

  setmetatable(o, self);
  self.__index = self;

  return o;
end

function Observer:next(input)
  print("obs next")
  print(input)
  print(vim.inspect(input))
  self.on_next(input);
end

function Observer:error(input)
  self.on_error(input);
end

function Observer:stop(input)
  self.on_stop(input)
end


-- Observable
local Observable = { listeners = List:new() };

function Observable:new(o)
  o = o or {};

  setmetatable(o, self);

  self.__index = self;

  return o;
end

function Observable:next(input)
  print("obs next for")
  print(input)
  print(vim.inspect(input))

  self.listeners
    :foreach(function (obs)
      obs:next(input)
    end)
end

function Observable:error(input)

  self.listeners:foreach(function (obs)
    obs:error(input)
  end)
end

function Observable:stop(input)

  self.listeners:foreach(function (obs)
    obs:stop(input)
  end)
end

function Observable:subscribe(observer)
  self.listeners:add(observer);

  return Subscription:new(nil, function() self.listeners:remove(observer) end)
end

return {
  Subscription = Subscription,
  Observable = Observable,
  Observer = Observer
};