# Neovim Full-Stack Web Development IDE

A comprehensive Neovim configuration tailored for full-stack web development with support for Laravel, Django, Go, Rust, and modern frontend frameworks (Angular, Vue, React).

## Features

### 🚀 Core Features
- **Plugin Manager**: lazy.nvim for fast startup
- **LSP Support**: Full Language Server Protocol support for all major web languages
- **AI Integration**: GitHub Copilot and Copilot Chat
- **Debugging**: DAP (Debug Adapter Protocol) with VSCode launch.json support
- **Auto-completion**: nvim-cmp with multiple sources
- **Syntax Highlighting**: Treesitter for accurate highlighting
- **Fuzzy Finding**: Telescope for files, text, and more
- **File Explorer**: Neo-tree with git integration
- **Project Management**: Multi-project support with auto-detection
- **Session Management**: Auto-save and restore sessions per project/branch

### 💻 Language Support

#### Frontend
- TypeScript/JavaScript (Node.js, Deno)
- HTML/CSS/SCSS
- Vue.js
- Angular
- React
- Tailwind CSS
- Emmet

#### Backend
- PHP (Laravel with Intelephense)
- Python (Django with Pyright)
- Go (with gopls)
- Rust (with rust-analyzer)

#### Config/Data
- JSON/YAML/TOML
- SQL
- Docker/Docker Compose
- Lua (for Neovim config)

### 🎨 UI Features
- Tokyo Night color scheme
- Beautiful statusline (lualine)
- Buffer tabs (bufferline)
- Indent guides
- Git signs in gutter
- Diagnostics list (Trouble)
- Which-key for keybinding hints
- Dashboard on startup

### 🛠️ Developer Tools
- **Formatters**: Prettier, Stylua, Black, gofmt, rustfmt, etc.
- **EditorConfig**: Respect project-specific editor settings
- **REST Client**: Test APIs directly in Neovim
- **Database UI**: Connect to databases and run queries
- **Package.json Info**: Show npm package versions inline
- **Git Integration**: Gitsigns, fugitive-like features
- **Terminal**: Integrated terminal (ToggleTerm)
- **Markdown Preview**: Live preview for documentation

## Installation

### Prerequisites

1. **Neovim >= 0.9.0**
   ```bash
   # Check version
   nvim --version
   ```

2. **Node.js >= 18.x** (for Copilot and some LSP servers)
   ```bash
   node --version
   ```

3. **Git**
   ```bash
   git --version
   ```

4. **Required tools** (install via your package manager):
   ```bash
   # Ubuntu/Debian
   sudo apt install ripgrep fd-find build-essential

   # macOS
   brew install ripgrep fd

   # Arch Linux
   sudo pacman -S ripgrep fd base-devel
   ```

5. **Optional: Language-specific formatters** (for full formatting support):
   ```bash
   # Go (for gofmt)
   # Install from https://golang.org/dl/

   # Rust (for rustfmt)
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

   # PHP CS Fixer (for Laravel)
   composer global require friendsofphp/php-cs-fixer
   export PATH="$PATH:$HOME/.composer/vendor/bin"
   ```

   **Note:** Most formatters (Prettier, Stylua, etc.) are auto-installed via Mason.
   Only `gofmt`, `rustfmt`, and `php-cs-fixer` need system installation.
   See `FORMATTERS.md` for details.

### Quick Start

1. **Backup existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **The configuration is already in place!**

3. **Launch Neovim**:
   ```bash
   nvim
   ```

4. **Wait for plugins to install** (lazy.nvim will automatically install everything)

5. **Run health checks**:
   ```vim
   :checkhealth
   ```

6. **Install language servers**:
   ```vim
   :Mason
   ```
   Then press `i` to install any missing servers.

## Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── config/
│   │   ├── options.lua      # Vim options
│   │   ├── keymaps.lua      # Key mappings
│   │   └── lazy.lua         # Plugin manager setup
│   └── plugins/
│       ├── lsp.lua          # LSP configuration
│       ├── completion.lua   # Autocompletion
│       ├── copilot.lua      # GitHub Copilot
│       ├── dap.lua          # Debugger
│       ├── treesitter.lua   # Syntax highlighting
│       ├── telescope.lua    # Fuzzy finder
│       ├── neo-tree.lua     # File explorer
│       ├── formatting.lua   # Code formatters
│       ├── ui.lua           # UI components
│       ├── project.lua      # Project/session management
│       ├── extras.lua       # EditorConfig, autopairs, etc.
│       └── frameworks.lua   # Framework-specific plugins
└── README.md               # This file
```

## Key Mappings

Leader key: `<Space>`

### General
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate windows |
| `<C-s>` | Save file |
| `<leader>q` | Quit |
| `jk` or `jj` | Exit insert mode |

### File Explorer (Neo-tree)
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>o` | Focus file explorer |

### Fuzzy Finder (Telescope)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>fb` | Browse buffers |
| `<leader>fr` | Recent files |
| `<leader>fh` | Help tags |
| `<leader>fp` | Find projects |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Show references |
| `gi` | Go to implementation |
| `K` | Show hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format file |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Debugger (DAP)
| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dr` | Toggle REPL |
| `<leader>du` | Toggle UI |

### Copilot
| Key | Action |
|-----|--------|
| `<M-l>` | Accept suggestion |
| `<M-]>` | Next suggestion |
| `<M-[>` | Previous suggestion |
| `<C-]>` | Dismiss suggestion |
| `<leader>cc` | Copilot chat toggle |
| `<leader>ce` | Copilot explain |
| `<leader>cf` | Copilot fix |

### Buffer Management
| Key | Action |
|-----|--------|
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<leader>bd` | Close buffer |
| `<leader>bo` | Close other buffers |

### Git
| Key | Action |
|-----|--------|
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `]c` | Next hunk |
| `[c` | Previous hunk |

### Session Management
| Key | Action |
|-----|--------|
| `<leader>ws` | Save session |
| `<leader>wr` | Restore session |
| `<leader>wd` | Delete session |
| `<leader>wf` | Find session |

### Terminal
| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal |
| `<leader>tf` | Floating terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |

## Framework-Specific Features

### Laravel
- Artisan command integration: `<leader>la`
- Routes viewer: `<leader>lr`
- Related files: `<leader>lm`
- Intelephense LSP with Laravel stubs

### Django
- Pyright LSP configured for Django
- Python debugging with DAP

### Vue/Angular
- Dedicated LSP servers (Volar, Angular LS)
- Emmet support in template files
- Auto-close tags

### Database Work
- Database UI: `<leader>db`
- SQL LSP and formatting
- Auto-completion for database connections

## Using with Existing Projects

### EditorConfig
The configuration automatically respects `.editorconfig` files in your project root.

### Prettier/Formatters
Formatters will automatically detect project configuration:
- `.prettierrc`, `.prettierrc.json`, etc.
- `package.json` with prettier config
- `pyproject.toml` for Python
- `.php-cs-fixer` for PHP

### VSCode launch.json
Place your debug configurations in `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "pwa-node",
      "request": "launch",
      "name": "Launch Program",
      "skipFiles": ["<node_internals>/**"],
      "program": "${workspaceFolder}/index.js"
    }
  ]
}
```

The debugger will automatically load these configurations!

## GitHub Copilot Setup

1. **Install Copilot** (first time only):
   ```vim
   :Copilot setup
   ```

2. **Authenticate** with your GitHub account

3. **Start coding** - suggestions will appear automatically!

## Customization

### Change Theme
Edit `lua/plugins/ui.lua` and change the colorscheme:
```lua
vim.cmd([[colorscheme tokyonight]]) -- or gruvbox, catppuccin, etc.
```

### Add New LSP Server
Edit `lua/plugins/lsp.lua` and add to the servers list:
```lua
local servers = {
  "tsserver",
  "your_new_server", -- Add here
}
```

### Disable Auto-format on Save
```vim
:FormatDisable  " For current buffer
:FormatDisable! " Globally
```

### Add Custom Keymaps
Edit `lua/config/keymaps.lua`:
```lua
keymap.set("n", "<leader>custom", ":YourCommand<CR>", opts)
```

## Troubleshooting

### LSP Not Working
1. Check if server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Restart LSP: `:LspRestart`

### Copilot Not Suggesting
1. Check status: `:Copilot status`
2. Restart: `:Copilot restart`
3. Check Node.js version: `node --version` (needs >= 18)

### Formatters Not Working
1. Check if formatter is installed: `:Mason`
2. Check formatter config: `:ConformInfo`
3. Manual format: `<leader>f`

### Slow Startup
1. Check startup time: `nvim --startuptime startup.log`
2. Disable unused plugins in their respective files

## Updating

### Update All Plugins
```vim
:Lazy update
```

### Update LSP Servers
```vim
:Mason
```
Then press `U` to update all.

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [LSP Config](https://github.com/neovim/nvim-lspconfig)
- [Copilot.lua](https://github.com/zbirenbaum/copilot.lua)

## License

MIT License - Feel free to use and modify!

---

**Happy Coding! 🚀**
