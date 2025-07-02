return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim" },
		{ "mason-org/mason-lspconfig.nvim" },
		"nvimdev/lspsaga.nvim",
		"jose-elias-alvarez/typescript.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ts_ls",
				"intelephense",
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
			map("n", "gD", "<cmd>Lspsaga goto_type_definition<CR>", "Saga Go to Type Definition")
			map("n", "gi", "<cmd>Lspsaga peek_definition<CR>", "Saga Peek Definition")
			map("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", "Saga Peek Type Definition")
			map("n", "co", "<cmd>Lspsaga incoming_calls<CR>", "Saga OutGoing call")
			map("n", "ci", "<cmd>Lspsaga outgoing_calls<CR>", "Saga InComing call")

			map("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
			map("n", "<C-k>", "<cmd>Lspsaga signature_help<CR>", "Signature Help")

			map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Saga Code Action")
			map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Saga Code Action (Visual)")
			map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", "Saga Rename")

			map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic")
			map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic")
			map("n", "<leader>es", "<cmd>Lspsaga show_line_ diagnostics<CR>", "Line Diagnostics")
			map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", "Document Symbols Outline")
			map({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>", "Toggle Terminal")
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
			intelephense = {},
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
