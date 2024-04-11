local mappings = require("mappings");
local events = require("events");
local event_names = require("events.names");
local rx = require("core.rx");

return {
  "neovim/nvim-lspconfig",
  dependencies = require("plugins.nvim-lspconfig.dependencies"),
  init = function()
    mappings:add_mapping("n", "<leader>e", { vim.diagnostic.open_float, "[LSP] Open diagnostic" })
    mappings:add_mapping("n", "<leader>d", { vim.diagnostic.goto_prev, "[LSP] diagnostic go to previous" })
    mappings:add_mapping("n", "]d", { vim.diagnostic.goto_next, "[LSP] diagnostic go to next" })
    mappings:add_mapping("n", "<leader>q", { vim.diagnostic.setloclist, "[LSP] TODO" })

    events:get(event_names.LspAttach, "UserLspConfig", {}, {}):subscribe(rx.Observer:new({
      on_next = function(ev)
        -- vim.print(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings:
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }

        mappings:add_mapping(
          "n",
          "<leader>gD",
          { vim.lsp.buf.declaration, "[LSP] Go to declaration", opts = opts }
        )
        mappings:add_mapping(
          "n",
          "<leader>gd",
          { vim.lsp.buf.definition, "[LSP] Go to definition", opts = opts }
        )
        mappings:add_mapping(
          "n",
          "<leader>gi",
          { vim.lsp.buf.implementation, "[LSP] Go to implementation", opts = opts }
        )
        mappings:add_mapping("n", "<leader>K", { vim.lsp.buf.hover, "[LSP] Hover", opts = opts })
        mappings:add_mapping(
          "n",
          "<leader>gr",
          { vim.lsp.buf.references, "[LSP] Go to references", opts = opts }
        )
        mappings:add_mapping("n", "<C-k>", { vim.lsp.buf.signature_help, "[LSP] signature help", opts = opts })
        mappings:add_mapping(
          "n",
          "<leader>wa",
          { vim.lsp.buf.add_workspace_folder, "[LSP] Add Workspace folder", opts = opts }
        )
        mappings:add_mapping(
          "n",
          "<leader>wr",
          { vim.lsp.buf.remove_workspace_folder, "[LSP] Remove Workspace folder", opts = opts }
        )
        mappings:add_mapping("n", "<leader>wl", {
          function()
            -- TODO Modal?
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end,
          "[LSP] List Workspace folders",
          opts = opts,
        })
        mappings:add_mapping(
          "n",
          "<leader>D",
          { vim.lsp.buf.type_definition, "[LSP] Type definition", opts = opts }
        )
        -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        mappings:add_mapping("n", "<leader>rn", {
          function()
            require("renamer").rename()
          end,
          "[LSP] Rename",
          opts = opts,
        })
        mappings:add_mapping("n", "<leader>ca", { vim.lsp.buf.code_action, "[LSP] Code actions", opts = opts })
        mappings:add_mapping("n", "<leader>bf", {
          function()
            vim.lsp.buf.format({ async = true })
          end,
          "[LSP] Buffer format",
          opts = opts,
        })
        -- if ev.client.server_capabilities["documentSymbolProvider"] then
        --   require("nvim-navic").attach(client, bufnr)
        -- end
      end,
    }))
  end,
  opts = function()
    return require("configs.lsp")
  end,
  config = function(_, opts)
    opts.apply_config(require("lspconfig"))
  end,
}
