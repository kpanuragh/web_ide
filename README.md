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
- PHP (Laravel with dedicated plugin)
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
├── init.lua                  # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua       # Neovim options
│   │   ├── keymaps.lua       # General keybindings
│   │   └── lazy.lua          # Plugin manager setup
│   └── plugins/
│       ├── completion.lua    # nvim-cmp configuration
│       ├── copilot.lua       # GitHub Copilot
│       ├── dap.lua           # Debug Adapter Protocol
│       ├── extras.lua        # Utility plugins
│       ├── formatting.lua    # Code formatting
│       ├── frameworks.lua    # Framework-specific plugins
│       ├── lsp.lua           # LSP configuration
│       ├── neo-tree.lua      # File explorer
│       ├── project.lua       # Project & session management
│       ├── telescope.lua     # Fuzzy finder
│       ├── treesitter.lua    # Syntax highlighting
│       └── ui.lua            # UI plugins (theme, statusline, etc.)
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

### GitHub Copilot

| Key | Action |
|-----|--------|
| `<M-l>` | Accept suggestion |
| `<M-]>` | Next suggestion |
| `<leader>cc` | Toggle Copilot Chat |

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

## 🤖 GitHub Copilot Setup

1. Install Copilot:
   ```vim
   :Copilot setup
   ```

2. Authenticate with GitHub (follow prompts)

3. Start coding - suggestions appear automatically!

## 🎨 Customization

### Change Theme

Edit `lua/plugins/ui.lua`:
```lua
require("tokyonight").setup({
  style = "night",  -- "storm", "moon", "day"
})
```

### Add Custom Keybindings

Edit `lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>xx", ":YourCommand<CR>", opts)
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

**LSP not working:**
```vim
:LspInfo           " Check LSP status
:Mason             " Install missing servers
```

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
- ✅ Fixed keymap conflicts
- ✅ Modern API usage (vim.uv)
- ✅ Optimized lazy loading (-30% startup time)
- ✅ Conditional plugin loading
- ✅ Error handling for LSP setup
- ✅ Buffer-local autocmds (no memory leaks)
- ✅ Updated to latest plugin versions

## 📝 Useful Commands

```vim
" Plugin Management
:Lazy
:Mason

" LSP
:LspInfo
:LspRestart

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
