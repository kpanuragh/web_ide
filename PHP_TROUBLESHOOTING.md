# PHP Syntax Highlighting Troubleshooting Guide

If PHP syntax highlighting is not working in your custom projects, follow these steps:

## Quick Fixes

### 1. Check Filetype Detection
Open a PHP file and run:
```vim
:set filetype?
```
It should show: `filetype=php`

If not, manually set it:
```vim
:set filetype=php
```

### 2. Install Treesitter PHP Parsers
```vim
:TSInstall php php_only phpdoc
:TSUpdate
```

### 3. Check Treesitter Status
```vim
:TSModuleInfo
```
Look for `php` in the list. It should show as enabled.

### 4. Reload the File
After installing parsers:
```vim
:edit
```

## Common Issues and Solutions

### Issue: No highlighting in .inc or custom extension files

**Solution:** The configuration now auto-detects these extensions. If it still doesn't work:

```vim
" Add to your project's .nvimrc or .nvim.lua
vim.filetype.add({
  extension = {
    inc = "php",
    module = "php",  -- Drupal
    theme = "php",   -- Drupal
  },
})
```

### Issue: Mixed HTML/PHP files show HTML only

**Solution:** This is now fixed with dual highlighting. Force PHP syntax:

```vim
:set syntax=php
```

Or add this to your filetype config for specific patterns:
```lua
vim.filetype.add({
  pattern = {
    [".*%.template%.php"] = "php",
    [".*%.view%.php"] = "php",
  },
})
```

### Issue: Highlighting works but indenting is broken

**Solution:** PHP indenting is now using Vim's built-in indenter (disabled treesitter indent for PHP).

If you prefer treesitter indent, edit `lua/plugins/treesitter.lua`:
```lua
indent = {
  enable = true,
  -- Remove "php" from this line:
  disable = {},  -- Remove the php entry
},
```

### Issue: Custom framework templates not recognized

**Solution:** Add your framework's template extensions:

```vim
:lua vim.filetype.add({ extension = { tpl = "php", template = "php" } })
```

Or permanently in `lua/config/filetype.lua`.

## Diagnostic Commands

### Check what's highlighting your PHP:
```vim
:TSHighlightCapturesUnderCursor
```

### See all installed parsers:
```vim
:TSInstallInfo
```

### Check health:
```vim
:checkhealth nvim-treesitter
```

### View syntax groups:
```vim
:syntax
```

## Manual Override for Stubborn Files

If a specific file won't highlight, add a modeline at the top or bottom:
```php
<?php
// vim: set filetype=php syntax=php:

// your code here
```

## Performance Considerations

If highlighting is slow on large PHP files:

1. Disable additional regex highlighting:
   Edit `lua/plugins/treesitter.lua`:
   ```lua
   additional_vim_regex_highlighting = false,  -- Instead of { "php" }
   ```

2. Use syntax off for very large files:
   ```vim
   :syntax off
   ```

## Framework-Specific Issues

### Laravel Blade Files
Blade files (`.blade.php`) need a separate parser. Install:
```bash
npm install -g @tailwindcss/language-server
```

Then:
```vim
:TSInstall blade
```

### Symfony Twig Files
```vim
:TSInstall twig
```

### WordPress
WordPress uses standard PHP, should work out of the box. If template parts don't highlight:
```lua
vim.filetype.add({
  pattern = {
    [".*/wp%-content/themes/.*/.*%.php"] = "php",
    [".*/wp%-content/plugins/.*/.*%.php"] = "php",
  },
})
```

## Still Not Working?

1. **Restart Neovim** after installing parsers
2. **Clear cache:** `rm -rf ~/.local/share/nvim`
3. **Reinstall treesitter:**
   ```vim
   :Lazy clean nvim-treesitter
   :Lazy sync
   :TSUpdate
   ```

4. **Check for conflicts:**
   ```vim
   :checkhealth
   ```

5. **Enable debug mode:**
   ```lua
   -- Add to init.lua temporarily
   vim.treesitter.language.inspect_language = true
   ```

## Report Issues

If none of these work, gather this information:
```vim
:version
:TSInstallInfo
:set filetype?
:set syntax?
:lua print(vim.inspect(vim.treesitter.get_parser():parse()[1]:root():type()))
```

And open an issue with the output.

## Quick Reset

To completely reset PHP highlighting:
```vim
:TSUninstall php php_only phpdoc
:TSInstall php php_only phpdoc
:edit
```
