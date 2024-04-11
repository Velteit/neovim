local LangConfig = { name = "", null_ls = function(_) end, filetypes = {}, opts = {}, enabled = true };

function LangConfig:new(o)
  o = o or {};

  setmetatable(o, self);

  self.__index = self;
  -- self.name = name or "";
  -- self.filetypes = filetypes or {};
  -- self.null_ls = null_ls or function(_) end;
  -- self.enabled = enabled or false;
  -- self.opts = opts or {};

  return o;
end

-- lenses
function LangConfig.get_name()
  return function (conf) return conf.name; end;
end

function LangConfig.get_linters()
  return function (conf) return conf.linters; end;
end

function LangConfig.get_filetypes()
  return function (conf) return conf.filetypes; end;
end

function LangConfig.get_opts()
  return function (conf) return conf.opts; end;
end

function LangConfig.get_enabled()
  return function (conf) return conf.enabled; end;
end

function LangConfig.get_null_ls()
  return function (conf) return conf.null_ls; end;
end

return LangConfig;
