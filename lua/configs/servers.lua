local List = require("core.list");
local LangConfig = require("core.lang-config");

--[[
TODO different configs for semgrep for languages
--]]
local servers = List:new {
  inner = {
    -- lua
    LangConfig:new {
      name = "lua_ls",
      filetypes = { "lua", "luau" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.diagnostics.luacheck,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.code_actions.refactoring,
        }
      end,
      enabled = true,
      opts = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              --   {
              --   [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              --   [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              --   [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
              --   []
              -- },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      }
    },
    -- rust
    LangConfig:new {
      name = "rust_analyzer",
      filetypes = { "rust" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.formatting.rustfmt
        }
      end,
      enabled = true,
      opts = {}
    },
    LangConfig:new {
      name = "codelldb",
      filetypes = { "rust" },
      -- null_ls = function(null_ls)
      --   return {
      --     null_ls.builtins.formatting.rustfmt
      --   }
      -- end,
      enabled = false,
      opts = {}
    },
    -- dockerfile
    LangConfig:new {
      name = "dockerls",
      filetypes = { "dockefile" },
      null_ls = function(null_ls)
        return { null_ls.builtins.diagnostics.hadolint }
      end,
      enabled = true,
      opts = {}
    },
    -- docker compose
    LangConfig:new {
      name = "docker_compose_language_service",
      filetypes = { "yaml" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.diagnostics.actionlint,
          null_ls.builtins.formatting.prettier
        }
      end,
      enabled = true,
      opts = {}
    },
    -- go
    LangConfig:new {
      name = "gopls",
      filetypes = function(null_ls)
        return {
          null_ls.builtins.diagnostics.staticcheck,
          null_ls.builtins.code_actions.impl,
          null_ls.builtins.diagnostics.semgrep.with({
            extra_args = { "--config=auto" }
          })
        }
      end,
      enabled = false,
      opts = {}
    },
    -- json
    LangConfig:new {
      name = "jsonls",
      filetypes = { "json" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.diagnostics.spectral,
          null_ls.builtins.formatting.fixjson,
          null_ls.builtins.formatting.prettier
        }
      end,
      enabled = true,
      opts = {}
    },
    -- java
    LangConfig:new {
      name = "jdtls",
      filetypes = { "java" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.diagnostics.checkstyle.with({
            extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
          }),
          null_ls.builtins.diagnostics.semgrep.with({
            extra_args = { "--config=auto" }
          }),
          null_ls.builtins.formatting.google_java_format
        }
      end,
      enabled = true,
      opts = {}
    },
    -- markdown
    LangConfig:new {
      name = "marksman",
      filetypes = { "markdown" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.formatting.markdown_toc,
          null_ls.builtins.formatting.prettier
        }
      end,
      enabled = true,
      opts = {}
    },
    -- openscad
    LangConfig:new {
      name = "openscad_lsp",
      filetypes = {},
      null_ls = function(null_ls)
        return {}
      end,
      enabled = false,
      opts = {}
    },
    -- python
    LangConfig:new {
      name = "pyright",
      filetypes = { "python" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.pycodestyle,
          null_ls.builtins.diagnostics.semgrep.with({
            extra_args = { "--config=auto", "--lang=python" }
          })
        }
      end,
      enabled = true,
      opts = {}
    },
    -- sql
    LangConfig:new {
      name = "sqlls",
      filetypes = { "sql" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "postgres" }, -- change to your dialect
          }),
          null_ls.builtins.formatting.sqlfmt
        }
      end,
      enabled = true,
      opts = {}
    },
    -- solana
    LangConfig:new {
      name = "solang",
      filetypes = {},
      null_ls = function(null_ls)
        return {}
      end,
      enabled = false,
      opts = {}
    },
    -- tailwind
    LangConfig:new {
      name = "tailwindcss",
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "html" },
      null_ls = function(null_ls)
        return { null_ls.builtins.formatting.rustywind }
      end,
      enabled = true,
      opts = {}
    },
    -- typescript
    LangConfig:new {
      name = "ts_ls",
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.tsc,
          null_ls.builtins.diagnostics.xo,
          null_ls.builtins.formatting.prettier
        }
      end,
      enabled = true,
      opts = {}
    },
    -- yaml
    LangConfig:new {
      name = "yamlls",
      filetypes = { "yaml" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.formatting.prettier,
        }
      end,
      enabled = true,
      opts = {}
    },
    -- gradle
    LangConfig:new {
      name = "gradle_ls",
      filetypes = { "groovy" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.diagnostics.npm_groovy_lint,
          null_ls.builtins.formatting.npm_groovy_lint
        }
      end,
      enabled = true,
      opts = {}
    },
    -- emmet
    LangConfig:new {
      name = "emmet_ls",
      filetypes = { "*" },
      null_ls = function(null_ls)
        return {}
      end,
      enabled = true,
      opts = {}
    },
    -- css
    LangConfig:new {
      name = "cssls",
      filetypes = { "css", "sass", "scss", "less", "html", "markdown", "typescriptreact", "javascriptreact" },
      null_ls = function(null_ls)
        return {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylelint
        }
      end,
      enabled = true,
      opts = {}
    },
  }
}

return servers;
