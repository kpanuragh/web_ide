

return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        -- Enhanced PHP formatting with multiple options
        php = { "php_cs_fixer", "phpcbf" },
        python = { "black" },
        go = { "gofmt" },
        rust = { "rustfmt" },
        lua = { "stylua" },
        blade = { "blade_formatter" },
      },
      
      -- Custom formatter configurations
      formatters = {
        -- Docker-aware PHP-CS-Fixer with dynamic container detection
        php_cs_fixer = {
          command = "docker",
          args = function(self, ctx)
            -- Dynamically find PHP container
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
              
              -- Last fallback: check docker-compose services
              handle = io.popen("docker-compose ps --services 2>/dev/null | grep -E '(php|app|web)' | head -1")
              result = handle:read("*a")
              handle:close()
              
              if result and result:match("%S") then
                local service = result:gsub("%s+", "")
                -- Get actual container name from service
                handle = io.popen("docker-compose ps -q " .. service .. " 2>/dev/null | xargs docker inspect --format '{{.Name}}' 2>/dev/null")
                local container_name = handle:read("*a")
                handle:close()
                if container_name and container_name:match("%S") then
                  return container_name:gsub("^/", ""):gsub("%s+", "")
                end
                return service
              end
              
              return nil
            end
            
            local container = find_php_container()
            if not container then
              error("No PHP container found. Make sure your PHP container is running.")
            end
            
            local container_path = ctx.filename:gsub(vim.fn.getcwd(), "/var/www/html")
            return {
              "exec", container,
              "php-cs-fixer", "fix",
              "--rules=@PSR12,@Symfony",
              "--allow-risky=yes",
              container_path,
            }
          end,
          stdin = false,
          -- Only format if any PHP container is running
          condition = function()
            local handle = io.popen("docker ps --filter 'ancestor=php' --format '{{.Names}}' 2>/dev/null")
            local result = handle:read("*a")
            handle:close()
            
            if result and result:match("%S") then
              return true
            end
            
            -- Check for containers with 'php' in name
            handle = io.popen("docker ps --format '{{.Names}}' | grep -i php 2>/dev/null")
            result = handle:read("*a")
            handle:close()
            
            return result and result:match("%S")
          end,
        },
        -- Fallback local PHP-CS-Fixer
        php_cs_fixer_local = {
          command = "php-cs-fixer",
          args = {
            "fix",
            "--rules=@PSR12,@Symfony",
            "--allow-risky=yes",
            "$FILENAME",
          },
          stdin = false,
        },
        phpcbf = {
          command = "phpcbf",
          args = {
            "--standard=PSR12",
            "--suffix=",
            "$FILENAME",
          },
          stdin = false,
        },
      },
      
      format_on_save = false,
    })
  end,
}

