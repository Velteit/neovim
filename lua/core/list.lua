local get_position = function(list, obj)
	for i = 1, #list, 1 do
		if list[i] == obj then
			return i
		end
	end

	return -1
end

local List = {}

function List:new(o)
	o = o or {
		inner = {},
	}

	setmetatable(o, self)

	self.__index = self

	return o
end

function List:add(value)
	table.insert(self.inner, value)
end

function List:add_many(...)
	for _, value in ipairs(...) do
		self:add(value)
	end
end

function List:where(predicate)
	local res = {}

	for _, value in pairs(self.inner) do
		if predicate(value) then
			table.insert(res, value)
		end
	end

	return List:new({ inner = res })
end

function List:to_array()
	return self.inner
end

function List:to_set()
	local set = {}
	local result = {}

	self:foreach(function(el)
		if not set[el] then
			set[el] = 1
		end
	end)

	for key, _ in pairs(set) do
		table.insert(result, key)
	end

	return result
end

function List:map(projection)
	local rs = {}

	for _, value in pairs(self.inner) do
		table.insert(rs, projection(value))
	end

	return List:new({ inner = rs })
end

function List:foreach(handler)
	for _, value in pairs(self.inner) do
		handler(value)
	end
end

function List:remove(obj)
	local pos = get_position(self.inner, obj)
	if pos == -1 then
		-- TODO equals and hashcode
		table.remove(self.inner, pos)
	end
end

return List
