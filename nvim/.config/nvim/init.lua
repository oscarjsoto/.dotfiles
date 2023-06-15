require("oscar")

-- Function to reload Lua files in specified directories
function reload()
    -- Reload files in .config/nvim/plugin directory
    local plugin_path = vim.fn.expand('~/.config/nvim/plugin')
    for _, file in ipairs(vim.fn.readdir(plugin_path)) do
        if file:sub(-4) == '.lua' then
            local plugin_file = plugin_path .. '/' .. file
            package.loaded[plugin_file] = nil
            dofile(plugin_file)
        end
    end

    -- Reload files in .config/nvim/lua/user/ directory
    local user_path = vim.fn.expand('~/.config/nvim/lua/oscar')
    for _, file in ipairs(vim.fn.readdir(user_path)) do
        if file:sub(-4) == '.lua' then
            local user_file = user_path .. '/' .. file
            package.loaded[user_file] = nil
            dofile(user_file)
        end
    end

end

