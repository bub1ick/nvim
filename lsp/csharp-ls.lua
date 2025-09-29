--@type vim.lsp.Config
local config = {}

config.cmd = { "csharp-ls" }

local find_root_dir_with_file = function(fname, pat)
    local results = vim.fs.find(
        function(name, path)
            local result = name:match(pat)
            return result
        end,
        {
            path = vim.fs.dirname(fname),
            upward = true,
            type = "file"
        })
    return vim.fs.dirname(results[1])
end

config.root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)

    local solution_dir = find_root_dir_with_file(fname, ".*%.slnx?$")
    if solution_dir then
        return on_dir(solution_dir)
    end

    local csproj_dir = find_root_dir_with_file(fname, ".*%.csproj$")
    if csproj_dir then
        return on_dir(csproj_dir)
    end
end

config.filetypes = { "cs" }

config.init_options = {
    AutomaticWorkspaceInit = true,
}

return config
