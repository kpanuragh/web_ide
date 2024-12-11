vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
-- enable clipboard
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.o.foldenable = true        -- Enable folding
vim.o.foldlevel = 99            -- Set fold level to 0 to start with all folds closed
vim.o.foldmethod = 'expr'      -- Set fold method (e.g., 'expr', 'indent', 'marker')
vim.o.foldexpr = 'nvim_treesitter#foldexpr()' -- Example: Use Tree-sitter for folds

