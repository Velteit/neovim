local mappings = require("mappings")

-- TODO describe plugins
local plugins = {
  "nvim-lua/plenary.nvim",

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    opts = function()
      return require("configs.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = function()
      return require("configs.treesitter-context")
    end,
    config = function(_, opts)
      require("treesitter-context").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    confit = function(_, opts)
      require("indent_blankline").setup()
    end,
  },

  require("plugins.nvim-lspconfig"),

  {
    "numToStr/Comment.nvim",
    init = function()
      mappings:add_mapping("n", "gcc", {
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        "Toggle comment line",
      })
      mappings:add_mapping(
        "v",
        "gc",
        { "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Toggle comment" }
      )
    end,
  },

  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day",    -- The theme is used when the background is set to light
        transparent = true,     -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark",              -- style for sidebars, see below
          floats = "dark",                -- style for floating windows
        },
        sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false,             -- dims inactive windows
        lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      })
    end,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  require("plugins.hop"),

  { "elkowar/yuck.vim",           lazy = true },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    event = "BufEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = function()
      return require("configs.treesitter-textobjects")
    end,
    config = function(_, opts)
      require("hlargs").setup(opts)
    end,
  },

  {
    "m-demare/hlargs.nvim",
    lazy = true,
    event = "BufEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("hlargs").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    init = function()
      mappings:add_mapping("n", "<leader>tf", { "<cmd> Telescope find_files <CR>", "find files" })
      mappings:add_mapping(
        "n",
        "<leader>ta",
        { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" }
      )
      mappings:add_mapping("n", "<leader>tw", { "<cmd> Telescope live_grep <CR>", "live grep" })
      mappings:add_mapping("n", "<leader>tb", { "<cmd> Telescope buffers <CR>", "find buffers" })
      mappings:add_mapping(
        "n",
        "<leader>tz",
        { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "find in current buffer" }
      )

      -- git
      mappings:add_mapping("n", "<leader>tgc", { "<cmd> Telescope git_commits <CR>", "git commits" })
      mappings:add_mapping("n", "<leader>tgs", { "<cmd> Telescope git_status <CR>", "git status" })

      -- treesitter
      mappings:add_mapping("n", "<leader>tt", { "<cmd> Telescope treesitter <CR>", "Treesitter find" })
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
      mappings:add_mapping(
        "n",
        "<leader>tm",
        { "<cmd> Telescope agrolens query=functions <CR>", "Go to function" }
      )
    end,
    config = function()
      require("telescope").load_extension("agrolens")
    end,
  },

  {
    "gorbit99/codewindow.nvim",
    lazy = true,
    init = function()
      mappings:add_mapping("n", "<leader>mm", {
        function()
          require("codewindow").toggle_minimap()
        end,
        "Open minimap",
      })
    end,
    config = function()
      require("codewindow").setup()
    end,
  },

  {
    "f-person/git-blame.nvim",
    lazy = false,
    config = function()
      vim.g.gitblame_display_virtual_text = 1
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function() end,
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      mappings:add_mapping("n", "<C-b>", { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" })
      mappings:add_mapping("n", "<leader>ft", { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" })
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },

  -- {
  --   "akinsho/bufferline.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   init = function()
  --   end,
  --   opts = function()
  --     return require("configs.bufferline")
  --   end,
  --   config = function(_, opts)
  --     require("bufferline").setup(opts)
  --   end,
  -- },

  {
    "tmillr/sos.nvim",
    opts = function()
      return require("configs.sos")
    end,
    config = function(_, opts)
      require("sos").setup(opts)
    end,
  },

  { "gpanders/editorconfig.nvim", lazy = true, event = "BufEnter" },

  {
    "NvChad/nvim-colorizer.lua",
    opts = function()
      return require("configs.colorizer")
    end,
    config = function(_, opts)
      require("colorizer").setup(opts)
    end,
  },

  {
    "filipdutescu/renamer.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      require("renamer").setup()
    end,
  },

  {
    "cappyzawa/trim.nvim",
    opts = function()
      return require("configs.trim")
    end,
    config = function(_, opts)
      require("trim").setup(opts)
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return require("configs.trouble")
    end,
    config = function(_, opts)
      require("trouble").setup(opts)
    end,
  },

  {
    "Pocco81/high-str.nvim",
    init = function()
      for i = 0, 9 do
        mappings:add_mapping(
          "v",
          "<leader>hs" .. i,
          { "<ESC><cmd>HSHighlight " .. i .. " <CR>", "Highlight with " .. i .. " color" }
        )
        mappings:add_mapping(
          "n",
          "<leader>hs" .. i,
          { "<cmd>HSHighlight " .. i .. " <CR>", "Highlight with " .. i .. " color" }
        )
      end

      mappings:add_mapping("v", "<leader>hr", { "<ESC><cmd>HSRmSHighlight <CR>", "Remove Highlight" })
      mappings:add_mapping("n", "<leader>hr", { "<cmd>HSRmHighlight <CR>", "Remove Highlight" })
    end,
    opts = function()
      return require("configs.highstr")
    end,
    config = function(_, opts)
      require("high-str").setup(opts)
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    build = 'sh -c "cd app && yarn install && NODE_OPTIONS=--openssl-legacy-provider yarn build"',
    lazy = true,
    ft = { "markdown" },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
    config = function(_, opts)
      vim.opt.updatetime = 200

      require("barbecue").setup({
        create_autocmd = false, -- prevent barbecue from updating itself automatically
        theme = 'tokyonight',
        attach_navic = false,
      })

      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end

  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function(_, opts)
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {},
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        tabline = {
          lualine_a = { 'tabs' },
          lualine_b = { 'filename' },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { 'buffers' },
          lualine_z = { 'searchcount' }
        }
      }
    end
  },
  {
    "rcarriga/nvim-notify",
    config = function(_, opts)
      require("telescope").load_extension("notify")
    end,
    init = function()
      vim.notify = require("notify")
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },
  {
    'declancm/cinnamon.nvim',
    config = function() require('cinnamon').setup() end
  }
  -- TODO after 30.04.2024
  -- {
  --   'Bekaboo/dropbar.nvim',
  --   -- optional, but required for fuzzy finder support
  --   dependencies = {
  --     'nvim-telescope/telescope-fzf-native.nvim'
  --   }
  -- }

  -- {
  --   "sindrets/diffview.nvim",
  --   dependencies = 'nvim-lua/plenary.nvim'
  -- }
}

return plugins
