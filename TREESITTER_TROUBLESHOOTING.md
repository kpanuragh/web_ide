# Treesitter Syntax Highlighting Troubleshooting Guide

This guide will help you fix treesitter syntax highlighting issues.

## Quick Fixes

Try these commands in order:

### 1. Check Treesitter Status
```vim
:checkhealth nvim-treesitter
```

This will show you:
- Which parsers are installed
- Which parsers are outdated
- Any configuration issues

### 2. Install/Update Parsers
```vim
:TSInstall all           " Install all parsers
:TSUpdate                " Update all installed parsers
:TSInstall <language>    " Install specific parser (e.g., :TSInstall php)
```

### 3. Check if Treesitter is Running
```vim
:TSBufToggle highlight   " Toggle treesitter highlighting
:TSModuleInfo            " Show treesitter module status
```

### 4. Restart Neovim
```bash
# Completely quit and restart Neovim
:qa!
nvim yourfile.php
```

### 5. Sync Plugins
```vim
:Lazy sync               " Update all plugins
:Lazy clean              " Remove unused plugins
```

---

## Common Issues and Solutions

### Issue 1: No Syntax Highlighting at All

**Symptoms:**
- Files open with no colors
- Everything is plain white/gray text

**Solutions:**

#### A. Check if syntax is enabled:
```vim
:syntax on
:set syntax=<filetype>   " e.g., :set syntax=php
```

#### B. Verify termguicolors is set:
```vim
:set termguicolors?
```
Should show `termguicolors`. If not:
```vim
:set termguicolors
```

#### C. Check if parser is installed:
```vim
:TSInstallInfo
```
Look for your language in the list. If missing or shows `[x]`:
```vim
:TSInstall <language>
```

#### D. Manually enable treesitter highlighting:
```vim
:TSBufEnable highlight
```

### Issue 2: Highlighting Works in Some Files but Not Others

**Symptoms:**
- JavaScript files highlight correctly
- PHP/Python files have no highlighting

**Solutions:**

#### A. Check filetype detection:
```vim
:set filetype?
```
Should show the correct filetype (e.g., `filetype=php`). If not:
```vim
:set filetype=php
```

#### B. Install language-specific parser:
```vim
:TSInstall php
:TSInstall python
:TSInstall javascript
```

#### C. Check if parser is working:
```vim
:TSPlaygroundToggle      " Opens syntax tree (requires playground plugin)
:InspectTree            " Built-in Neovim 0.9+ feature
```

### Issue 3: Highlighting Breaks After Editing

**Symptoms:**
- File opens with correct colors
- Colors disappear after typing/editing

**Solutions:**

#### A. Increase update time:
Add to `lua/config/options.lua`:
```lua
vim.opt.updatetime = 200  -- milliseconds (default: 4000)
```

#### B. Clear and restart highlighting:
```vim
:write                   " Save file
:edit                    " Reload file
:TSBufToggle highlight   " Toggle off
:TSBufToggle highlight   " Toggle on
```

#### C. Check for large files:
The configuration disables treesitter for files >500KB. Check file size:
```vim
:!ls -lh %
```

### Issue 4: Partial/Incorrect Highlighting

**Symptoms:**
- Some parts of code are highlighted
- Others remain plain or incorrectly colored
- Mixed HTML/PHP files look wrong

**Solutions:**

#### A. Use additional regex highlighting (already configured for PHP):
```lua
-- In lua/plugins/treesitter.lua
highlight = {
  enable = true,
  additional_vim_regex_highlighting = { "php", "html" },
}
```

#### B. Update parsers:
```vim
:TSUpdate php
:TSUpdate html
:TSUpdate phpdoc
```

#### C. Install all PHP parsers:
```vim
:TSInstall php
:TSInstall php_only
:TSInstall phpdoc
```

### Issue 5: Error Messages About Missing Parsers

**Symptoms:**
```
Error: no parser for '<language>'
treesitter/highlighter: Error executing lua
```

**Solutions:**

#### A. Install the missing parser:
```vim
:TSInstall <language>
```

#### B. Enable auto-install (already configured):
```lua
-- In lua/plugins/treesitter.lua
auto_install = true,
```

#### C. Manually compile parser:
```bash
cd ~/.local/share/nvim/lazy/nvim-treesitter
nvim --headless -c "TSInstallSync! <language>" -c "qa"
```

### Issue 6: Treesitter Not Loading

**Symptoms:**
- `:TSModuleInfo` shows errors
- Treesitter commands don't work

**Solutions:**

#### A. Check if nvim-treesitter is installed:
```vim
:Lazy
```
Look for `nvim-treesitter` in the list. If missing:
```vim
:Lazy sync
```

#### B. Verify Neovim version:
```vim
:version
```
Neovim 0.9.0+ required for latest treesitter. If older:
```bash
# Upgrade Neovim
./install-ubuntu.sh  # Use the provided installer
```

#### C. Reinstall treesitter:
```vim
:Lazy clean nvim-treesitter
:Lazy sync
:TSUpdate
```

---

## Diagnostic Commands

### Check Installed Parsers
```vim
:TSInstallInfo
```
Shows all available parsers and their installation status.

### Check Active Modules
```vim
:TSModuleInfo
```
Shows which treesitter modules are active for current buffer.

### View Syntax Tree
```vim
:InspectTree
```
Opens a window showing the parsed syntax tree (Neovim 0.9+).

### Highlight Information
```vim
:Inspect
```
Shows highlight groups under cursor.

### Check Treesitter Health
```vim
:checkhealth nvim-treesitter
```
Comprehensive health check.

---

## Manual Parser Installation

If automatic installation fails:

### Method 1: Install from Neovim
```vim
:TSInstall <language>
```

### Method 2: Command Line
```bash
nvim --headless -c "TSInstallSync! all" -c "qa"
```

### Method 3: Specific Parser
```bash
nvim --headless -c "TSInstallSync! php python javascript" -c "qa"
```

---

## Language-Specific Issues

### PHP Files

**Problem:** PHP files have no highlighting

**Solution:**
```vim
:TSInstall php
:TSInstall php_only
:TSInstall phpdoc
:TSInstall html
```

Then restart Neovim and check:
```vim
:set filetype?           " Should show 'php'
:TSBufEnable highlight
```

### JavaScript/TypeScript

**Problem:** JSX/TSX not highlighting

**Solution:**
```vim
:TSInstall javascript
:TSInstall typescript
:TSInstall tsx
:TSInstall jsx
```

### Vue/Svelte

**Problem:** Single-file components not highlighting

**Solution:**
```vim
:TSInstall vue
:TSInstall svelte
:TSInstall html
:TSInstall css
:TSInstall javascript
```

### Python

**Problem:** Python files plain text

**Solution:**
```vim
:TSInstall python
:set filetype=python
```

---

## Configuration Verification

### Check Your Treesitter Config

Open `lua/plugins/treesitter.lua` and verify:

#### 1. Highlight is enabled:
```lua
highlight = {
  enable = true,  -- ✅ Should be true
}
```

#### 2. Auto-install is enabled:
```lua
auto_install = true,  -- ✅ Should be true
```

#### 3. Event triggers are set:
```lua
event = { "BufReadPre", "BufNewFile" },  -- ✅ Loads on file open
```

#### 4. Required parsers are listed:
```lua
ensure_installed = {
  "php", "php_only", "phpdoc",  -- For PHP
  "javascript", "typescript",   -- For JS/TS
  "python", "lua",              -- For Python/Lua
  -- ... your languages
}
```

---

## Performance Issues

### If Highlighting is Slow

#### A. Disable for large files:
Already configured to disable for files >500KB.

#### B. Reduce parsers:
```lua
ensure_installed = {
  -- Only install languages you actually use
  "php", "javascript", "lua",
}
```

#### C. Disable auto-install:
```lua
auto_install = false,
```

Then manually install only needed parsers.

---

## Advanced Debugging

### Enable Debug Logging

Add to `init.lua`:
```lua
vim.lsp.set_log_level("debug")
```

Then check logs:
```vim
:edit ~/.local/state/nvim/lsp.log
```

### Test with Minimal Config

Create `minimal.lua`:
```lua
-- Minimal config for testing
vim.opt.runtimepath:prepend("~/.local/share/nvim/lazy/nvim-treesitter")
require("nvim-treesitter.configs").setup({
  ensure_installed = { "php", "lua" },
  highlight = { enable = true },
})
```

Run:
```bash
nvim -u minimal.lua test.php
```

If this works, there's a conflict in your main config.

---

## Reset Everything (Nuclear Option)

If nothing else works:

### 1. Backup your config:
```bash
cp -r ~/.config/nvim ~/.config/nvim.backup
```

### 2. Remove parser cache:
```bash
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter
rm -rf ~/.local/state/nvim/lazy
```

### 3. Reinstall:
```vim
:Lazy sync
:TSInstall all
```

### 4. Restart Neovim:
```bash
nvim
```

---

## Still Not Working?

### Check Terminal

Some terminals don't support true color:

#### Test true color support:
```bash
curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh | bash
```

If colors don't show, enable true color in your terminal config:

**For Alacritty** (`~/.config/alacritty/alacritty.yml`):
```yaml
env:
  TERM: xterm-256color
```

**For tmux** (`~/.tmux.conf`):
```bash
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"
```

### Check Environment

```bash
echo $TERM          # Should contain "256color"
echo $COLORTERM     # Should be "truecolor" or "24bit"
```

---

## Useful Commands Summary

```vim
" Treesitter
:TSInstall all              " Install all parsers
:TSUpdate                   " Update parsers
:TSBufToggle highlight      " Toggle highlighting
:TSModuleInfo              " Show module status
:checkhealth nvim-treesitter " Health check

" Debugging
:InspectTree               " Show syntax tree
:Inspect                   " Show highlight under cursor
:set filetype?             " Check filetype
:set syntax?               " Check syntax setting

" Plugins
:Lazy sync                 " Update all plugins
:Lazy clean                " Remove unused plugins
:Lazy profile              " Show load times
```

---

## Getting Help

1. Check health: `:checkhealth`
2. Check treesitter specifically: `:checkhealth nvim-treesitter`
3. View installed parsers: `:TSInstallInfo`
4. Check module status: `:TSModuleInfo`
5. If all else fails, see the main troubleshooting guide in README.md

---

**Remember:** After making any configuration changes, restart Neovim completely (`:qa!` then reopen) for changes to take effect!
