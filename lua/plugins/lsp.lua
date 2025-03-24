return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"nvimdev/lspsaga.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ts_ls",
				"phpactor",
				"gopls",
				"rust_analyzer",
			},
			automatic_installation = true,
		})
		require("lspsaga").setup({})

		local lspconfig = require("lspconfig")

		-- Basic on_attach
		local on_attach = function(client, bufnr)
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
			end

			-- Lspsaga-enhanced LSP actions
			map("n", "gd", "<cmd>Lspsaga goto_definition<CR>", "Saga Go to Definition")
			map("n", "gr", "<cmd>Lspsaga finder<CR>", "Saga References/Definitions")
			map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to Declaration") -- no lspsaga for this
			map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation")
			map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to Type Definition")
			map("n", "co", "<cmd>Lspsaga incoming_calls<CR>", "Saga OutGoing call")
			map("n", "ci", "<cmd>Lspsaga outgoing_calls<CR>", "Saga InComing call")

			map("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
			map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help")

			map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Saga Code Action")
			map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Saga Code Action (Visual)")
			map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", "Saga Rename")

			map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic")
			map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic")
			map("n", "<leader>es", "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics")
			map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", "Document Symbols Outline")
			map({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>", "Toggle Terminal")
            map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", "Symbols Outline")

			-- -- Format buffer (native LSP)
			-- map("n", "<leader>f", function()
			-- 	vim.lsp.buf.format({ async = true })
			-- end, "Format Buffer")

			-- Workspace management (native)
			map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace Folder")
			map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace Folder")
			map("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "List Workspace Folders")
		end

		-- Setup individual servers
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			},
			ts_ls = {},
			pyright = {},
			phpactor = {},
			gopls = {},
			rust_analyzer = {},
		}

		for name, config in pairs(servers) do
			config.on_attach = on_attach
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			config.capabilities = capabilities
			lspconfig[name].setup(config)
		end
	end,
}
