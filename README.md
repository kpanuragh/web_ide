
# Web IDE - A Neovim Configuration for Modern Web Development

A lightweight, fast, and powerful Neovim configuration that turns your editor into a full-fledged IDE for web development.

## ✨ Features

This configuration is built to be minimal yet powerful, providing all the tools you need for a smooth web development workflow.

-   **Plugin Management with `lazy.nvim`**: Easily manage and load plugins for a faster startup time.
    
-   **Modern UI**: A clean and distraction-free user interface.
    
-   **LSP Support**: Pre-configured Language Server Protocol support for autocompletion, diagnostics, and more.
    
-   **Syntax Highlighting**: Beautiful and accurate syntax highlighting for a variety of web languages.
    
-   **File Management**: An integrated file explorer for easy project navigation.
    
-   **And much more...**
    

## Prerequisites

Before you begin, ensure you have the following installed:

-   [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim "null") (v0.8.0 or higher)
    
-   [Git](https://git-scm.com/downloads "null")
    
-   A Nerd Font (optional, but recommended for icons)
    

## 🚀 Installation

1.  **Clone the repository:**
    
    If you are starting from scratch, you can clone this configuration directly. First, back up your existing Neovim configuration:
    
    ```
    # Back up your current nvim config
    mv ~/.config/nvim ~/.config/nvim.bak
    
    ```
    
    Now, clone the repository:
    
    ```
    git clone https://github.com/kpanuragh/web_ide.git ~/.config/nvim
    
    ```
    
2.  **Launch Neovim:**
    
    Open Neovim. The `lazy.nvim` plugin manager will automatically install all the necessary plugins.
    
    ```
    nvim
    
    ```
    

## 📂 Project Structure

The project is organized as follows:

```
.
├── init.lua      -- Main entry point for the configuration
├── lazy-lock.json-- Lockfile for lazy.nvim plugins
└── lua/
    └── ...         -- All the configuration modules are in here

```

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/kpanuragh/web_ide/issues "null").
