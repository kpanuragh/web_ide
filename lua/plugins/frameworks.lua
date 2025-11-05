-- ============================================================================
-- Framework-Specific Plugins
-- ============================================================================

return {
  -- PHP Development Tools
  -- Note: laravel.nvim works great for all PHP projects, not just Laravel!
  -- It provides Composer commands, class navigation, and more
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    keys = {
      { "<leader>pa", ":Laravel artisan<cr>", desc = "PHP Artisan (Laravel)" },
      { "<leader>pc", ":Composer<cr>", desc = "PHP Composer" },
      { "<leader>pr", ":Laravel routes<cr>", desc = "PHP Routes (Laravel)" },
      { "<leader>pm", ":Laravel related<cr>", desc = "PHP Related Files" },
    },
    ft = "php", -- Load for all PHP files
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

  -- PHP Namespace helper - Auto-add namespace declarations
  {
    "arnaud-lb/vim-php-namespace",
    ft = "php",
    keys = {
      { "<leader>pn", "<cmd>call PhpInsertUse()<cr>", desc = "PHP Insert Use Statement", mode = "n" },
      { "<leader>pe", "<cmd>call PhpExpandClass()<cr>", desc = "PHP Expand Class", mode = "n" },
      { "<leader>ps", "<cmd>call PhpSortUse()<cr>", desc = "PHP Sort Use Statements", mode = "n" },
    },
  },

  -- PHP Refactoring tools
  {
    "phpactor/phpactor",
    ft = "php",
    build = "composer install --no-dev --optimize-autoloader",
    keys = {
      { "<leader>pi", "<cmd>PhpactorImportClass<cr>", desc = "PHP Import Class" },
      { "<leader>pf", "<cmd>PhpactorFindReferences<cr>", desc = "PHP Find References" },
      { "<leader>pt", "<cmd>PhpactorTransform<cr>", desc = "PHP Transform/Refactor" },
      { "<leader>pg", "<cmd>PhpactorGenerateAccessor<cr>", desc = "PHP Generate Getter/Setter" },
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "php",
        callback = function()
          vim.bo.omnifunc = "phpactor#Complete"
        end,
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
        -- Frontend
        "html",
        "css",
        "javascript",
        "typescript",
        "vue~3",
        "angular",
        "react",
        "node",

        -- PHP & Frameworks
        "php",
        "laravel~10",
        "symfony~6",
        "codeigniter~4",
        "wordpress",
        "phpunit",

        -- Python
        "python~3.12",
        "django~4.2",

        -- Other Languages
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
