-- ============================================================================
-- Filetype Detection Configuration
-- ============================================================================
-- This file ensures proper filetype detection for all file types,
-- especially PHP in custom projects

-- PHP filetype detection
vim.filetype.add({
  extension = {
    php = "php",
    phtml = "php",
    phps = "php",
    php3 = "php",
    php4 = "php",
    php5 = "php",
    inc = "php",  -- Common in custom PHP projects
  },
  filename = {
    [".php"] = "php",
    [".php_cs"] = "php",
    [".php_cs.dist"] = "php",
  },
  pattern = {
    -- Detect PHP files even without extension if they have PHP tags
    [".*"] = {
      priority = -math.huge,
      function(path, bufnr)
        -- Safely get first line of buffer
        local ok, content = pcall(vim.api.nvim_buf_get_lines, bufnr, 0, 1, false)
        if ok and content and #content > 0 then
          local first_line = content[1]
          -- Check for PHP opening tag or shebang
          if first_line:match("^<%?php") or first_line:match("^#!/.*php") then
            return "php"
          end
        end
      end,
    },
  },
})

-- Additional web filetypes
vim.filetype.add({
  extension = {
    blade = "blade",  -- Laravel Blade templates
    twig = "twig",    -- Symfony Twig templates
  },
})

-- Ensure PHP syntax is set correctly on BufEnter
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.php", "*.phtml", "*.inc", "*.phps" },
  callback = function()
    vim.bo.filetype = "php"
    vim.bo.syntax = "php"
  end,
})

-- For mixed HTML/PHP files, ensure PHP syntax is recognized
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    -- Enable PHP syntax highlighting
    vim.bo.syntax = "php"

    -- Set proper indentation for PHP
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4

    -- Set comment string for PHP
    vim.bo.commentstring = "// %s"

    -- Enable folding for PHP
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
  end,
})
