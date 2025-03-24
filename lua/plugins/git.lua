return {
  -- Git signs in the gutter
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(gs.next_hunk)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(gs.prev_hunk)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map('n', '<leader>gp', gs.preview_hunk, { desc = "Preview Git Hunk" })
          map('n', '<leader>gr', gs.reset_hunk, { desc = "Reset Git Hunk" })
          map('n', '<leader>gb', gs.blame_line, { desc = "Blame Line" })
          map('n', '<leader>gs', gs.stage_hunk, { desc = "Stage Git Hunk" })
          map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        end,
      })
    end,
  },

  -- Git commands (e.g., :Git, :Gdiffsplit)
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gdiffsplit', 'Gwrite', 'Gread', 'Glog' },
    keys = {
      { "<leader>gg", ":Git<CR>", desc = "Fugitive: Git status" },
      { "<leader>gd", ":Gdiffsplit<CR>", desc = "Git diff" },
    },
  },

  -- Diff viewer
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen<CR>", desc = "Open Git Diff View" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "Git File History" },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
  },

  -- Optional: Magit-style UI
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    keys = {
      { "<leader>gn", "<cmd>Neogit<CR>", desc = "Open Neogit UI" },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = true,
  },
}

