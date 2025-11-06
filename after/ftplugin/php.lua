-- ============================================================================
-- PHP Filetype Plugin - LSP Keybindings Fallback
-- ============================================================================
--
-- This file ensures LSP keybindings are set for PHP files even if
-- the on_attach function doesn't run properly. It runs after all other
-- plugins have loaded.
--
-- Location: ~/.config/nvim/after/ftplugin/php.lua

-- Only set keymaps if LSP is actually attached
vim.schedule(function()
  local buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf })

  if #clients == 0 then
    -- LSP not attached, don't set keymaps
    return
  end

  -- Helper function to set keymaps safely
  local function map(mode, lhs, rhs, desc)
    -- Check if keymap already exists
    local existing = vim.fn.maparg(lhs, mode, false, true)
    if existing and existing.buffer == buf then
      -- Keymap already set for this buffer
      return
    end

    -- Set the keymap
    vim.keymap.set(mode, lhs, rhs, {
      noremap = true,
      silent = true,
      buffer = buf,
      desc = desc,
    })
  end

  -- LSP navigation keymaps
  map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
  map("n", "gr", vim.lsp.buf.references, "LSP: Find references")
  map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
  map("n", "gt", vim.lsp.buf.type_definition, "LSP: Go to type definition")
  map("n", "K", vim.lsp.buf.hover, "LSP: Hover documentation")
  map("n", "<leader>k", vim.lsp.buf.signature_help, "LSP: Signature help")
  map("i", "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature help (insert)")
  map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename symbol")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
  map("v", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action (visual)")
  map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "LSP: Format buffer")

  -- Diagnostic keymaps
  map("n", "[d", vim.diagnostic.goto_prev, "LSP: Previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "LSP: Next diagnostic")
  map("n", "<leader>e", vim.diagnostic.open_float, "LSP: Show diagnostic")
  map("n", "<leader>dl", vim.diagnostic.setloclist, "LSP: Diagnostic loclist")
end)
