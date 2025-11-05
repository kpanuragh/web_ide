-- ============================================================================
-- Formatting Configuration (conform.nvim)
-- ============================================================================

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        -- Define formatters by filetype
        formatters_by_ft = {
          -- Web Development
          javascript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          typescriptreact = { { "prettierd", "prettier" } },
          vue = { { "prettierd", "prettier" } },
          css = { { "prettierd", "prettier" } },
          scss = { { "prettierd", "prettier" } },
          less = { { "prettierd", "prettier" } },
          html = { { "prettierd", "prettier" } },
          json = { { "prettierd", "prettier" } },
          jsonc = { { "prettierd", "prettier" } },
          yaml = { { "prettierd", "prettier" } },
          markdown = { { "prettierd", "prettier" } },
          graphql = { { "prettierd", "prettier" } },

          -- Backend
          python = { "ruff_format" },
          go = { "goimports", "gofmt" },
          rust = { "rustfmt" },
          php = { "php_cs_fixer" },

          -- Config/Scripts
          lua = { "stylua" },
          sh = { "shfmt" },
          bash = { "shfmt" },

          -- SQL
          sql = { "sql_formatter" },
        },

        -- Format on save
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end,

        -- Customize formatters
        formatters = {
          ruff_format = {
            -- Enable import sorting (replaces isort)
            prepend_args = { "--select", "I" },
          },
          prettier = {
            -- Look for config files in project root
            prepend_args = function(self, ctx)
              local args = {}

              -- Check for prettier config in project
              local config_files = {
                ".prettierrc",
                ".prettierrc.json",
                ".prettierrc.yml",
                ".prettierrc.yaml",
                ".prettierrc.json5",
                ".prettierrc.js",
                ".prettierrc.cjs",
                "prettier.config.js",
                "prettier.config.cjs",
              }

              for _, config in ipairs(config_files) do
                if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. config) == 1 then
                  return args
                end
              end

              -- Check package.json for prettier config
              local package_json = vim.fn.getcwd() .. "/package.json"
              if vim.fn.filereadable(package_json) == 1 then
                local content = vim.fn.readfile(package_json)
                local json = vim.fn.json_decode(table.concat(content, "\n"))
                if json and json.prettier then
                  return args
                end
              end

              return args
            end,
          },

          php_cs_fixer = {
            command = "php-cs-fixer",
            args = {
              "fix",
              "$FILENAME",
              "--rules=@PSR12",
            },
            stdin = false,
          },
        },
      })

      -- Command to toggle format on save
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! disables formatting globally
          vim.g.disable_autoformat = true
        else
          -- FormatDisable disables formatting for current buffer
          vim.b.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },

  -- Mason installer for formatters
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Formatters
          "prettier",
          "prettierd",
          "stylua",
          -- Note: ruff installed via pip (Mason installation fails)
          "goimports",
          -- Note: gofmt comes with Go, rustfmt comes with Rust (not Mason packages)
          "shfmt",
          "sql-formatter",

          -- Linters
          "eslint_d",
          "golangci-lint",
        },
        auto_update = true,
        run_on_start = true,
      })
    end,
  },
}
