-- ============================================================================
-- GitHub Copilot Configuration
-- ============================================================================

return {
  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter", -- Load when entering insert mode
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = true,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 18.x
        server_opts_overrides = {},
      })
    end,
  },

  -- Copilot Chat (Optional but highly recommended)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
    },
    keys = {
      { "<leader>cc", ":CopilotChatToggle<CR>", desc = "Copilot Chat Toggle" },
      { "<leader>ce", ":CopilotChatExplain<CR>", desc = "Copilot Explain" },
      { "<leader>cr", ":CopilotChatReview<CR>", desc = "Copilot Review" },
      { "<leader>cf", ":CopilotChatFix<CR>", desc = "Copilot Fix" },
      { "<leader>co", ":CopilotChatOptimize<CR>", desc = "Copilot Optimize" },
    },
    config = function()
      require("CopilotChat").setup({
        debug = false,
        window = {
          layout = "float",
          relative = "editor",
          width = 0.8,
          height = 0.8,
          row = 1,
        },
      })
    end,
  },
}
