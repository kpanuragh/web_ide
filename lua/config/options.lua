-- ============================================================================
-- Neovim Options
-- ============================================================================

local opt = vim.opt

-- General
opt.mouse = "a"                          -- Enable mouse support
opt.clipboard = "unnamedplus"            -- Use system clipboard
opt.swapfile = false                     -- Don't use swapfile
opt.completeopt = "menu,menuone,noselect" -- Completion options
opt.undofile = true                      -- Enable persistent undo
opt.undolevels = 10000

-- UI
opt.number = true                        -- Show line numbers
opt.relativenumber = true                -- Relative line numbers
opt.cursorline = true                    -- Highlight current line
opt.signcolumn = "yes"                   -- Always show sign column
opt.showmode = false                     -- Don't show mode (statusline handles it)
opt.termguicolors = true                 -- True color support
opt.splitright = true                    -- Vertical split to the right
opt.splitbelow = true                    -- Horizontal split to the bottom
opt.wrap = false                         -- Don't wrap lines
opt.scrolloff = 8                        -- Lines to keep above/below cursor
opt.sidescrolloff = 8                    -- Columns to keep left/right of cursor
opt.pumheight = 10                       -- Popup menu height

-- Search
opt.ignorecase = true                    -- Ignore case in search
opt.smartcase = true                     -- Override ignorecase if search contains uppercase
opt.hlsearch = true                      -- Highlight search results
opt.incsearch = true                     -- Incremental search

-- Indentation
opt.tabstop = 4                          -- Number of spaces tabs count for
opt.shiftwidth = 4                       -- Size of an indent
opt.softtabstop = 4                      -- Number of spaces tabs count for in insert mode
opt.expandtab = true                     -- Use spaces instead of tabs
opt.smartindent = true                   -- Insert indents automatically
opt.autoindent = true

-- Performance
opt.updatetime = 200                     -- Faster completion
opt.timeoutlen = 300                     -- Faster key sequence completion
opt.lazyredraw = false                   -- Don't redraw while executing macros

-- Backup
opt.backup = false
opt.writebackup = false

-- Fold
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false                   -- Don't fold by default

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Spell checking (disabled by default, enable per filetype if needed)
opt.spell = false
opt.spelllang = "en_us"
