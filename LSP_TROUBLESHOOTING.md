# LSP Troubleshooting Guide

If LSP commands like `gd` (go to definition) are not working, follow this guide to diagnose and fix the issue.

## Quick Diagnosis

### Step 1: Check if LSP is attached
```vim
:LspStatus
```
This will tell you if an LSP client is attached to the current buffer.

### Step 2: Check detailed LSP info
```vim
:LspInfo
```
This shows all LSP clients and their status.

### Step 3: Check if keymaps are set
```vim
:LspKeymaps
```
This shows all LSP keymaps for the current buffer.

## Common Issues and Solutions

### Issue 1: "No LSP client attached"

**Cause**: The LSP server didn't start for this file.

**Solutions**:

1. **Check if the LSP server is installed**:
   ```vim
   :Mason
   ```
   Look for `intelephense` (PHP), `ts_ls` (JS/TS), etc.
   If not installed, select it and press `i` to install.

2. **Manually start the LSP**:
   ```vim
   :LspStart intelephense    " For PHP
   :LspStart ts_ls           " For JavaScript/TypeScript
   :LspStart pyright         " For Python
   ```

3. **Check filetype**:
   ```vim
   :set filetype?
   ```
   It should show the correct filetype (e.g., `filetype=php`).
   If wrong, set it: `:set filetype=php`

4. **Restart LSP**:
   ```vim
   :LspRestart
   ```

### Issue 2: "LSP attached but gd doesn't work"

**Cause**: Keymaps aren't set, or LSP doesn't have definition provider.

**Solutions**:

1. **Check LSP capabilities**:
   ```vim
   :lua =vim.lsp.get_clients()[1].server_capabilities
   ```
   Look for `definitionProvider = true`

2. **Check if keymaps exist**:
   ```vim
   :LspKeymaps
   ```
   Should show `gd -> Go to definition`

3. **Manually set keymap**:
   ```vim
   :nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
   ```

4. **Check if there's a symbol under cursor**:
   - `gd` only works when cursor is on a class, function, or variable name
   - Try hovering over a symbol first with `K`

### Issue 3: LSP keeps disconnecting

**Cause**: LSP server crashes or timeout issues.

**Solutions**:

1. **Enable debug mode**:
   ```vim
   :LspDebug
   ```
   Then check logs: `:lua vim.cmd('e ' .. vim.lsp.get_log_path())`

2. **Increase timeout** (add to `init.lua`):
   ```lua
   vim.g.lsp_timeout = 10000  -- 10 seconds
   ```

3. **Check for errors**:
   ```vim
   :checkhealth nvim-lspconfig
   ```

4. **Reinstall LSP server**:
   ```vim
   :Mason
   " Uninstall then reinstall the problematic server
   ```

### Issue 4: LSP works but very slow

**Cause**: Large project or LSP analyzing too many files.

**Solutions**:

1. **Add `.gitignore` patterns** - LSP respects them

2. **Limit workspace scanning** (for PHP/Intelephense):
   Create `.intelephense/config.json` in project root:
   ```json
   {
     "exclude": [
       "vendor/**",
       "node_modules/**",
       "storage/**",
       "public/**"
     ]
   }
   ```

3. **Disable certain LSP features**:
   ```vim
   :lua vim.lsp.buf.document_highlight()  -- Disable highlighting
   ```

### Issue 5: PHP-specific issues

**Symptom**: LSP doesn't work in custom PHP projects.

**Solutions**:

1. **Ensure Intelephense is installed**:
   ```vim
   :Mason
   ```
   Look for `intelephense`, install if needed.

2. **Check if PHP LSP is starting**:
   ```vim
   :LspStatus
   ```
   Should show "✓ LSP Active: intelephense"

3. **Manually start Intelephense**:
   ```vim
   :LspStart intelephense
   ```

4. **Check for composer.json**:
   Intelephense works better with `composer.json` in project root.
   Even if not using Composer, create an empty one:
   ```json
   {
     "name": "my-project/custom-framework",
     "autoload": {
       "psr-4": {
         "App\\": "app/"
       }
     }
   }
   ```

5. **Set include paths** (for custom frameworks):
   Create `.intelephense/config.json`:
   ```json
   {
     "environment": {
       "includePaths": [
         "/path/to/framework/libraries",
         "/path/to/custom/includes"
       ]
     }
   }
   ```

6. **Check PHP executable**:
   ```bash
   which php
   # Make sure it's in PATH
   ```

## Diagnostic Commands Reference

| Command | Purpose |
|---------|---------|
| `:LspStatus` | Check if LSP is attached to current buffer |
| `:LspInfo` | Detailed LSP information |
| `:LspRestart` | Restart all LSP clients |
| `:LspDebug` | Toggle debug mode |
| `:LspKeymaps` | Show LSP keymaps |
| `:Mason` | Open Mason to manage LSP servers |
| `:checkhealth lsp` | Check LSP health |

## LSP Keybindings Reference

### Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |

### Information
| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `<leader>k` | Signature help (normal mode) |
| `<C-k>` | Signature help (insert mode) |

### Refactoring
| Key | Action |
|-----|--------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format buffer |

### Diagnostics
| Key | Action |
|-----|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>e` | Show diagnostic float |
| `<leader>dl` | Diagnostic loclist |

## Testing LSP Functionality

### Test 1: Hover Documentation
1. Open a PHP file
2. Place cursor on a function name
3. Press `K`
4. Should show documentation

**If not working**: LSP not attached or no docs available

### Test 2: Go to Definition
1. Place cursor on a function call
2. Press `gd`
3. Should jump to function definition

**If not working**:
- Check `:LspStatus`
- Ensure function is in project (not vendor/library)
- Try `gr` (find references) instead

### Test 3: Code Completion
1. Enter insert mode
2. Start typing a class name
3. Should see completions popup

**If not working**:
- LSP not attached
- Or nvim-cmp not configured
- Run `:checkhealth nvim-cmp`

## Advanced Troubleshooting

### View LSP Logs
```vim
:lua vim.cmd('e ' .. vim.lsp.get_log_path())
```

### Check LSP Server Output
```vim
:LspDebug  " Enable debug mode
" Then check messages with:
:messages
```

### Check LSP Capabilities
```vim
:lua =vim.lsp.get_clients()[1].server_capabilities
```

### Manually Trigger LSP Attach
```lua
-- Add to init.lua temporarily
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.lsp.start({
      name = "intelephense",
      cmd = { "intelephense", "--stdio" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})
```

## Still Not Working?

### Complete Reset

1. **Stop all LSP clients**:
   ```vim
   :lua vim.lsp.stop_client(vim.lsp.get_clients())
   ```

2. **Reinstall LSP server**:
   ```vim
   :Mason
   " Press 'X' on server to uninstall
   " Press 'i' to reinstall
   ```

3. **Clear LSP cache**:
   ```bash
   rm -rf ~/.local/share/nvim/mason/
   rm -rf ~/.local/state/nvim/lsp.log
   ```

4. **Restart Neovim**:
   ```bash
   nvim
   :Lazy sync
   :Mason
   ```

### Gather Debug Information

If you need to report an issue, gather this information:

```vim
:version
:LspInfo
:LspStatus
:checkhealth lsp
:lua print(vim.inspect(vim.lsp.get_clients()))
```

And check the log:
```vim
:lua vim.cmd('e ' .. vim.lsp.get_log_path())
```

## Project-Specific Configuration

For custom PHP projects, create `.vim/coc-settings.json` or Intelephense config:

```json
{
  "intelephense": {
    "stubs": [
      "apache",
      "bcmath",
      "Core",
      "date",
      "json",
      "mbstring",
      "mysqli",
      "pdo",
      "standard"
    ],
    "files": {
      "maxSize": 5000000,
      "associations": ["*.php", "*.inc", "*.module"]
    }
  }
}
```

## Framework-Specific Tips

### Laravel
- Intelephense automatically detects Laravel
- Install `barryvdh/laravel-ide-helper` for better completion
- Run `php artisan ide-helper:generate`

### Symfony
- Create proper `composer.json` with autoload
- Use PSR-4 autoloading

### WordPress
- Intelephense includes WordPress stubs by default
- For themes/plugins, ensure proper directory structure

### Custom Frameworks
- Create `composer.json` with PSR-4 autoloading
- Set include paths in `.intelephense/config.json`
- Use proper namespaces

## Performance Tips

1. **Exclude unnecessary directories**:
   - Add to `.gitignore`: `vendor/`, `node_modules/`, `storage/`

2. **Limit file associations**:
   - Only `.php` files, not `.txt` or logs

3. **Disable unused LSP features**:
   ```lua
   -- In LSP on_attach
   client.server_capabilities.semanticTokensProvider = nil
   ```

4. **Increase update time**:
   ```lua
   vim.opt.updatetime = 500  -- Default is 200
   ```

## Common Error Messages

### "LSP: Server ... exited with code 1"
- **Fix**: Reinstall the LSP server via `:Mason`

### "method textDocument/definition is not supported"
- **Fix**: The LSP server doesn't support go-to-definition. Check `:LspInfo`

### "No information available"
- **Fix**: Symbol not found. Might be in vendor/library not indexed.

### "Request textDocument/definition failed"
- **Fix**: LSP server error. Check logs and restart LSP.

---

For more help, run `:help lsp` or `:checkhealth lsp`
