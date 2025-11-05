-- ============================================================================
-- Project and Session Management
-- ============================================================================

return {
  -- Project management
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        -- Detection methods
        detection_methods = { "lsp", "pattern" },

        -- Patterns to detect project root
        patterns = {
          ".git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "Makefile",
          "package.json",
          "composer.json",
          "Cargo.toml",
          "go.mod",
          "pyproject.toml",
          "setup.py",
          "requirements.txt",
          "manage.py", -- Django
          "artisan",   -- Laravel
        },

        -- Don't calculate root dir on specific directories
        exclude_dirs = {},

        -- Show hidden files in telescope
        show_hidden = false,

        -- Silent chdir
        silent_chdir = true,

        -- Path to store the project history
        datapath = vim.fn.stdpath("data"),
      })

      -- Integrate with telescope
      require("telescope").load_extension("projects")
    end,
  },

  -- Session management
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_enabled = true,
        auto_session_create_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = false, -- Don't auto-restore, use manual restore
        auto_session_suppress_dirs = {
          "~/",
          "~/Downloads",
          "~/Documents",
          "~/Desktop",
          "/",
        },
        auto_session_use_git_branch = true, -- Separate sessions per git branch

        -- Session lens (Telescope integration)
        session_lens = {
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },

        -- Hooks
        pre_save_cmds = {
          "tabdo Neotree close", -- Close neo-tree before saving session
        },
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save Session" })
      vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore Session" })
      vim.keymap.set("n", "<leader>wd", "<cmd>SessionDelete<CR>", { desc = "Delete Session" })
      vim.keymap.set("n", "<leader>wf", "<cmd>SessionSearch<CR>", { desc = "Find Session" })
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Float" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal Horizontal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal Vertical" },
    },
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          width = function()
            return math.floor(vim.o.columns * 0.9)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.9)
          end,
        },
      })

      -- Terminal keymaps
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },
}
