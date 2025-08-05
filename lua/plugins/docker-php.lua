return {
	-- Docker and PHP version management
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- Add Docker-specific file searches
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			
			-- Custom function to search PHP files excluding heavy directories
			vim.keymap.set("n", "<leader>fp", function()
				builtin.find_files({
					find_command = {
						"rg", "--files", "--type", "php",
						"--glob", "!vendor/**",
						"--glob", "!storage/**",
						"--glob", "!bootstrap/cache/**",
						"--glob", "!node_modules/**",
						"--glob", "!docker/**",
						"--glob", "!.docker/**"
					}
				})
			end, { desc = "Find PHP files (optimized)" })
		end,
	},

	-- Performance optimizations for large projects
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				-- Optimize for large repositories
				max_file_length = 40000, -- Disable for files longer than 40K lines
				update_debounce = 200, -- Increase debounce for better performance
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1
				},
			})
		end,
	},

	-- Docker integration
	{
		"mgierada/lazydocker.nvim",
		dependencies = { "akinsho/toggleterm.nvim" },
		config = function()
			require("lazydocker").setup({})
			
			-- Function to dynamically find PHP container
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
			
			-- Docker-specific keymaps
			vim.keymap.set("n", "<leader>dk", "<cmd>LazyDocker<CR>", { desc = "LazyDocker" })
			
			-- PHP container execution helpers with dynamic detection
			vim.keymap.set("n", "<leader>dpr", function()
				local container = find_php_container()
				if not container then
					vim.notify("No PHP container found", vim.log.levels.WARN)
					return
				end
				
				local current_file = vim.fn.expand("%:p")
				if current_file:match("%.php$") then
					local container_file = current_file:gsub(vim.fn.getcwd(), "/var/www/html")
					vim.cmd("TermExec cmd='docker exec -it " .. container .. " php " .. container_file .. "'")
				end
			end, { desc = "Run PHP file in Docker (Dynamic)" })
			
			vim.keymap.set("n", "<leader>dpc", function()
				local container = find_php_container()
				if container then
					vim.cmd("TermExec cmd='docker exec -it " .. container .. " composer install'")
				else
					vim.notify("No PHP container found", vim.log.levels.WARN)
				end
			end, { desc = "Docker Composer Install (Dynamic)" })
			
			vim.keymap.set("n", "<leader>dpa", function()
				local container = find_php_container()
				if container then
					vim.cmd("TermExec cmd='docker exec -it " .. container .. " php artisan'")
				else
					vim.notify("No PHP container found", vim.log.levels.WARN)
				end
			end, { desc = "Docker Artisan Commands (Dynamic)" })
		end,
	},

	-- Enhanced file explorer with exclusions
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_by_name = {
						"vendor",
						"node_modules",
						"storage",
						"bootstrap/cache",
						".phpunit.result.cache",
						"docker",
						".docker",
						"logs",
						"cache",
						"tmp",
						"temp",
					},
					hide_by_pattern = {
						"*.log",
						"*.cache",
						"*.tmp",
					},
				},
			},
		},
	},
}
