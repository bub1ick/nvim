return {
    -- The best theme out there
    {
        "sainnhe/everforest",
        priority = 100,
        lazy = false,
        config = function()
            -- enable italic
            vim.g.everforest_enable_italic = true
            -- hard, medium, soft
            vim.g.everforest_background = "hard"
            -- set cursor color
            vim.g.everforest_cursor = "aqua"
            -- Try transparency effects
            vim.g.everforest_transparent_background = 2
            -- Dim inactive windows
            vim.g.everforest_dim_inactive_windows = 1
            -- Make background dark
            vim.opt.background = "dark"
            -- enable the theme
            vim.cmd.colorscheme("everforest")
        end
    },
    -- LSPenis
    {
        "neovim/nvim-lspconfig",
        config = function()
            
        end
    }
}