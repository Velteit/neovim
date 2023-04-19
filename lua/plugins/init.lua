local mappings = require("mappings");
local events = require("events");
local event_names = require("events.names");
local rx = require("core.rx");

local plugins = {
  "nvim-lua/plenary.nvim",

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    opts = function()
      return require("configs.treesitter");
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies =
    {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function ()
      return require("configs.treesitter-context");
    end,
    config = function (_, opts)
      require("treesitter-context").setup(opts);
    end

  },

  {
    "lukas-reineke/indent-blankline.nvim",
    confit = function(_, opts)
      require("indent_blankline").setup(opts)
    end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function()
          return require("configs.mason")
        end,
        config = function(_, opts)
          require("mason").setup(opts)
        end
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = function()
          return require("configs.mason-lsp");
        end,
        config = function(_, opts)
          require("mason-lspconfig").setup(opts)
        end
      },
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function()
          return require("configs.linters");
        end,
        config = function(_, opts)
          require("null-ls").setup(opts)
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
              updateevents = "TextChanged,TextChangedI"
            },
            config = function(_, opts)
            end,
          },
          {
            "windwp/nvim-autopairs",
            opts = {
              fast_wrap = {},
              disable_filetype = { "TelescopePrompt", "vim" },
            },
            config = function(_, opts)
              require("nvim-autopairs").setup(opts)

              local cmp_autopairs = require "nvim-autopairs.completion.cmp"
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
            "hrsh7th/cmp-nvim-lsp-signature-help"
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
    },
    init = function()
      mappings.add_mapping('n', '<leader>e', { vim.diagnostic.open_float })
      mappings.add_mapping('n', '<leader>d', { vim.diagnostic.goto_prev })
      mappings.add_mapping('n', ']d', { vim.diagnostic.goto_next })
      mappings.add_mapping('n', '<leader>q', { vim.diagnostic.setloclist })

      events
        :get(event_names.LspAttach, "UserLspConfig", {})
        :subscribe(rx.Observer:new {
          on_next = function(ev)
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }

            vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration,  opts)
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>f', function( ) vim.lsp.buf.format { async = true } end, opts)
          end
      })
      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      --   callback = function(ev)
      --     -- Enable completion triggered by <c-x><c-o>
      --     vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      --
      --     -- Buffer local mappings.
      --     -- See `:help vim.lsp.*` for documentation on any of the below functions
      --     local opts = { buffer = ev.buf }
      --
      --     vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration,  opts)
      --     vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
      --     vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
      --     vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
      --     vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
      --     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      --     vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
      --     vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
      --     vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
      --     vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
      --     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      --     vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      --     vim.keymap.set('n', '<leader>f', function( ) vim.lsp.buf.format { async = true } end, opts)
      --
      --   end,
      -- })
    end,
    opts = function()
      return require("configs.lsp");
    end,
    config = function (_, opts)
      opts.apply_config(require("lspconfig"))
    end

  },

  {
    "numToStr/Comment.nvim",
    init = function()
      mappings.add_mapping("n", "gcc", { function() require("Comment.api").toggle.linewise.current() end, "Toggle comment line" })
      mappings.add_mapping("v", "gc", { "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "toggle comment" })
    end
  },

  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd[[colorscheme tokyonight-moon]]
    end
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "phaazon/hop.nvim",
    event = "BufEnter",
    config = function ()
      require("hop").setup()
    end

  },

  { "elkowar/yuck.vim" , lazy = true },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    event = "BufEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function ()
      return require("configs.treesitter-textobjects")
    end,
    config = function(_, opts)
      require("hlargs").setup(opts)
    end
  },

  {
    "m-demare/hlargs.nvim",
    lazy = true,
    event = "BufEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("hlargs").setup()
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    init = function()
      mappings.add_mapping("n", "<leader>tt", { "<cmd> Telescope find_files <CR>", "find files" })
      mappings.add_mapping("n", "<leader>ta", { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" })
      mappings.add_mapping("n", "<leader>tw", { "<cmd> Telescope live_grep <CR>", "live grep" })
      mappings.add_mapping("n", "<leader>tb", { "<cmd> Telescope buffers <CR>", "find buffers" })
      mappings.add_mapping("n", "<leader>tz", { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "find in current buffer" })

      -- git
      mappings.add_mapping("n", "<leader>tgc", { "<cmd> Telescope git_commits <CR>", "git commits" })
      mappings.add_mapping("n", "<leader>tgs", { "<cmd> Telescope git_status <CR>", "git status" })

      -- "<leader>pt" = { "<cmd> Telescope terms <CR>", "pick hidden term" },

    end,

  },

  {
    "desdic/agrolens.nvim",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    init = function()
      mappings.add_mapping("n", "<leader>tm", { "<cmd> Telescope agrolens query=functions <CR>", "Go to function" })
    end,
    config = function()
      require("telescope").load_extension("agrolens")
    end
  },

  {
    'gorbit99/codewindow.nvim',
    lazy = true,
    init = function()
      mappings.add_mapping("n", "<leader>mm", { function() require("codewindow").toggle_minimap() end, "Open minimap" })
    end,
    config = function()
      require('codewindow').setup()
    end,
  },

  {
    "f-person/git-blame.nvim",
    lazy = false,
    config = function()
      vim.g.gitblame_display_virtual_text = 1
    end
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
    end,
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      mappings.add_mapping("n", "<C-b>", { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" })
      mappings.add_mapping("n", "<leader>ft", { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" })
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`", "c", "v" },
    init = function()
      mappings.add_mapping("n", "<leader>wK", { function() vim.cmd "WhichKey" end, "which-key all keymaps", })
      mappings.add_mapping("n", "<leader>wk", { function() local input = vim.fn.input "WhichKey: " vim.cmd("WhichKey " .. input) end, "which-key query lookup", })
    end,
    opts = function()
      -- TODO
    end,
    config = function(_, opts)
      require("which-key").setup(opts);
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function ()
      mappings.add_mapping("n", "<leader>bn<CR>", { ":bnext", "Next buffer" });
      mappings.add_mapping("n", "<leader>bp<CR>", { ":bprevious", "Previous buffer" });
    end,
    opts = function ()
      return require("configs.bufferline");
    end,
    config = function()
      require("bufferline").setup();
    end
  },
  {
    "tmillr/sos.nvim",
    opts = function ()
      return require("configs.sos");
    end,
    config = function (_, opts)
      require("sos").setup(opts)
    end
  },

  { "gpanders/editorconfig.nvim", lazy = true, event = "BufEnter" }
}

return plugins
