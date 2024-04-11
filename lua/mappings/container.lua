local rx = require("core.rx")
local List = require("core.list")

local M = {}

function M:new(o)
	o = o or {
		events = rx.Observable:new()
	};

	setmetatable(o, self)

	self.__index = self

	return o
end

-- M._mappings = {
--   n = {},
--   v = {},
--   i = {},
--   x = {},
--   t = {},
-- };

function M:get_mappings()
	return self.events
end

function M:add_mapping(mode, key, opts)
	self.events:next({ mode = mode, key = key, opts = opts })
end

return M
