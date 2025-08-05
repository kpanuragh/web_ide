-- Alternative LSP configuration with only Intelephense (no PhpActor)
-- Use this if PhpActor is still too heavy for your large project

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim" },
		{ "mason-org/mason-lspconfig.nvim" },
		"nvimdev/lspsaga.nvim",
		"jose-elias-alvarez/typescript.nvim",
	},
	config = function()
		-- Install PHP formatters and linters via Mason
		require("mason").setup({
			ensure_installed = {
				-- PHP formatters and linters (not LSP servers)
				"php-cs-fixer",
				"phpstan",
				"psalm",
				"phpcbf",
			},
		})
		
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ts_ls",
				"intelephense", -- Only Intelephense for PHP
				"rust_analyzer",
			},
			automatic_installation = true,
		})
		
		require("lspsaga").setup({
			-- Optimized for performance
			code_action = {
				num_shortcut = true,
				show_server_name = false,
				extend_gitsigns = false,
			},
			lightbulb = {
				enable = false,
				enable_in_insert = false,
			},
			symbol_in_winbar = {
				enable = false,
			},
		})

		local lspconfig = require("lspconfig")

		-- Basic on_attach
		local on_attach = function(client, bufnr)
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
			end

			-- Lspsaga-enhanced LSP actions
			map("n", "gd", "<cmd>Lspsaga goto_definition<CR>", "Saga Go to Definition")
			map("n", "gD", "<cmd>Lspsaga peek_definition<CR>", "Saga Peek Definition")
			map("n", "gr", "<cmd>Lspsaga finder<CR>", "Saga References/Definitions")
			map("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", "Saga Go to Type Definition")
			map("n", "gT", "<cmd>Lspsaga peek_type_definition<CR>", "Saga Peek Type Definition")
			map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation")

			map("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
			map("n", "<C-k>", "<cmd>Lspsaga signature_help<CR>", "Signature Help")

			map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Saga Code Action")
			map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Saga Code Action (Visual)")
			map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", "Saga Rename")

			map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic")
			map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic")
			map("n", "<leader>es", "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics")
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
			-- Only Intelephense for PHP (no PhpActor)
			intelephense = {
				settings = {
					intelephense = {
						files = {
							maxSize = 10000000,
							associations = { "*.php", "*.phtml", "*.inc", "*.module", "*.install", "*.theme" },
							exclude = {
								"**/.git/**", "**/.svn/**", "**/.hg/**", "**/CVS/**", "**/.DS_Store/**",
								"**/node_modules/**", "**/bower_components/**", "**/vendor/**/{Tests,tests}/**",
								"**/.history/**", "**/vendor/**/vendor/**", "**/storage/**", "**/cache/**",
								"**/tmp/**", "**/temp/**", "**/logs/**", "**/log/**", "**/*.log",
								"**/public/storage/**", "**/bootstrap/cache/**", "**/.phpunit.result.cache",
								"**/docker/**", "**/.docker/**", "**/Dockerfile*", "**/docker-compose*",
							},
						},
						stubs = {
							"apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date",
							"dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd",
							"gettext", "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring",
							"meta", "mysqli", "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm",
							"pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", "pspell", "readline",
							"Reflection", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium",
							"SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy",
							"tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip",
							"zlib", "wordpress", "phpunit", "laravel", "symfony", "drupal", "magento", "prestashop",
						},
						environment = {
							includePaths = {},
							phpVersion = "7.4.0",
						},
						diagnostics = {
							enable = true,
							run = "onSave",
							embeddedLanguages = true,
							undefinedTypes = true,
							undefinedFunctions = true,
							undefinedConstants = true,
							undefinedClassConstants = true,
							undefinedMethods = true,
							undefinedProperties = true,
							undefinedVariables = false,
							unusedSymbols = false,
							typeErrors = true,
						},
						format = {
							enable = true,
							braces = "psr12",
						},
						completion = {
							insertUseDeclaration = true,
							fullyQualifyGlobalConstantsAndFunctions = false,
							triggerParameterHints = true,
							maxItems = 30, -- Further reduced for large projects
						},
						phpdoc = {
							returnVoid = true,
							textFormat = "snippet",
						},
						references = {
							exclude = { "**/vendor/**", "**/storage/**", "**/cache/**", "**/logs/**", "**/tmp/**" },
						},
						rename = {
							exclude = { "**/vendor/**", "**/storage/**", "**/cache/**", "**/logs/**", "**/tmp/**" },
						},
						indexing = {
							references = false,
						},
					},
				},
				init_options = {
					licenceKey = vim.fn.expand("$HOME/.config/intelephense/licence.txt"),
					clearCache = false,
					storagePath = vim.fn.stdpath("data") .. "/intelephense",
				},
			},
			gopls = {},
			rust_analyzer = {},
		}

		for name, config in pairs(servers) do
			config.on_attach = on_attach
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			
			-- Enhanced capabilities for Intelephense only
			if name == "intelephense" then
				capabilities.textDocument.completion.completionItem.snippetSupport = true
				capabilities.textDocument.completion.completionItem.resolveSupport = {
					properties = { "documentation", "detail", "additionalTextEdits" }
				}
				capabilities.textDocument.foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true
				}
			end
			
			config.capabilities = capabilities
			lspconfig[name].setup(config)
		end
	end,
}
