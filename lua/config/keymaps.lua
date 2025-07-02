local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Buffer switching
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", opts)
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opts)

-- Reordering buffers
map("n", "<leader>bn", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer →" })
map("n", "<leader>bp", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer ←" })

-- Buffer actions
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
map("n", "<leader>bl", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })

map("", "<leader>cf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })
