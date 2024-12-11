return {
	-- Comment.nvim: Easy commenting
	{
		"numToStr/Comment.nvim",
		opts = {}, -- Add specific options if needed
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},
	-- Laravel.nvim: Pure Lua Laravel integration
	{
		"adalessa/laravel.nvim",
		dependencies = {
			"tpope/vim-dotenv",
			"nvim-telescope/telescope.nvim",
			"MunifTanjim/nui.nvim",
			"kevinhwang91/promise-async",
		},
		cmd = { "Laravel" },
		keys = {
			{ "<leader>la", ":Laravel artisan<cr>" },
			{ "<leader>lr", ":Laravel routes<cr>" },
			{ "<leader>lm", ":Laravel related<cr>" },
		},
		event = { "VeryLazy" },
		opts = {},
		config = true,
	},
	-- Blade.nvim: Syntax highlighting and snippets for Blade templates
	{
		"jwalton512/vim-blade",
		ft = "blade",
		config = function()
			vim.g.blade_custom_directives = { "livewire", "slot" } -- Add custom directives if needed
		end,
	},

	-- Conform.nvim: Formatter integration
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					php = { "php-cs-fixer" },
					rust = { "rustfmt" },
				},
			})

			-- Keymap for formatting
			vim.keymap.set({ "n", "v" }, "<leader>cf", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { noremap = true, silent = true, desc = "Format code" })
		end,
	},

	-- Mason: Package manager
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason-LSPConfig: Automates LSP setup
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", -- Lua
					"rust_analyzer", -- Rust
					"pyright", -- Python
					"intelephense", -- PHP
					"html", -- HTML
					"ts_ls", -- JavaScript/TypeScript
					"cssls", -- CSS
					"jsonls", -- JSON
				},
				automatic_installation = true,
			})
		end,
	},

	-- LSPConfig: Configure LSP servers
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim","hrsh7th/cmp-nvim-lsp"},
		config = function()
			local lspconfig = require("lspconfig")

			local on_attach = function(_, bufnr)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
				end

				-- Keybindings
				map("n", "gd", vim.lsp.buf.definition, "Go to definition")
				map("n", "gr", vim.lsp.buf.references, "Find references")
				map("n", "K", vim.lsp.buf.hover, "Hover")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
			end
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- Lua
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
				on_attach = on_attach,
				capabilities = capabilities
			})

			-- Other language servers
			lspconfig.rust_analyzer.setup({ on_attach = on_attach,capabilities = capabilities })
			lspconfig.pyright.setup({ on_attach = on_attach,capabilities = capabilities })
			lspconfig.intelephense.setup({
				settings = {
					intelephense = {
						stubs = {
							"apache",
							"bcmath",
							"bz2",
							"calendar",
							"Core",
							"curl",
							"date",
							"dom",
							"fileinfo",
							"filter",
							"ftp",
							"gd",
							"gettext",
							"hash",
							"iconv",
							"json",
							"libxml",
							"mbstring",
							"mcrypt",
							"mysql",
							"mysqli",
							"openssl",
							"pcntl",
							"pcre",
							"PDO",
							"pdo_mysql",
							"pdo_sqlite",
							"pgsql",
							"Phar",
							"posix",
							"readline",
							"Reflection",
							"regex",
							"session",
							"SimpleXML",
							"soap",
							"sockets",
							"SPL",
							"sqlite3",
							"standard",
							"tokenizer",
							"xml",
							"xmlreader",
							"xmlrpc",
							"xmlwriter",
							"Zend OPcache",
							"zip",
							"zlib",
							"Laravel",
							"Lumen",
						},
						files = {
							maxSize = 5000000,
						},
					},
				},
				on_attach = on_attach,
				capabilities = capabilities
			})
			lspconfig.html.setup({ on_attach = on_attach,capabilities = capabilities })
			lspconfig.ts_ls.setup({ on_attach = on_attach,capabilities = capabilities })
			lspconfig.jsonls.setup({ on_attach = on_attach,capabilities = capabilities })
			lspconfig.cssls.setup({
				settings = {
					css = {
						lint = { unknownAtRules = "ignore" },
					},
				},
				on_attach = on_attach,
				capabilities = capabilities
			})
		end,
	},
	-- Snippets for Laravel
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { "./snippets" },
			})
		end,
	},
	-- Copilot: AI code suggestions
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- Auto-completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "zbirenbaum/copilot-cmp" },
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
				    -- Copilot Source
    { name = "copilot", group_index = 2 },
    -- Other Sources
    { name = "nvim_lsp", group_index = 2 },
    { name = "path", group_index = 2 },
    { name = "luasnip", group_index = 2 },
				}),
			})
		end,
	},

	-- Treesitter: Syntax highlighting and indentation
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				highlight = { enable = true },
				indent = { enable = true },
				ignore_install = { 'hoon' }
			})
		end,
	},

	-- null-ls.nvim: Integrate external linters and formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.diagnostics.flake8,
					null_ls.builtins.diagnostics.phpstan,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},

	-- folke/trouble.nvim: Better diagnostic UI
	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("trouble").setup({ icons = true })
			vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { noremap = true, silent = true })
			local signs = { Error = "", Warn = "", Hint = "", Info = "" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				severity_sort = true,
			})
		end,
	},
}
