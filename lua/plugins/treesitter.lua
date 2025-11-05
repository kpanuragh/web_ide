-- ============================================================================
-- Treesitter Configuration
-- ============================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag", -- Auto close/rename HTML tags
    },
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
            -- Don't disable highlighting for any language
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
    end,
  },
}
