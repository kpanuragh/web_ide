-- UI
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true    -- Show relative line numbers
vim.opt.cursorline = true        -- Highlight current line
vim.opt.termguicolors = true     -- True color support
vim.opt.signcolumn = "yes"       -- Keep signcolumn on (for diagnostics)
vim.opt.scrolloff = 8            -- Keep cursor centered vertically
vim.opt.wrap = false             -- Disable line wrap

-- Tabs and Indents
vim.opt.tabstop = 4              -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4           -- Size of indent
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.smartindent = true       -- Auto-indent new lines smartly

-- Search
vim.opt.ignorecase = true        -- Ignore case in search
vim.opt.smartcase = true         -- But be smart: if capital used, match case
vim.opt.incsearch = true         -- Show matches while typing
vim.opt.hlsearch = true          -- Highlight search matches

-- Performance
vim.opt.updatetime = 300         -- Faster completion
vim.opt.timeoutlen = 500         -- Keymap wait time

-- Large project optimizations (without lazyredraw for Noice compatibility)
vim.opt.synmaxcol = 200          -- Don't syntax highlight long lines
vim.opt.ttyfast = true           -- Fast terminal connection
-- Removed regexpengine = 1 as it conflicts with cmp-cmdline plugin

-- Memory management for large files
vim.g.loaded_matchparen = 1      -- Disable matchparen plugin for performance
vim.g.loaded_matchit = 1         -- Disable matchit plugin

-- LSP performance tuning
vim.g.lsp_document_highlight = false  -- Disable document highlighting for performance

-- Additional performance optimizations that don't conflict with plugins
vim.opt.maxmempattern = 2000     -- Increase pattern memory for large files
vim.opt.redrawtime = 10000       -- Increase redraw timeout for large files

-- Files & Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true          -- Persistent undo

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Command line
vim.opt.showmode = false         -- Don't show mode (e.g. -- INSERT --), use statusline
vim.opt.laststatus = 3           -- Global statusline

-- Mouse
vim.opt.mouse = "a"              --

