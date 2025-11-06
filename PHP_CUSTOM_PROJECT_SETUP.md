# Custom PHP Project Setup Guide

This guide will help you set up LSP (Intelephense) for custom PHP projects so that features like "go to definition" (gd) work correctly.

## Quick Fix for Custom PHP Projects

If `gd` (go to definition) is not working in your custom PHP project, try this quick fix:

### Method 1: Automatic Setup Command

```vim
:PhpProjectSetup
```

This command will:
1. Create a `.intelephense` marker file in your project root
2. Restart the LSP server
3. Ensure Intelephense recognizes your project

### Method 2: Manual Setup

Navigate to your project root directory and run:

```bash
# Navigate to your PHP project root
cd /path/to/your/custom/php/project

# Create marker file
touch .intelephense

# Open a PHP file
nvim yourfile.php
```

---

## Understanding the Problem

### Why LSP Doesn't Work in Custom Projects

Intelephense (the PHP LSP server) needs to identify the **project root directory** to properly index your code. It looks for specific marker files/directories:

**Standard Markers:**
- `composer.json` (Composer projects)
- `.git` (Git repositories)
- `vendor/` (Composer dependencies)

**Custom Project Markers (now supported):**
- `index.php` (main entry point)
- `public/index.php` (framework-style structure)
- `src/` (PSR structure)
- `app/` (application directory)
- `.intelephense` (explicit marker)

If your custom project doesn't have any of these, Intelephense won't know where the project root is, and features like "go to definition" won't work across files.

---

## Setting Up Custom PHP Projects

### Step 1: Identify Your Project Root

Your project root is typically where:
- Your main entry point (`index.php`) is located
- Or where you want Intelephense to start indexing from
- Or the top-level directory containing all your PHP files

Example structures:

**Flat Custom Project:**
```
/var/www/mysite/
├── index.php       ← Project root
├── functions.php
├── classes/
│   └── User.php
└── includes/
    └── config.php
```

**Organized Custom Project:**
```
/var/www/myapp/
├── public/         ← Or here
│   └── index.php
├── src/            ← Or here
│   ├── Models/
│   ├── Controllers/
│   └── Views/
└── config/
```

### Step 2: Create Project Marker

Navigate to your project root and create **one of these**:

#### Option A: .intelephense Marker (Recommended)

```bash
cd /path/to/your/project
touch .intelephense
```

Or from within Neovim:
```vim
:PhpProjectSetup
```

#### Option B: composer.json (If not present)

```bash
cd /path/to/your/project
echo '{"name": "myproject/app", "description": "My custom PHP project"}' > composer.json
```

#### Option C: Initialize Git (If not a git repo)

```bash
cd /path/to/your/project
git init
```

### Step 3: Restart Neovim

```vim
:qa!
```

Then reopen your PHP files.

### Step 4: Verify LSP Attached

```vim
:LspStatus
:LspInfo
```

Should show: `✓ LSP Active: intelephense`

---

## Troubleshooting

### Issue 1: LSP Still Not Attaching

**Check if Intelephense is installed:**
```vim
:Mason
```
Look for `intelephense` in the list. If not installed:
```vim
:MasonInstall intelephense
```

**Manually start LSP:**
```vim
:LspStart intelephense
```

**Check for errors:**
```vim
:LspInfo
:messages
```

### Issue 2: "gd" Goes to Wrong File or Doesn't Work

**Causes:**
- Intelephense hasn't indexed your project yet
- Project root is wrong
- Files are outside the project root

**Solutions:**

#### A. Wait for Indexing
Intelephense needs time to index large projects. Check status:
```vim
:LspInfo
```

#### B. Force Re-index
```vim
:LspRestart
```

Then wait 10-30 seconds for indexing to complete.

#### C. Check Project Root
```vim
:lua print(vim.lsp.get_active_clients()[1].config.root_dir)
```

This should show your project root directory. If it's wrong:
1. Close Neovim
2. Make sure you have a marker file (`.intelephense`, `composer.json`, `.git`)
3. Open Neovim from the correct directory: `nvim /path/to/project/file.php`

### Issue 3: Works in Some Files but Not Others

**Cause:** Files are outside the detected project root.

**Solution:**

Make sure all your PHP files are under the project root where you created the marker file.

**Example:**
```
/var/www/
├── mysite/
│   ├── .intelephense    ← Marker at root
│   ├── index.php        ← Works
│   ├── includes/
│   │   └── config.php   ← Works
│   └── classes/
│       └── User.php     ← Works
└── external.php         ← Won't work (outside root)
```

To fix, either:
1. Move `external.php` into `mysite/`
2. Create `.intelephense` at `/var/www/` level

### Issue 4: "textDocument/definition not supported"

**Cause:** LSP not attached or Intelephense crashed.

**Solution:**
```vim
:LspStatus
:LspRestart
:checkhealth lsp
```

### Issue 5: Slow or No Response

**Large Project:**
Intelephense is still indexing. Wait or check:
```vim
:messages
```

**File Too Large:**
Configuration skips files >5MB. Check:
```bash
ls -lh yourfile.php
```

**Memory Issue:**
Increase Intelephense max size:
```bash
# Add to project root: intelephense.json
{
  "files.maxSize": 10000000
}
```

---

## Advanced Configuration

### Project-Specific Settings

Create `.intelephense/` directory in project root:

```bash
mkdir -p .intelephense
```

#### Custom Include Paths

If you have files in multiple locations:

Create `intelephense.json` in project root:
```json
{
  "environment.includePaths": [
    "/path/to/external/lib",
    "/path/to/another/lib"
  ]
}
```

#### Custom Stubs

Add framework-specific stubs:

```json
{
  "stubs": [
    "wordpress",
    "woocommerce",
    "acf-pro"
  ]
}
```

### Workspace Configuration

Create `.vim/` directory in project root:

```bash
mkdir -p .vim
```

Create `.vim/coc-settings.json` (if using coc.nvim) or add to Neovim config:

```lua
-- In project root: .nvim.lua
vim.lsp.start({
  name = "intelephense",
  cmd = { "intelephense", "--stdio" },
  root_dir = vim.fn.getcwd(),
  settings = {
    intelephense = {
      environment = {
        includePaths = {
          "/custom/path/to/includes",
        },
      },
    },
  },
})
```

---

## Directory Structure Recommendations

### PSR-4 Structure (Recommended)

```
myproject/
├── .intelephense          # Project marker
├── composer.json          # Package definition
├── public/
│   └── index.php          # Entry point
├── src/
│   ├── Controllers/
│   ├── Models/
│   ├── Views/
│   └── Helpers/
├── config/
└── vendor/               # Composer dependencies
```

**Benefits:**
- Standard structure
- Better IDE support
- Easy to maintain
- Follows PHP-FIG standards

### Classic PHP Structure

```
mysite/
├── .intelephense          # Project marker
├── index.php              # Main entry
├── includes/
│   ├── config.php
│   ├── functions.php
│   └── db.php
├── classes/
│   ├── User.php
│   └── Database.php
└── templates/
    ├── header.php
    └── footer.php
```

**Works well for:**
- Small projects
- Legacy codebases
- Simple websites

---

## Autoloading and Namespaces

### Without Composer (Manual Includes)

If using `include` or `require`:

**functions.php:**
```php
<?php
function myFunction() {
    // ...
}
```

**index.php:**
```php
<?php
require_once __DIR__ . '/functions.php';

myFunction(); // Intelephense can find this after indexing
```

### With Composer Autoloading (Recommended)

**composer.json:**
```json
{
  "autoload": {
    "psr-4": {
      "MyApp\\": "src/"
    }
  }
}
```

Run:
```bash
composer dump-autoload
```

**src/Controllers/UserController.php:**
```php
<?php
namespace MyApp\Controllers;

class UserController {
    public function index() {
        // ...
    }
}
```

**public/index.php:**
```php
<?php
require_once __DIR__ . '/../vendor/autoload.php';

use MyApp\Controllers\UserController;

$controller = new UserController(); // gd will work!
```

---

## Verification Checklist

After setup, verify everything works:

### 1. LSP Status
```vim
:LspStatus
```
Expected: `✓ LSP Active: intelephense`

### 2. Test "gd" (Go to Definition)
- Open a PHP file that uses a function/class from another file
- Place cursor on the function/class name
- Press `gd`
- Should jump to definition

### 3. Test Hover (K)
- Place cursor on a function
- Press `K`
- Should show documentation

### 4. Test Completion
- Start typing a function name
- Autocompletion should appear

### 5. Test Find References (gr)
- Place cursor on a function name
- Press `gr`
- Should show all places where it's used

---

## Common Custom Project Patterns

### Pattern 1: Single Entry Point

```
mysite/
├── .intelephense
├── index.php              # All requests go here
├── app/
│   ├── routes.php
│   ├── controllers/
│   └── models/
```

**index.php:**
```php
<?php
// Define project root
define('ROOT_PATH', __DIR__);

// Autoloader
spl_autoload_register(function ($class) {
    $file = ROOT_PATH . '/app/' . str_replace('\\', '/', $class) . '.php';
    if (file_exists($file)) {
        require $file;
    }
});
```

### Pattern 2: Multiple Entry Points

```
mysite/
├── .intelephense
├── public/
│   ├── index.php
│   ├── admin.php
│   └── api.php
├── src/
│   ├── Common.php         # Shared code
│   └── helpers.php
```

Each entry point includes common files.

### Pattern 3: Module Structure

```
myapp/
├── .intelephense
├── modules/
│   ├── users/
│   │   ├── UserController.php
│   │   └── User.php
│   ├── posts/
│   │   ├── PostController.php
│   │   └── Post.php
│   └── common/
│       └── Database.php
```

---

## Using Composer in Custom Projects

Even if you don't use external packages, Composer is useful for autoloading:

### Minimal composer.json

```json
{
  "name": "myname/myproject",
  "description": "My custom PHP application",
  "autoload": {
    "psr-4": {
      "App\\": "src/"
    },
    "files": [
      "src/helpers.php"
    ]
  },
  "require": {
    "php": ">=7.4"
  }
}
```

### Install and Generate Autoloader

```bash
composer install
```

### Use in Your Code

```php
<?php
// public/index.php
require_once __DIR__ . '/../vendor/autoload.php';

// Now you can use namespaced classes
use App\Models\User;

$user = new User();
```

**Benefits:**
- Automatic class loading (no manual require/include)
- PSR-4 compliance
- Better IDE support
- Easier to scale

---

## Quick Reference Commands

```vim
" Setup project
:PhpProjectSetup           " Create marker and restart LSP

" Check status
:LspStatus                 " Quick status check
:LspInfo                   " Detailed LSP information
:checkhealth lsp           " Full health check

" Control LSP
:LspStart intelephense     " Manually start
:LspStop                   " Stop LSP
:LspRestart                " Restart all LSP clients

" Navigate code
gd                         " Go to definition
gD                         " Go to declaration
gr                         " Find references
gi                         " Go to implementation
K                          " Hover documentation
<leader>rn                 " Rename symbol
<leader>ca                 " Code actions

" Diagnostics
[d                         " Previous diagnostic
]d                         " Next diagnostic
<leader>e                  " Show diagnostic float
```

---

## Still Not Working?

### Enable Debug Mode

```vim
:LspDebug
```

Then try using `gd` and check:
```vim
:messages
```

### Check Logs

```bash
tail -f ~/.local/state/nvim/lsp.log
```

### Manual Test

```vim
:lua vim.lsp.buf.definition()
```

If this gives an error, check:
```vim
:lua print(vim.inspect(vim.lsp.get_active_clients()))
```

### Complete Reset

```bash
# Stop Neovim
:qa!

# Clear LSP data
rm -rf ~/.local/share/nvim/lsp
rm -rf ~/.cache/nvim/lsp

# Restart and reinstall
nvim
:MasonInstall intelephense
```

---

## Example: Converting Existing Project

Let's say you have this structure:

```
/var/www/oldproject/
├── index.php
├── admin.php
├── functions.php
├── User.php
├── Post.php
└── config.php
```

### Step 1: Add Project Marker

```bash
cd /var/www/oldproject
touch .intelephense
```

### Step 2: Organize (Optional)

```bash
mkdir -p src/Models src/Controllers includes
mv User.php Post.php src/Models/
mv functions.php includes/
mv config.php includes/
```

### Step 3: Update Includes

**Old index.php:**
```php
<?php
require 'functions.php';
require 'User.php';
```

**New index.php:**
```php
<?php
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/src/Models/User.php';
```

### Step 4: Test

```bash
nvim /var/www/oldproject/index.php
```

```vim
:LspStatus
" Place cursor on User and press gd
```

---

## Getting Help

If you're still having issues:

1. Check the main LSP troubleshooting guide: `LSP_TROUBLESHOOTING.md`
2. Run health check: `:checkhealth lsp`
3. Check Intelephense specifically: `:checkhealth lsp`
4. Enable debug mode: `:LspDebug`
5. Check messages: `:messages`

---

**Remember:** The key to making LSP work in custom projects is ensuring Intelephense can find your project root. Create a marker file (`.intelephense`, `composer.json`, or `.git`) and restart Neovim!

Happy coding! 🚀
