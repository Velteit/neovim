default = {
  n = {
    ["<Esc>"] = { ":noh <CR>", "Clear highlights" },
  },
  v = {},
  i = {}
}

local container = require("mappings.container");

for mode, keys in pairs(default) do
  for name, opts in pairs(opts or {}) do
    container.add_mapping(name, opts);
  end
end

return container;
