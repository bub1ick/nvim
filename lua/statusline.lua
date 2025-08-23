local define_status_line = function()
    -- <Truncate>
    --
    -- <Left Alignment Section>
    -- "[b: <buffer_number>]"
    -- "[w: <window_number>]"
    --
    -- <Center Alignment Section>
    -- <relative_filepath>
    -- 
    -- "[<Filetype>]"
    -- "[Preview]"
    -- "[+]" or "[-]"
    -- "[RO]" 
    --
    -- <Right Alignment Section>
    -- <Left Justify> <Min Width = 14>
    --      <line_number>
    --      ","
    --      <column_number>
    --      <virt_column_number>
    --
    -- File Percentage

    local statusline_str = "%<"

    statusline_str = statusline_str .. "[b: %02.3n]"
    local window_number = tostring(vim.fn.winnr("#"))
    statusline_str = statusline_str .. "[w: %02.3{string(winnr())}]"

    statusline_str = statusline_str .. "%=%="
    statusline_str = statusline_str .. "%f"
    statusline_str = statusline_str .. " "

    statusline_str = statusline_str .. "%y"
    statusline_str = statusline_str .. "%w"
    statusline_str = statusline_str .. "%m"
    statusline_str = statusline_str .. "%r"

    statusline_str = statusline_str .. "%="
    statusline_str = statusline_str .. "%-14."
    statusline_str = statusline_str .. "("
        statusline_str = statusline_str .. "%l"
        statusline_str = statusline_str .. ":"
        statusline_str = statusline_str .. "%c"
        statusline_str = statusline_str .. "%V"
    statusline_str = statusline_str .. "%)"
    statusline_str = statusline_str .. ""

    statusline_str = statusline_str .. "%P"

    return statusline_str
end
vim.opt.statusline = define_status_line()

-- if vim.g.colors_name == "moonfly" then
--     vim.g.moonflyCursorColor = true
--     vim.g.moonflyItalics = true
--     vim.g.moonflyNormalFloat = false
--     vim.g.moonflyTerminalColors = false
--     vim.g.moonflyTransparent = false
--     vim.g.moonflyUndercurls = true
--     vim.g.moonflyUnderlineMatchParen = true
--     vim.g.moonflyVirtualTextColor = true
--     -- Get the colorscheme table
--     local moonfly = require("moonfly")
-- 
--     -- format the User1-9 highlighting
--     local highlight_commands = [[
-- highlight User1 guibg=%s guifg=%s
-- highlight User2 guibg=%s guifg=%s
-- highlight User3 guibg=%s guifg=%s
-- highlight User4 guibg=%s guifg=%s
-- highlight User5 guibg=%s guifg=%s
-- highlight User6 guibg=%s guifg=%s
-- highlight User7 guibg=%s guifg=%s
-- highlight User8 guibg=%s guifg=%s
-- highlight User9 guibg=%s guifg=%s]]
--     highlight_commands = string.format(highlight_commands,
--         moonfly.palette.grey15, moonfly.palette.emerald, -- User 1
--         moonfly.palette.grey15, moonfly.palette.emerald,   -- User 2
--         moonfly.palette.grey15, moonfly.palette.yellow,  -- User 3
--         moonfly.palette.grey15, moonfly.palette.turquoise,   -- User 4
--         moonfly.palette.grey15, moonfly.palette.blue,    -- User 5
--         moonfly.palette.grey15, moonfly.palette.violet,  -- User 6
--         moonfly.palette.grey15, moonfly.palette.red,     -- User 7
--         moonfly.palette.grey15, moonfly.palette.emerald,     -- User 8
--         moonfly.palette.grey15, moonfly.palette.emerald)     -- User 9
--     vim.cmd(highlight_commands)
-- end
