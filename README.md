# Neovim Configuration for Web Development

This repository contains a highly optimized Neovim configuration tailored for modern web development. It leverages the **LazyVim** framework for lazy-loaded plugin management and provides a seamless, efficient coding experience.

## Features

- **Lazy-loading Plugins**: Optimized startup using LazyVim.
- **Modern Web Development Support**:
  - Integrated LSP for multiple languages (e.g., JavaScript, TypeScript, HTML, CSS).
  - Autocompletion and snippets.
- **Git Integration**: Features for efficient Git operations.
- **File Navigation**: Enhanced file and project navigation.
- **Theming**: Beautiful and customizable themes.
- **Keybindings**: Pre-configured key mappings for productivity.
- **Modular Structure**: Easy-to-understand and extend Lua-based configuration.

## File Structure

- **`init.lua`**: Entry point of the configuration.
- **`lua/config`**: Core settings and plugin configurations.
  - `lazy.lua`: Plugin loader configuration.
  - `option.lua`: Core editor settings.
- **`lua/plugins`**: Individual plugin configurations.
  - `file.lua`: File management plugins.
  - `keys.lua`: Keybinding settings.
  - `git.lua`: Git-related plugins.
  - `theme.lua`: Theming and UI enhancements.
  - `lsp.lua`: Language Server Protocol configurations.

## Setup Instructions

### Prerequisites

- Neovim version >= 0.8.0
- `git`, `node.js`, and a package manager like `npm` or `yarn` for LSP dependencies.

### Installation

1. **Clone this repository**:
   ```bash
   git clone git@github.com:kpanuragh/web_ide.git ~/.config/nvim
