local utils = { }

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function utils.getOS()
    -- Check the `package.config` for directory separator.
    -- In Windows, the directory separator is `\`, while in Unix-like systems it's `/`.
    local separator = package.config:sub(1,1)
    
    if separator == "\\" then
        return "Windows"
    else
        return "Unix"
    end
end

return utils
