-- ============================================================================
-- Lazy.nvim Plugin Manager Configuration
-- ============================================================================

require("lazy").setup({
  -- Import all plugin specs from lua/plugins/
  { import = "plugins" },
}, {
  -- Lazy.nvim options
  install = {
    colorscheme = { "tokyonight", "habamax" },
  },
  checker = {
    enabled = true,       -- Check for plugin updates
    notify = false,       -- Don't notify about updates
  },
  change_detection = {
    notify = false,       -- Don't notify about config changes
  },

  -- Luarocks support (disabled - not needed without rest.nvim)
  -- rocks = {
  --   enabled = true,
  --   hererocks = true,
  -- },

  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
