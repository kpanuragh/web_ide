return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- or "tabs"
        numbers = "none",
        close_command = "bdelete! %d",       -- buffer close
        right_mouse_command = "bdelete! %d", -- right-click close
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        separator_style = "thin", -- or "slant", "padded_slant", "thick"
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        persist_buffer_sort = true,
        always_show_bufferline = true,
        sort_by = "directory",
      },
    })
  end,
}

