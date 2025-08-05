-- Project-specific configuration for large PHP projects
-- Create this file in your project root as .nvimrc or add to your main config

-- Project detection
local function is_large_php_project()
	local cwd = vim.fn.getcwd()
	local composer_json = cwd .. "/composer.json"
	local dockerfile = cwd .. "/Dockerfile"
	local docker_compose = cwd .. "/docker-compose.yml"
	
	return vim.fn.filereadable(composer_json) == 1 and 
		   (vim.fn.filereadable(dockerfile) == 1 or vim.fn.filereadable(docker_compose) == 1)
end

-- Apply optimizations only for large PHP projects
if is_large_php_project() then
	-- LSP optimizations
	vim.lsp.set_log_level("warn") -- Reduce LSP logging
	
	-- Disable features that are heavy on large projects
	vim.g.loaded_matchparen = 1
	vim.g.loaded_matchit = 1
	
	-- Project-specific excludes
	vim.opt.wildignore:append({
		"*/vendor/*",
		"*/storage/*",
		"*/bootstrap/cache/*",
		"*/node_modules/*",
		"*/docker/*",
		"*/.docker/*",
		"*.log",
		"*.cache",
	})
	
	-- Set up project-specific keymaps
	local function setup_php_project_keymaps()
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
			
			if result and result:match("%S") then
				return result:gsub("%s+", "")
			end
			
			-- Check docker-compose services
			handle = io.popen("docker-compose ps --services 2>/dev/null | grep -E '(php|app|web)' | head -1")
			result = handle:read("*a")
			handle:close()
			
			if result and result:match("%S") then
				return result:gsub("%s+", "")
			end
			
			return nil
		end
		
		-- Docker commands
		vim.keymap.set("n", "<leader>dc", ":!docker-compose up -d<CR>", { desc = "Docker Compose Up" })
		vim.keymap.set("n", "<leader>dd", ":!docker-compose down<CR>", { desc = "Docker Compose Down" })
		vim.keymap.set("n", "<leader>dr", ":!docker-compose restart<CR>", { desc = "Docker Compose Restart" })
		vim.keymap.set("n", "<leader>dl", ":!docker-compose logs -f<CR>", { desc = "Docker Compose Logs" })
		
		-- Dynamic PHP container commands
		vim.keymap.set("n", "<leader>dsh", function()
			local container = find_php_container()
			if container then
				vim.cmd(":!docker exec -it " .. container .. " bash")
			else
				vim.notify("No PHP container found", vim.log.levels.WARN)
			end
		end, { desc = "Docker Shell (Dynamic)" })
		
		vim.keymap.set("n", "<leader>dci", function()
			local container = find_php_container()
			if container then
				vim.cmd(":!docker exec -it " .. container .. " composer install")
			else
				vim.notify("No PHP container found", vim.log.levels.WARN)
			end
		end, { desc = "Composer Install (Dynamic)" })
		
		vim.keymap.set("n", "<leader>dcu", function()
			local container = find_php_container()
			if container then
				vim.cmd(":!docker exec -it " .. container .. " composer update")
			else
				vim.notify("No PHP container found", vim.log.levels.WARN)
			end
		end, { desc = "Composer Update (Dynamic)" })
		
		-- Laravel Artisan (if Laravel project)
		if vim.fn.filereadable("artisan") == 1 then
			vim.keymap.set("n", "<leader>dam", function()
				local container = find_php_container()
				if container then
					vim.cmd(":!docker exec -it " .. container .. " php artisan migrate")
				else
					vim.notify("No PHP container found", vim.log.levels.WARN)
				end
			end, { desc = "Artisan Migrate (Dynamic)" })
			
			vim.keymap.set("n", "<leader>dac", function()
				local container = find_php_container()
				if container then
					vim.cmd(":!docker exec -it " .. container .. " php artisan cache:clear")
				else
					vim.notify("No PHP container found", vim.log.levels.WARN)
				end
			end, { desc = "Artisan Cache Clear (Dynamic)" })
			
			vim.keymap.set("n", "<leader>dar", function()
				local container = find_php_container()
				if container then
					vim.cmd(":!docker exec -it " .. container .. " php artisan route:list")
				else
					vim.notify("No PHP container found", vim.log.levels.WARN)
				end
			end, { desc = "Artisan Routes (Dynamic)" })
		end
		
		-- Fast file search for PHP projects
		vim.keymap.set("n", "<leader>ff", function()
			require("telescope.builtin").find_files({
				find_command = {
					"fd", "--type", "f",
					"--exclude", "vendor",
					"--exclude", "storage/logs",
					"--exclude", "storage/framework",
					"--exclude", "bootstrap/cache",
					"--exclude", "node_modules",
					"--exclude", "docker",
					"--exclude", ".docker",
				}
			})
		end, { desc = "Find Files (Optimized)" })
		
		-- PHP-specific grep
		vim.keymap.set("n", "<leader>fg", function()
			require("telescope.builtin").live_grep({
				glob_pattern = "!{vendor,storage/logs,storage/framework,bootstrap/cache,node_modules,docker}/**"
			})
		end, { desc = "Live Grep (Optimized)" })
	end
	
	-- Set up autocmds for project
	local group = vim.api.nvim_create_augroup("LargePHPProject", { clear = true })
	
	-- Apply keymaps when Neovim starts
	vim.api.nvim_create_autocmd("VimEnter", {
		group = group,
		callback = setup_php_project_keymaps,
	})
	
	-- Optimize for PHP files specifically
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = "php",
		callback = function()
			-- Disable some heavy features for PHP files in large projects
			vim.opt_local.foldmethod = "manual" -- Disable automatic folding
			vim.opt_local.spell = false -- Disable spell checking
			
			-- Set up PHP-specific optimizations
			vim.b.large_buf = true
		end,
	})
	
	-- Auto-detect and set PHP version for Docker
	local function detect_php_version()
		local dockerfile = vim.fn.getcwd() .. "/Dockerfile"
		if vim.fn.filereadable(dockerfile) == 1 then
			local content = vim.fn.readfile(dockerfile)
			for _, line in ipairs(content) do
				local version = line:match("FROM php:([%d%.]+)")
				if version then
					-- Update Intelephense PHP version
					vim.g.php_version = version
					return version
				end
			end
		end
		
		-- Default fallback
		return "7.4.0"
	end
	
	-- Set detected PHP version
	local php_version = detect_php_version()
	vim.notify("Detected PHP version: " .. php_version, vim.log.levels.INFO)
end

return {}
