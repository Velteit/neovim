local List = require("core.list");
local func = require("core.functional");
-- TODO functional general

-- Subscription
local Subscription = {}

function Subscription:new(o)
  o = o or { unsub = func.do_nothing }

  setmetatable(o, self)

  self.__index = self

  return o
end

function Subscription:unsubscibe()
  self.unsub()
end

-- Observer
local Observer = {}

function Observer:new(o)
  o = o or {
    on_next = func.do_nothing,
    on_error = func.do_nothing,
    on_stop = func.do_nothing,
  }

  setmetatable(o, self)
  self.__index = self

  return o
end

function Observer:next(input)
  self.on_next(input)
end

function Observer:error(input)
  self.on_error(input)
end

function Observer:stop(input)
  self.on_stop(input)
end

-- Observable
local Observable = {}

function Observable:new(listeners)
  listeners = listeners or List:new()
  local obj = {
    listeners = listeners,
  }

  setmetatable(obj, self)

  self.__index = self

  return obj
end

function Observable:next(input)
  self.listeners:foreach(function(obs)
    obs:next(input)
  end)
end

function Observable:error(input)
  self.listeners:foreach(function(obs)
    obs:error(input)
  end)
end

function Observable:stop(input)
  self.listeners:foreach(function(obs)
    obs:stop(input)
  end)
end

function Observable:subscribe(observer)
  self.listeners:add(observer)

  return Subscription:new({
    unsub = function()
      self.listeners:remove(observer)
    end
  })
end

return {
  Subscription = Subscription,
  Observable = Observable,
  Observer = Observer,
}
