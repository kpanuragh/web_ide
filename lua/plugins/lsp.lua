-- ============================================================================
-- LSP Configuration
-- ============================================================================

return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "folke/neodev.nvim", opts = {} }, -- Better Lua LSP support
    },
    config = function()
      -- Setup mason
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- Get default capabilities with cmp_nvim_lsp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP attach function with keymaps
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Keymaps
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)

        -- Highlight symbol under cursor
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end

      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- Diagnostic signs
      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }
      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      -- Server-specific settings
      local server_settings = {
        -- TypeScript/JavaScript
        ts_ls = {
          filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        },

        -- PHP/Laravel (Intelephense)
        intelephense = {
          settings = {
            intelephense = {
              stubs = {
                "bcmath", "bz2", "calendar", "Core", "curl", "date", "dba", "dom",
                "enchant", "fileinfo", "filter", "ftp", "gd", "gettext", "hash",
                "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring",
                "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "PDO",
                "pdo_mysql", "Phar", "readline", "recode", "Reflection", "regex",
                "session", "SimpleXML", "soap", "sockets", "sodium", "SPL", "standard",
                "superglobals", "sysvsem", "sysvshm", "tokenizer", "xml", "xdebug",
                "xmlreader", "xmlwriter", "yaml", "zip", "zlib",
                "wordpress", "phpunit", "laravel",
              },
              files = {
                maxSize = 5000000,
              },
            },
          },
        },

        -- Python/Django (Pyright)
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },

        -- Go
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },

        -- Rust
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },

        -- Vue (Volar)
        volar = {
          filetypes = { "vue" },
          init_options = {
            typescript = {
              tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib"
            }
          },
        },

        -- Emmet
        emmet_ls = {
          filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        },

        -- ESLint
        eslint = {
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        },

        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
      }

      -- Setup mason-lspconfig with handlers
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Web Development
          "ts_ls",              -- TypeScript/JavaScript (formerly tsserver)
          "html",               -- HTML
          "cssls",              -- CSS
          "tailwindcss",        -- Tailwind CSS
          "emmet_ls",           -- Emmet
          "eslint",             -- ESLint
          "angularls",          -- Angular
          -- Note: Volar needs to be installed manually via: npm install -g @vue/language-server

          -- Backend
          "intelephense",       -- PHP/Laravel
          "pyright",            -- Python/Django
          "gopls",              -- Go
          "rust_analyzer",      -- Rust

          -- Config/Data formats
          "jsonls",             -- JSON
          "yamlls",             -- YAML
          "lua_ls",             -- Lua
          "dockerls",           -- Docker
          "docker_compose_language_service", -- Docker Compose
          "sqlls",              -- SQL
        },
        automatic_installation = true,

        -- Handler to automatically set up servers
        handlers = {
          -- Default handler (applies to all servers without a custom handler)
          function(server_name)
            local server_config = server_settings[server_name] or {}
            server_config.on_attach = server_config.on_attach or on_attach
            server_config.capabilities = capabilities

            require("lspconfig")[server_name].setup(server_config)
          end,
        },
      })
    end,
  },

  -- Mason (LSP/DAP/Linter installer)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
  },
}
