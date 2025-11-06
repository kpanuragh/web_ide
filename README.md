# Neovim Full-Stack Web Development IDE

A comprehensive, modern Neovim configuration optimized for full-stack web development with support for Vue, Angular, React, Laravel, Django, Go, Rust, and more.

![Neovim Version](https://img.shields.io/badge/Neovim-0.10%2B-green)
![License](https://img.shields.io/badge/license-MIT-blue)

## ✨ Features

### 🚀 Core Features
- **Modern Plugin Manager**: lazy.nvim with optimized lazy loading
- **LSP Support**: 20+ language servers pre-configured
- **Smart Completion**: nvim-cmp with snippets, LSP, buffer, and path sources
- **Debugging**: Full DAP support for JavaScript, TypeScript, Python, Go, PHP, and Rust
- **Code Intelligence**: Treesitter for syntax highlighting and code navigation
- **Fuzzy Finding**: Telescope for files, grep, buffers, and more
- **Git Integration**: Gitsigns, git commands, and conflict resolution
- **AI Assistant**: GitHub Copilot integration with chat support

### 💻 Supported Languages & Frameworks

**Frontend:**
- JavaScript/TypeScript
- React, Vue 3, Angular, Svelte
- HTML, CSS, SCSS, Tailwind CSS

**Backend:**
- **PHP** - Full support for Laravel, Symfony, CodeIgniter, WordPress, and custom frameworks
  - Intelephense LSP for intelligent completion
  - PHPActor for advanced refactoring
  - Composer integration
  - Namespace management
  - Class import helpers
- Python (Django support)
- Go
- Rust
- Node.js

**Databases:**
- PostgreSQL, MySQL, SQLite
- Built-in database UI (dadbod)

**DevOps:**
- Docker & Docker Compose
- YAML, TOML, JSON

## 📦 Installation

### Quick Install (Ubuntu/Debian)

```bash
# Clone this repository
git clone <repository-url> ~/.config/nvim

# Run the installation script
cd ~/.config/nvim
./install-ubuntu.sh
```

The script will install:
- Latest Neovim (0.10+)
- Node.js 20 LTS
- Python 3 with pip
- Go, Rust, PHP
- CLI tools (ripgrep, fd, bat)
- Language servers and formatters
- Nerd Fonts for icons
- All Neovim plugins

### Manual Installation

See [INSTALLATION.md](INSTALLATION.md) for detailed manual installation instructions.

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                      # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua           # Neovim options
│   │   ├── keymaps.lua           # General keybindings
│   │   ├── filetype.lua          # Filetype detection (PHP support)
│   │   └── lazy.lua              # Plugin manager setup
│   └── plugins/
│       ├── completion.lua        # nvim-cmp configuration
│       ├── copilot.lua           # GitHub Copilot
│       ├── dap.lua               # Debug Adapter Protocol
│       ├── extras.lua            # Utility plugins
│       ├── formatting.lua        # Code formatting
│       ├── frameworks.lua        # Framework-specific plugins
│       ├── lsp.lua               # LSP configuration
│       ├── neo-tree.lua          # File explorer
│       ├── project.lua           # Project & session management
│       ├── telescope.lua         # Fuzzy finder
│       ├── treesitter.lua        # Syntax highlighting
│       ├── ui.lua                # Themes, statusline, bufferline, dashboard
│       └── ui-enhancements.lua   # Modern UI features & animations
```

## ⌨️ Keybindings

### Leader Key
The leader key is `<Space>`

### Essential Shortcuts

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Browse buffers |
| `<C-s>` | Save file |
| `<leader>q` | Quit |

### LSP (Language Server)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Show hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format buffer |
| `[d` / `]d` | Previous/Next diagnostic |

### Debugging

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue/Start debugging |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>du` | Toggle DAP UI |

### Git

| Key | Action |
|-----|--------|
| `<leader>hs` | Stage hunk |
| `<leader>hp` | Preview hunk |
| `[c` / `]c` | Previous/Next hunk |
| `<leader>gc` | Git commits |
| `<leader>gb` | Git branches |

### PHP Development

| Key | Action |
|-----|--------|
| `<leader>pc` | Run Composer commands |
| `<leader>pa` | Run Artisan commands (Laravel) |
| `<leader>pr` | View routes (Laravel/framework) |
| `<leader>pm` | Navigate to related files (Model/Controller/View) |
| `<leader>pn` | Insert use statement for class under cursor |
| `<leader>pe` | Expand class name (FQCN) |
| `<leader>ps` | Sort use statements alphabetically |
| `<leader>pi` | Import class (PHPActor) |
| `<leader>pf` | Find references (PHPActor) |
| `<leader>pt` | Transform/Refactor code (PHPActor) |
| `<leader>pg` | Generate getter/setter methods |

### GitHub Copilot

| Key | Action |
|-----|--------|
| `<M-l>` | Accept suggestion |
| `<M-]>` | Next suggestion |
| `<leader>cc` | Toggle Copilot Chat |

### UI & Visual Features

| Key | Action |
|-----|--------|
| `<leader>mo` | Open minimap |
| `<leader>mc` | Close minimap |
| `<leader>mt` | Toggle minimap |
| `<leader>un` | Dismiss all notifications |
| `]]` | Next reference (illuminate) |
| `[[` | Previous reference (illuminate) |

For complete keybinding reference, see [KEYBINDINGS.md](KEYBINDINGS.md)

## 🔧 Plugin Management

```vim
:Lazy sync     " Sync plugins (install/update)
:Lazy update   " Update plugins only
:Lazy clean    " Remove unused plugins
:Lazy profile  " Show plugin load times
```

## 🛠️ Language Server Setup

### View Installed Servers
```vim
:Mason         " Open Mason UI
:LspInfo       " Show LSP status
```

### Install Additional Servers
```vim
:MasonInstall <server-name>
```

Pre-installed servers include:
- ts_ls (TypeScript/JavaScript)
- intelephense (PHP)
- pyright (Python)
- gopls (Go)
- rust_analyzer (Rust)
- And 15+ more...

## 🐛 Debugging Setup

DAP is pre-configured for:
- JavaScript/TypeScript (Node.js)
- Python
- Go
- PHP (Xdebug)
- Rust

Just set breakpoints and press `<leader>dc` to start debugging!

## 🐘 PHP Development Features

This configuration is optimized for **all PHP projects**, not just Laravel! Whether you're working with Laravel, Symfony, CodeIgniter, WordPress, or a custom framework, you get:

### Intelligent Code Completion
- **Intelephense LSP** provides intelligent autocompletion, go-to-definition, and documentation
- Works across all PHP frameworks and custom codebases
- Understands PSR standards and modern PHP features

### Advanced Refactoring with PHPActor
- **Import classes automatically** - `<leader>pi`
- **Generate getters/setters** - `<leader>pg`
- **Transform and refactor code** - `<leader>pt`
- **Find all references** - `<leader>pf`

### Namespace Management
- **Auto-insert use statements** - `<leader>pn` when cursor is on a class name
- **Expand to fully qualified class name** - `<leader>pe`
- **Sort use statements** - `<leader>ps`

### Framework Support
- **Laravel**: Artisan commands, route viewing, related file navigation
- **Composer**: Integrated Composer command execution - `<leader>pc`
- **All frameworks**: Works with any PSR-compliant codebase

### PHP Debugging (Xdebug)
1. Install Xdebug in your PHP environment
2. Configure Xdebug to connect on port 9003:
   ```ini
   ; In php.ini or xdebug.ini
   xdebug.mode=debug
   xdebug.start_with_request=yes
   xdebug.client_port=9003
   ```
3. Set breakpoints in Neovim and start debugging with `<leader>dc`

### API Documentation
Quick access to PHP documentation with DevDocs:
- PHP core documentation
- Laravel, Symfony, CodeIgniter
- WordPress, PHPUnit
- Press `<leader>do` to search documentation

### Syntax Highlighting
The configuration includes robust PHP syntax highlighting for:
- Standard `.php` files
- Mixed HTML/PHP files
- Custom extensions (`.inc`, `.phtml`, `.phps`, etc.)
- Template files in custom frameworks

**Troubleshooting**: If syntax highlighting doesn't work, see [PHP_TROUBLESHOOTING.md](PHP_TROUBLESHOOTING.md) for solutions.

## 🤖 GitHub Copilot Setup

1. Install Copilot:
   ```vim
   :Copilot setup
   ```

2. Authenticate with GitHub (follow prompts)

3. Start coding - suggestions appear automatically!

## 🎨 Beautiful Modern UI

This configuration includes a stunning, modern IDE interface with smooth animations and visual enhancements!

### Available Themes

Choose from 4 beautiful, professionally-designed colorschemes:

1. **Tokyo Night** (Default) - Modern, vibrant dark theme
   - Variants: `night`, `storm`, `moon`, `day`
   - Active by default with custom highlights

2. **Catppuccin** - Elegant pastel theme
   - Flavors: `latte`, `frappe`, `macchiato`, `mocha`
   - Beautiful color palette with full integration

3. **Rose Pine** - Minimal and sophisticated
   - Variants: `main`, `moon`, `dawn`
   - Clean and distraction-free

4. **Kanagawa** - Deep and warm colors
   - Themes: `wave`, `dragon`, `lotus`
   - Inspired by Japanese art

### Switching Themes

To switch themes, edit `lua/plugins/ui.lua` and change:

```lua
-- Change Tokyo Night to lazy load
{
  "folke/tokyonight.nvim",
  lazy = true,  -- Change from false to true
  -- ...
}

-- Make your preferred theme load immediately
{
  "catppuccin/nvim",
  lazy = false,  -- Change from true to false
  priority = 1000,
  config = function()
    require("catppuccin").setup()
    vim.cmd([[colorscheme catppuccin]])
  end,
}
```

Or switch temporarily:
```vim
:colorscheme catppuccin
:colorscheme rose-pine
:colorscheme kanagawa
:colorscheme tokyonight
```

### UI Enhancements Included

#### Smooth Scrolling
Beautiful smooth scrolling animations with `neoscroll.nvim`:
- `<C-u>`, `<C-d>` - Smooth half-page scroll
- `<C-f>`, `<C-b>` - Smooth full-page scroll
- `zt`, `zz`, `zb` - Smooth cursor positioning

#### Visual Enhancements
- **Rainbow Delimiters** - Colorful bracket matching
- **Indent Guides** - Clear indentation with scope highlighting
- **Todo Comments** - Highlights TODO, FIXME, NOTE, HACK, WARN, PERF
- **Color Preview** - Inline color visualization for CSS/hex codes
- **Word Highlighting** - Highlights word under cursor (`]]` / `[[` to navigate)
- **Dim Inactive Windows** - Focus on active window
- **Better Folding** - Smart code folding with treesitter

#### Minimap
Toggle code minimap with:
- `<leader>mo` - Open minimap
- `<leader>mc` - Close minimap
- `<leader>mt` - Toggle minimap

#### Modern UI Components
- **Noice.nvim** - Beautiful cmdline, messages, and notifications
- **Dressing.nvim** - Enhanced vim.ui.select and vim.ui.input
- **Window Picker** - Easy window navigation in multi-window layouts

### Beautiful Dashboard

The startup screen features:
- Modern ASCII art logo
- Quick action buttons (Find files, Recent files, Projects, etc.)
- Dynamic footer showing:
  - Current date and time
  - Total plugins installed
  - Neovim version
  - Startup time in milliseconds

### Statusline & Bufferline

**Lualine** statusline shows:
- Current mode
- Git branch, diff, and diagnostics
- File path
- Active LSP clients
- File encoding and type
- Cursor position

**Bufferline** features:
- Tab-like buffer display
- LSP diagnostics per buffer
- Pin/unpin buffers: `<leader>bp`
- Close other buffers: `<leader>bo`
- Navigate buffers: `[b` / `]b`

## 🎨 Customization

### Customize Theme Colors

Edit `lua/plugins/ui.lua` to customize your active theme:

**Tokyo Night:**
```lua
require("tokyonight").setup({
  style = "night",  -- "storm", "moon", "day"
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { bold = true },
  },
})
```

**Catppuccin:**
```lua
require("catppuccin").setup({
  flavour = "mocha",  -- latte, frappe, macchiato, mocha
  transparent_background = false,
  dim_inactive = { enabled = true },
})
```

### Customize Dashboard

Edit the ASCII art, buttons, or footer in `lua/plugins/ui.lua`:

```lua
-- Change the header art
dashboard.section.header.val = {
  "Your custom ASCII art here",
}

-- Add custom buttons
dashboard.section.buttons.val = {
  dashboard.button("x", "  Your Action", ":YourCommand<CR>"),
}
```

### Add Custom Keybindings

Edit `lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>xx", ":YourCommand<CR>", { desc = "Your action" })
```

### Project-Specific Settings

Create `.nvim.lua` in your project root:
```lua
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
```

## 🐞 Troubleshooting

### Check Health
```vim
:checkhealth       " Check all components
:checkhealth lazy  " Check specific plugin
```

### Common Issues

**LSP commands (gd, gr, K) not working:**
```vim
:LspStatus         " Check if LSP is attached
:LspInfo           " Check LSP status
:LspKeymaps        " Show LSP keymaps
:Mason             " Install missing servers
:LspRestart        " Restart LSP if stuck
```
See [LSP_TROUBLESHOOTING.md](LSP_TROUBLESHOOTING.md) for detailed solutions.

**PHP syntax highlighting not working:**
```vim
:TSInstall php php_only phpdoc
:TSUpdate
:edit              " Reload file
```
See [PHP_TROUBLESHOOTING.md](PHP_TROUBLESHOOTING.md) for detailed solutions.

**Icons not showing:**
- Make sure you're using a Nerd Font in your terminal

**Copilot not working:**
- Ensure Node.js 18+ is installed
- Run `:Copilot status`

**Slow startup:**
```vim
:Lazy profile      " Check plugin load times
```

## ⚡ Performance

Expected startup time: **80-130ms** (optimized with lazy loading)

To profile:
```bash
nvim --startuptime startup.log
```

## 📚 Documentation

- [Full Keybindings Reference](KEYBINDINGS.md)
- [Installation Guide](INSTALLATION.md)
- [Plugin List](PLUGINS.md)
- [Customization Guide](CUSTOMIZATION.md)

## 🔄 Updates

### Update Config
```bash
cd ~/.config/nvim
git pull
nvim  # Plugins will auto-update
```

### Update Plugins Only
```vim
:Lazy sync
```

## 🎯 Improvements (Latest)

This configuration has been optimized with:
- ✅ **Beautiful Modern UI** - Smooth animations, multiple themes, enhanced visual feedback
- ✅ **4 Professional Colorschemes** - Tokyo Night, Catppuccin, Rose Pine, Kanagawa
- ✅ **Enhanced Dashboard** - Dynamic stats, modern ASCII art, quick actions
- ✅ **Visual Enhancements** - Rainbow brackets, smooth scrolling, color preview, minimap
- ✅ **Modern UI Components** - Noice, Dressing, Window Picker, Tint
- ✅ Fixed keymap conflicts
- ✅ Modern API usage (vim.uv)
- ✅ Optimized lazy loading (-30% startup time)
- ✅ Conditional plugin loading
- ✅ Enhanced LSP diagnostics and troubleshooting
- ✅ Auto-attach for PHP files
- ✅ PHP syntax highlighting for all frameworks
- ✅ Comprehensive troubleshooting guides
- ✅ Buffer-local autocmds (no memory leaks)
- ✅ Updated to latest plugin versions

## 📝 Useful Commands

```vim
" Plugin Management
:Lazy
:Mason

" LSP
:LspInfo           " Detailed LSP information
:LspStatus         " Quick LSP status check
:LspRestart        " Restart LSP clients
:LspKeymaps        " Show LSP keybindings
:LspDebug          " Toggle debug mode

" Debugging
:DapContinue
:DapToggleBreakpoint

" Git
:Gitsigns toggle_current_line_blame

" Sessions
:SessionSave
:SessionRestore

" Database
:DBUIToggle

" Formatting
:FormatDisable
:FormatEnable
```

## 🙏 Credits

Built with amazing plugins:
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [copilot.lua](https://github.com/zbirenbaum/copilot.lua)
- And many more!

## 📄 License

MIT License - feel free to use and modify!

## 💬 Support

For issues or questions:
1. Check [Troubleshooting](#-troubleshooting)
2. Run `:checkhealth`
3. Open an issue on GitHub

---

**Happy Coding!** 🚀

*Made with ❤️ for the Neovim community*
