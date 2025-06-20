---@diagnostic disable: missing-fields
return {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {
    "mason.nvim",
  },
  opts = function()
    -- require("spring_boot").init_lsp_commands()
    -- require("lspconfig").jdtls.setup({
    --   init_options = {
    --     bundles = require("spring_boot").java_extensions(),
    --   },
    -- })
    return {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        -- {
        -- spacing = 4,
        -- source = "if_many",
        -- prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
        -- },
        virtual_lines = true,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {

        -- jdtls = {
        --   settings = {
        --     java = {
        --       eclipse = { downloadSources = true },
        --       configuration = { updateBuildConfiguration = "interactive" },
        --       maven = { downloadSources = true },
        --       implementationsCodeLens = { enabled = true },
        --       referencesCodeLens = { enabled = true },
        --       inlayHints = { parameterNames = { enabled = "all" } },
        --       signatureHelp = { enabled = true },
        --       completion = {
        --         favoriteStaticMembers = {
        --           "org.hamcrest.MatcherAssert.assertThat",
        --           "org.hamcrest.Matchers.*",
        --           "org.hamcrest.CoreMatchers.*",
        --           "org.junit.jupiter.api.Assertions.*",
        --           "java.util.Objects.requireNonNull",
        --           "java.util.Objects.requireNonNullElse",
        --           "org.mockito.Mockito.*",
        --         },
        --       },
        --     },
        --   },
        -- },
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          -- ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        jdtls = function()
          return true -- avoid duplicate servers
        end,
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    }
  end,
}
