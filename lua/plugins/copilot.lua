
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  build = ":Copilot auth",
  opts = {
    suggestion = { enabled = false }, -- handled by cmp
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = false,
    },
  },
}

