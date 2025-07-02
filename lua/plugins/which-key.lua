return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      win = {
        border = "rounded", -- 'none', 'single', 'double', 'shadow'
        padding = { 2, 2, 2, 2 }, -- top, right, bottom, left
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.add({
        -- Buffers
        { "<leader>b", group = "Buffer" },
        { "<leader>bd", "<cmd>Bdelete<cr>", desc = "Delete buffer" },
        { "<leader>bl", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
        { "<leader>bn", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer →" },
        { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
        { "<leader>bp", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer ←" },

        -- Code
        { "<leader>c", group = "Code" },
        { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Saga Code Action" },
        { "<leader>cf", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format" },

        -- Debug
        { "<leader>d", group = "Debug" },
        { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
        { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
        { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
        { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Run Last" },
        { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
        { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
        { "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>", desc = "Open Repl" },
        { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle Dap UI" },

        -- Find / Files
        { "<leader>f", group = "Find" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
        { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
        { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "File Browser" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep (Live)" },
        { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
        { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
        { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },
        { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "TODO Comments" },

        -- Git
        { "<leader>g", group = "Git" },
        { "<leader>gb", "<cmd>G blame<cr>", desc = "Blame Line" },
        { "<leader>gd", "<cmd>G diff<cr>", desc = "Git diff" },
        { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Open Git Diff View" },
        { "<leader>gg", "<cmd>Git<cr>", desc = "Fugitive: Git status" },
        { "<leader>gh", "<cmd>Telescope git_bcommits<cr>", desc = "Git File History" },
        { "<leader>gn", "<cmd>Neogit<cr>", desc = "Open Neogit UI" },
        { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Git Hunk" },
        { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Git Hunk" },
        { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Git Hunk" },
        { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },

        -- Other
        { "<leader>o", "<cmd>Lspsaga outline<cr>", desc = "Document Symbols Outline" },
        { "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "Saga Rename" },
        { "<leader>w", "<cmd>w<cr>", desc = "Save" },
        { "<leader>q", "<cmd>q<cr>", desc = "Quit" },

        -- Optional: Hidden and Proxy
        { "<leader>f1", hidden = true },
        { "<leader>w", proxy = "<C-w>", group = "Window" },

        -- Optional: Dynamic group (if using which-key.extras)
        {
          "<leader>b",
          group = "Buffers",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
      })
    end,
  },
}

