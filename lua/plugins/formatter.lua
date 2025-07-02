

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
        php = { "phpcs" },
        python = { "black" },
        go = { "gofmt" },
        rust = { "rustfmt" },
        lua = { "stylua" },
        blade = { "blade_formatter" },
      },
      format_on_save = false,
    })
  end,
}

