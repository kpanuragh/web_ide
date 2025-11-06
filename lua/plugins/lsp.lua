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
        -- Notify that LSP attached (only in debug mode)
        if vim.g.lsp_debug then
          vim.notify(
            string.format("LSP attached: %s", client.name),
            vim.log.levels.INFO
          )
        end

        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- LSP keymaps with descriptions
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))

        -- Diagnostic keymaps with descriptions
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
        vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostic loclist" }))

        -- Highlight symbol under cursor (buffer-local autocmds, no group needed)
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- Set buffer option to indicate LSP is attached
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
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
          -- Define root directory patterns for PHP projects
          -- This helps Intelephense find project root in custom PHP projects
          root_dir = function(fname)
            local lspconfig_util = require("lspconfig.util")
            return lspconfig_util.root_pattern(
              "composer.json",   -- Composer projects
              ".git",            -- Git repositories
              "index.php",       -- Custom PHP projects
              "public/index.php",-- Framework-style projects
              "src/",            -- PSR structure
              "app/",            -- Laravel/framework structure
              ".intelephense"    -- Explicit marker file
            )(fname) or vim.fn.getcwd()
          end,
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
                associations = { "*.php", "*.phtml", "*.inc", "*.module" },
              },
              environment = {
                includePaths = {},  -- Add custom include paths if needed
              },
              completion = {
                fullyQualifyGlobalConstantsAndFunctions = false,
                triggerParameterHints = true,
                insertUseDeclaration = true,
                maxItems = 100,
              },
              format = {
                enable = true,
              },
              diagnostics = {
                enable = true,
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

            -- Setup with error handling
            local ok, err = pcall(function()
              require("lspconfig")[server_name].setup(server_config)
            end)

            if not ok then
              vim.notify(
                string.format("Failed to setup LSP server '%s': %s", server_name, err),
                vim.log.levels.WARN
              )
            end
          end,
        },
      })

      -- ========================================================================
      -- User Commands for LSP Troubleshooting
      -- ========================================================================

      -- Command to check LSP status
      vim.api.nvim_create_user_command("LspStatus", function()
        local buf = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({ bufnr = buf })

        if #clients == 0 then
          vim.notify("No LSP client attached to this buffer", vim.log.levels.WARN)
          vim.notify("Run :LspInfo for detailed information", vim.log.levels.INFO)
        else
          for _, client in ipairs(clients) do
            vim.notify(string.format("✓ LSP Active: %s", client.name), vim.log.levels.INFO)
          end
        end
      end, { desc = "Check LSP status for current buffer" })

      -- Command to restart LSP
      vim.api.nvim_create_user_command("LspRestart", function()
        vim.lsp.stop_client(vim.lsp.get_clients())
        vim.defer_fn(function()
          vim.cmd("edit")
        end, 500)
        vim.notify("LSP restarted", vim.log.levels.INFO)
      end, { desc = "Restart all LSP clients" })

      -- Command to toggle LSP debug mode
      vim.api.nvim_create_user_command("LspDebug", function()
        vim.g.lsp_debug = not vim.g.lsp_debug
        vim.lsp.set_log_level(vim.g.lsp_debug and "DEBUG" or "WARN")
        vim.notify(
          string.format("LSP debug mode: %s", vim.g.lsp_debug and "ON" or "OFF"),
          vim.log.levels.INFO
        )
      end, { desc = "Toggle LSP debug mode" })

      -- Command to check LSP keymaps
      vim.api.nvim_create_user_command("LspKeymaps", function()
        local buf = vim.api.nvim_get_current_buf()
        local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")

        local lsp_maps = {}
        for _, map in ipairs(keymaps) do
          if map.lhs:match("^g[dDri]") or map.lhs == "K" or map.lhs:match("^%[d") or map.lhs:match("^%]d") then
            table.insert(lsp_maps, string.format("%s -> %s", map.lhs, map.desc or "LSP command"))
          end
        end

        if #lsp_maps == 0 then
          vim.notify("No LSP keymaps found. LSP may not be attached.", vim.log.levels.WARN)
        else
          vim.notify("LSP Keymaps:\n" .. table.concat(lsp_maps, "\n"), vim.log.levels.INFO)
        end
      end, { desc = "Show LSP keymaps for current buffer" })

      -- ========================================================================
      -- Autocmd to ensure LSP attaches to PHP files
      -- ========================================================================

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "php",
        callback = function(args)
          local buf = args.buf

          -- Check if LSP is already attached after a delay
          vim.defer_fn(function()
            -- Only proceed if buffer is still valid
            if not vim.api.nvim_buf_is_valid(buf) then
              return
            end

            local clients = vim.lsp.get_clients({ bufnr = buf })
            if #clients == 0 then
              -- Try to start LSP manually
              vim.notify("Auto-starting Intelephense for PHP file...", vim.log.levels.INFO)
              vim.cmd("LspStart intelephense")

              -- Verify it attached after another delay
              vim.defer_fn(function()
                if not vim.api.nvim_buf_is_valid(buf) then
                  return
                end

                local attached = vim.lsp.get_clients({ bufnr = buf })
                if #attached == 0 then
                  vim.notify(
                    "Intelephense failed to attach. Try :LspInfo or :LspRestart",
                    vim.log.levels.WARN
                  )
                else
                  vim.notify("Intelephense attached successfully!", vim.log.levels.INFO)
                end
              end, 1000)
            end
          end, 500)
        end,
      })

      -- ========================================================================
      -- Additional command for PHP project setup
      -- ========================================================================

      vim.api.nvim_create_user_command("PhpProjectSetup", function()
        local cwd = vim.fn.getcwd()
        local marker_file = cwd .. "/.intelephense"

        -- Create .intelephense marker file if it doesn't exist
        if vim.fn.filereadable(marker_file) == 0 then
          local file = io.open(marker_file, "w")
          if file then
            file:write("# Intelephense project marker\n")
            file:write("# This file helps Intelephense identify the project root\n")
            file:close()
            vim.notify("Created .intelephense marker file", vim.log.levels.INFO)
          end
        end

        -- Restart LSP
        vim.cmd("LspRestart")
        vim.notify("PHP project configured. LSP restarted.", vim.log.levels.INFO)
      end, { desc = "Setup current directory as PHP project root" })
    end,
  },

  -- Mason (LSP/DAP/Linter installer)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
  },
}
