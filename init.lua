vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = true
vim.opt.hlsearch = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.g.mapleader = " "
vim.g.foldmethod = expr
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

plugins = require("plugins")

vim.schedule(function()
  local merge_tb = vim.tbl_deep_extend
  local mappings = require("mappings").get_mappings()

  for mode, mode_values in pairs(mappings) do
    for keybind, mapping_info in pairs(mode_values) do
      if not(keybind == nil) then
        local opts = mapping_info.opts or {};

        opts.desc = mapping_info[2] or ""

        vim.keymap.set(mode, keybind, mapping_info[1], opts)
      end
    end
  end
end)

require("lazy").setup(plugins)
