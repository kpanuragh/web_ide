return {
	-- PHP debugging support with Docker integration
	{
		"xdebug/vscode-php-debug",
		ft = "php",
		build = "npm install && npm run compile",
		config = function()
			-- Docker Xdebug configuration with dynamic container detection
			vim.g.php_debug_docker_path_mapping = {
				["/var/www/html"] = vim.fn.getcwd()
			}
			
			-- Function to find PHP container dynamically
			local function find_php_container()
				local handle = io.popen("docker ps --format '{{.Names}}' --filter 'ancestor=php' 2>/dev/null")
				local result = handle:read("*a")
				handle:close()
				
				if result and result:match("%S") then
					return result:gsub("%s+", "")
				end
				
				-- Fallback: look for containers with 'php' in name
				handle = io.popen("docker ps --format '{{.Names}}' | grep -i php | head -1 2>/dev/null")
				result = handle:read("*a")
				handle:close()
				
				return result and result:gsub("%s+", "") or nil
			end
			
			vim.g.find_php_container = find_php_container
		end,
	},

	-- PHP syntax highlighting and indentation
	{
		"StanAngeloff/php.vim",
		ft = "php",
		config = function()
			-- Enhanced PHP syntax highlighting
			vim.g.php_syntax_extensions_enabled = {
				"bcmath", "bz2", "core", "curl", "date", "dom", "ereg", "gd", "gettext", "hash",
				"iconv", "json", "libxml", "mbstring", "mcrypt", "mhash", "mysql", "mysqli",
				"openssl", "pcre", "pdo", "pgsql", "phar", "posix", "session", "simplexml",
				"soap", "sockets", "sqlite3", "standard", "tokenizer", "wddx", "xml", "xmlreader",
				"xmlwriter", "zip", "zlib"
			}
			vim.g.php_syntax_extensions_disabled = {}
			vim.g.php_var_selector_is_identifier = 1
			vim.g.php_html_load = 0
			vim.g.php_html_in_heredoc = 0
			vim.g.php_html_in_nowdoc = 0
			vim.g.php_sql_query = 1
			vim.g.php_sql_heredoc = 1
			vim.g.php_sql_nowdoc = 1
		end,
	},

	-- Laravel Blade support
	{
		"jwalton512/vim-blade",
		ft = { "blade", "php" },
	},

	-- Composer.json support
	{
		"noahfrederick/vim-composer",
		ft = { "json" },
	},

	-- PHP code formatting with Docker support
	{
		"dense-analysis/ale",
		ft = "php",
		config = function()
			-- Configure ALE for PHP with Docker
			vim.g.ale_php_phpcs_standard = "PSR12"
			vim.g.ale_php_php_cs_fixer_options = "--rules=@PSR12"
			vim.g.ale_php_phpstan_level = 6 -- Reduced level for large projects
			vim.g.ale_php_psalm_options = "--show-info=false"
			
			-- Docker integration for PHP tools with dynamic container detection
			local function get_php_container()
				local handle = io.popen("docker ps --format '{{.Names}}' --filter 'ancestor=php' 2>/dev/null")
				local result = handle:read("*a")
				handle:close()
				
				if result and result:match("%S") then
					return result:gsub("%s+", "")
				end
				
				-- Fallback: look for containers with 'php' in name
				handle = io.popen("docker ps --format '{{.Names}}' | grep -i php | head -1 2>/dev/null")
				result = handle:read("*a")
				handle:close()
				
				return result and result:gsub("%s+", "") or "php"
			end
			
			local php_container = get_php_container()
			
			vim.g.ale_php_phpcs_executable = "docker"
			vim.g.ale_php_phpcs_options = "exec " .. php_container .. " phpcs"
			vim.g.ale_php_php_cs_fixer_executable = "docker"
			vim.g.ale_php_php_cs_fixer_options = "exec " .. php_container .. " php-cs-fixer"
			
			-- Performance optimizations for large projects
			vim.g.ale_lint_on_text_changed = "never"
			vim.g.ale_lint_on_insert_leave = 0
			vim.g.ale_lint_on_save = 1
			vim.g.ale_lint_on_enter = 0
			vim.g.ale_lint_on_filetype_changed = 0
			
			-- Enable specific PHP linters and fixers
			vim.g.ale_linters = vim.tbl_extend("force", vim.g.ale_linters or {}, {
				php = { "php", "phpstan" } -- Reduced linters for performance
			})
			vim.g.ale_fixers = vim.tbl_extend("force", vim.g.ale_fixers or {}, {
				php = { "php_cs_fixer" }
			})
		end,
	},

	-- Large project file management
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			-- Optimized PHP file search
			{"<leader>fP", function()
				require("telescope.builtin").find_files({
					find_command = {
						"fd", "--type", "f", "--extension", "php",
						"--exclude", "vendor",
						"--exclude", "storage",
						"--exclude", "bootstrap/cache",
						"--exclude", "node_modules",
						"--exclude", "docker",
						"--exclude", ".docker"
					}
				})
			end, desc = "Find PHP files (fast)"},
			
			-- Search in PHP files only
			{"<leader>gP", function()
				require("telescope.builtin").live_grep({
					type_filter = "php",
					glob_pattern = "!{vendor,storage,bootstrap/cache,node_modules,docker}/**"
				})
			end, desc = "Grep in PHP files"},
		}
	},
}
