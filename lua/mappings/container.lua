local M = {};

M._mappings = {
  n = {},
  v = {},
  i = {},
  x = {},
  t = {}
};

function M.get_mappings()
  return M._mappings
end

function M.add_mapping(mode, key, opts)
  M._mappings[mode][key] = opts;
end

return M;
