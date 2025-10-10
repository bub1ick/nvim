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

