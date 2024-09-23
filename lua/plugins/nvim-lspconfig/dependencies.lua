local events = require("events");
local event_names = require("events.names");
local rx = require("core.rx");

return {
  {
    "williamboman/mason.nvim",
    opts = function()
      return require("configs.mason")
    end,
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      return require("configs.mason-lsp")
    end,
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
  -- format & linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      return require("configs.linters")
    end,
    config = function(_, opts)
      local null_ls = require("null-ls")

      for i, _ in ipairs(opts.configs) do
        local cfg = opts.configs[i]
        -- print(vim.inspect(cfg.filetypes));
        events
            :get(event_names.BufNewFile, "null_ls-" .. cfg.name, { pattern = cfg.filetypes }, { clear = true })
            :subscribe(rx.Observer:new({
              on_next = function(ev)
                local founded = false
                local filetype = vim.bo[ev.buf].filetype

                for _, ft in pairs(cfg.filetypes) do
                  if ft == filetype then
                    founded = true
                    break
                  end
                end

                if not founded then
                  return
                end

                -- print(cfg.name);
                -- print(vim.bo[ev.buf].filetype);
                -- print(vim.inspect(cfg.filetypes));

                local sources = {}
                local values = cfg.null_ls(null_ls)
                local config = {}

                for key, value in pairs(opts.base_config) do
                  config[key] = value
                end

                for _, value in ipairs(values or {}) do
                  if not sources[value] then
                    table.insert(sources, value)
                  end
                end

                config.sources = sources

                null_ls.setup(config)
              end,
            }))
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = {
          history = true,
          updateevents = "TextChanged,TextChangedI",
        },
        config = function(_, opts) end,
      },
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-git",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lsp-signature-help",
      },
    },

    opts = function()
      return require("configs.cmp")
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      -- print(vim.inspect(opts))

      cmp.setup(opts.main)

      for ft, config in pairs(opts.filetypes or {}) do
        cmp.setup.filetype(ft, config or {})
      end

      for ch, config in pairs(opts.cmdline) do
        cmp.setup.cmdline(ch, config)
      end
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    config = function(_, opts)
      require("rust-tools")
          .setup({
            server = {
              on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
              end,
            },
          })
    end
  }
}
