local M = {}

-- Configuration
local config = {
    asciiart = {
    "        :::      ::::::::",
    "      :+:      :+:    :+:",
    "    +:+ +:+         +:+  ",
    "  +#+  +:+       +#+     ",
    "+#+#+#+#+#+   +#+        ",
    "     #+#    #+#          ",
    "    ###   ########.fr    "
    },
    start = "/*",
    stop = "*/",
    fill = "*",
    length = 80,
    margin = 5,
    types = {
		['%.c$|%.h$|%.cc$|%.hh$|%.cpp$|%.hpp$|%.tpp$|%.ipp$|%.cxx$|%.go$|%.rs$|%.php$|%.py$|%.java$|%.kt$|%.kts$'] = {'/*', '*/', '*'},
        ['%.htm$|%.html$|%.xml$'] = {'<!--', '-->', '*'},
        ['%.js$|%.ts$'] = {'//', '//', '*'},
        ['%.tex$'] = {'%', '%', '*'},
        ['%.ml$|%.mli$|%.mll$|%.mly$'] = {'(*', '*)', '*'},
        ['%.vim$|vimrc$'] = {'"', '"', '*'},
        ['%.el$|%.emacs$|%.asm$'] = {';', ';', '*'},
        ['%.f90$|%.f95$|%.f03$|%.f$|%.for$'] = {'!', '!', '/'},
        ['%.lua$'] = {'--', '--', '-'},
		["%.py$"] = { "#", "#", "*" }
    }
}

-- Determine filetype and set comment markers
local function determine_filetype()
    local filetype = vim.bo.filetype
    for pattern, markers in pairs(config.types) do
        if filetype:match(pattern) then
            config.start, config.stop, config.fill = markers[1], markers[2], markers[3]
            return
        end
    end
end

-- Build a specific line of the header
local function build_line(n)
    if n == 1 or n == 11 then
        return config.start .. " " .. string.rep(config.fill, config.length - 2 - #config.start - #config.stop) .. " " .. config.stop
    elseif n == 2 or n == 10 then
        return config.start .. string.rep(" ", config.length - 2 - #config.start - #config.stop) .. config.stop
    elseif n >= 3 and n <= 7 then
        return config.start .. string.rep(" ", config.margin) .. config.asciiart[n - 2] .. string.rep(" ", config.length - #config.asciiart[n - 2] - 2 * config.margin - #config.start - #config.stop) .. config.stop
    elseif n == 8 then
        return config.start .. string.rep(" ", config.margin) .. "Created: " .. os.date("%Y/%m/%d %H:%M:%S") .. string.rep(" ", config.length - 2 * config.margin - #("Created: " .. os.date("%Y/%m/%d %H:%M:%S")) - #config.start - #config.stop) .. config.stop
    elseif n == 9 then
        return config.start .. string.rep(" ", config.margin) .. "Updated: " .. os.date("%Y/%m/%d %H:%M:%S") .. string.rep(" ", config.length - 2 * config.margin - #("Updated: " .. os.date("%Y/%m/%d %H:%M:%S")) - #config.start - #config.stop) .. config.stop
    end
    return ""
end

-- Insert the header
function M.insert_header()
    determine_filetype()
    local lines = {}
    for i = 11, 1, -1 do
        table.insert(lines, build_line(i))
    end
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end

-- Update the header
function M.update_header()
    determine_filetype()
    local line = build_line(9)
    local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
    if buffer_lines[9] and buffer_lines[9]:find("Updated:") then
        vim.api.nvim_buf_set_lines(0, 8, 9, false, { line })
    end
end

return M
