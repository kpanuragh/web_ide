-- ============================================================================
-- Framework-Specific Plugins
-- ============================================================================

return {
  -- Laravel/PHP specific
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    keys = {
      { "<leader>la", ":Laravel artisan<cr>", desc = "Laravel Artisan" },
      { "<leader>lr", ":Laravel routes<cr>", desc = "Laravel Routes" },
      { "<leader>lm", ":Laravel related<cr>", desc = "Laravel Related" },
    },
    ft = "php", -- Load for PHP files
    cond = function()
      -- Only load if artisan file exists (Laravel project)
      return vim.fn.filereadable(vim.fn.getcwd() .. "/artisan") == 1
    end,
    config = function()
      require("laravel").setup({
        lsp_server = "intelephense",
        features = {
          null_ls = {
            enable = false,
          },
        },
      })
    end,
  },

  -- Vue.js support (additional)
  {
    "posva/vim-vue",
    ft = "vue",
  },

  -- REST client (DISABLED - causing build issues with luarocks)
  -- Alternatives: Use curl, httpie, Postman, or Insomnia for API testing
  -- Uncomment and run :Lazy clean, then :Lazy sync if you want to try again later
  --[[
  {
    "rest-nvim/rest.nvim",
    -- Note: No dependencies needed - rockspec handles them automatically
    ft = "http",
    keys = {
      { "<leader>rr", "<Plug>RestNvim", desc = "Run request under cursor" },
      { "<leader>rp", "<Plug>RestNvimPreview", desc = "Preview request" },
      { "<leader>rl", "<Plug>RestNvimLast", desc = "Run last request" },
    },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = false,
        result_split_in_place = false,
        skip_ssl_verification = false,
        encode_url = true,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          show_url = true,
          show_http_info = true,
          show_headers = true,
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end,
          },
        },
        jump_to_request = false,
        env_file = ".env",
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end,
  },
  --]]

  -- Database client (for backend work)
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_winwidth = 40

      -- Auto-completion for SQL
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          local cmp = require("cmp")
          local sources = vim.tbl_deep_extend("force", cmp.get_config().sources, {
            { name = "vim-dadbod-completion" },
          })
          cmp.setup.buffer({ sources = sources })
        end,
      })
    end,
  },

  -- Package.json helper
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    config = function()
      require("package-info").setup({
        colors = {
          up_to_date = "#3C4048",
          outdated = "#d19a66",
        },
        icons = {
          enable = true,
          style = {
            up_to_date = "|  ",
            outdated = "|  ",
          },
        },
        autostart = true,
        hide_up_to_date = false,
        hide_unstable_versions = false,
      })
    end,
  },

  -- Markdown preview (for documentation)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
  },

  -- API documentation (Devdocs)
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "DevdocsFetch",
      "DevdocsInstall",
      "DevdocsUninstall",
      "DevdocsOpen",
      "DevdocsOpenFloat",
      "DevdocsOpenCurrent",
    },
    keys = {
      { "<leader>do", "<cmd>DevdocsOpen<cr>", desc = "Open Devdocs" },
      { "<leader>df", "<cmd>DevdocsOpenFloat<cr>", desc = "Open Devdocs Float" },
      { "<leader>dc", "<cmd>DevdocsOpenCurrent<cr>", desc = "Open Devdocs Current" },
    },
    opts = {
      ensure_installed = {
        "html",
        "css",
        "javascript",
        "typescript",
        "vue~3",
        "angular",
        "react",
        "node",
        "php",
        "laravel~10",
        "python~3.12",
        "django~4.2",
        "go",
        "rust",
      },
      float_win = {
        relative = "editor",
        height = 30,
        width = 120,
        border = "rounded",
      },
    },
  },
}
