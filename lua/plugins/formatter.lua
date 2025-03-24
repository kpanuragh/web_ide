
return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        php = { "php_cs_fixer" },
        python = { "black" },
        go = { "gofmt" },
        rust = { "rustfmt" },
        lua = { "stylua" },
      },

      format_on_save = function(bufnr)
        -- Only format on save if there are actual changes
        local original = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local current = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
        if table.concat(original, "\n") ~= table.concat(current, "\n") then
          return {
            lsp_fallback = true,
            async = false,
            -- We now format the full buffer (range removed)
          }
        end
        return nil
      end,
    })
     end,
}

