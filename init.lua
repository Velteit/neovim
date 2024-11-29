local rx = require("core.rx")
local mappings = require("mappings")
local plugins = require("plugins")

mappings:get_mappings():subscribe(rx.Observer:new({
  on_next = function(ev)
    local mode = ev.mode
    local keybind = ev.key
    local opts = ev.opts.opts or {}

    opts.desc = ev.opts[2] or ""

    vim.keymap.set(mode, keybind, ev.opts[1], opts)
  end,
}))

vim.opt.termguicolors = true
vim.opt.number = true
vim.wo.relativenumber = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = true
vim.opt.hlsearch = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.g.mapleader = " "
-- vim.g.foldmethod = expr
vim.g.foldexpr = "nvim_treesitter#foldexpr()"
vim.g.nofoldenable = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)


vim.schedule(function()
  local merge_tb = vim.tbl_deep_extend

  local default = require("mappings.default")
  for mode, keys in pairs(default) do
    for name, opts in pairs(keys or {}) do
      mappings:add_mapping(mode, name, opts)
    end
  end
end)

require("lazy").setup(plugins)

vim.cmd([[colorscheme tokyonight]])
