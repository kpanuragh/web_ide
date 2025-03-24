return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = "VeryLazy",
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        icons_enabled = true,
        globalstatus = true, -- single statusline
        disabled_filetypes = { 'neo-tree', 'lazy', 'NvimTree' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'branch' }, { 'diff' }, { 'diagnostics' } },
        lualine_c = {
          {
            'filename',
            path = 1, -- 0 = name, 1 = relative path, 2 = absolute path
            symbols = {
              modified = ' ●',
              readonly = ' 🔒',
              unnamed = '[No Name]',
            },
          }
        },
        lualine_x = {
          { 'encoding' },
          { 'fileformat' },
          { 'filetype' },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 1,
          }
        },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'lazy', 'man', 'quickfix', 'nvim-dap-ui' },
    }
  end,
}

