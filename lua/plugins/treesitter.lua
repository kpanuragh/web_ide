
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'windwp/nvim-ts-autotag',
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      config = function()
        require('ts_context_commentstring').setup({})
        vim.g.skip_ts_context_commentstring_module = true
      end
    },
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        -- Web
        'html', 'css', 'scss', 'javascript', 'typescript', 'tsx', 'json', 'yaml',
        -- PHP / Laravel
        'php', 'blade',
        -- Backend
        'python', 'go', 'gomod', 'rust',
        -- Dev tools
        'lua', 'bash', 'regex', 'sql', 'dockerfile',
        -- Misc
        'markdown', 'markdown_inline', 'comment', 'vim', 'vimdoc',
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<CR>',
          scope_incremental = '<TAB>',
          node_decremental = '<S-TAB>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
          },
        },
      },
    })

    

    -- Optional: Treesitter context (sticky header)
    require('treesitter-context').setup({
      enable = true,
      max_lines = 3,
      trim_scope = 'outer',
    })
  end,
}

