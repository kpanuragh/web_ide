-- ============================================================================
-- Treesitter Configuration
-- ============================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag", -- Auto close/rename HTML tags
    },
    init = function()
      -- Enable treesitter highlighting before loading
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Install parsers for these languages
        ensure_installed = {
          -- Web Development
          "html", "css", "scss", "javascript", "typescript", "tsx", "vue", "svelte",

          -- Backend (PHP with both parsers for better highlighting)
          "php", "php_only", "phpdoc", "python", "go", "rust",

          -- Config/Data
          "json", "yaml", "toml", "xml",
          "dockerfile", "lua", "vim", "vimdoc",
          "bash", "regex",

          -- Markdown
          "markdown", "markdown_inline",

          -- SQL
          "sql",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          enable = true,
          -- Use both treesitter and traditional highlighting for PHP
          -- This ensures syntax highlighting works even with complex PHP/HTML mixing
          additional_vim_regex_highlighting = { "php", "html" },
          disable = function(lang, buf)
            -- Disable for very large files (>500KB) to prevent performance issues
            local max_filesize = 500 * 1024 -- 500 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
            return false
          end,
        },

        indent = {
          enable = true,
          -- Disable treesitter indent for PHP to use built-in PHP indenting
          -- which handles mixed HTML/PHP better
          disable = { "php" },
        },

        -- Incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },

        -- Text objects
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
        },

        -- Auto tag (for HTML-like languages)
        autotag = {
          enable = true,
        },
      })

      -- Ensure syntax highlighting is enabled
      vim.cmd([[
        syntax enable
        syntax on
      ]])

      -- Set foldmethod to use treesitter if available
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false -- Start with folds open
    end,
  },
}
