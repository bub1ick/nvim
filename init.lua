-- Make comments italisized
vim.o.guifont = "Proggy_Font:h14:w0"
vim.cmd.highlight({ "Comment", "gui=italic" })
vim.opt.linespace = 0
vim.cmd.colorscheme("retrobox")

-- Set showing current and relative line numbers
vim.opt.number         = true
vim.opt.relativenumber = true

-- Show hidden characters
vim.opt.list           = true
vim.opt.listchars      = { eol = "$", tab = "→ ", space = "·", extends = ">", precedes = "<", trail = "▫" }
vim.opt.showbreak      = "↲"

-- Set locale to english UTF-8
vim.cmd.language("en_US.UTF-8")

-- Set nvim internal encoding
vim.opt.encoding = "utf-8"
if vim.fn.has("win32") then
    -- Use cp1251 (Windows Cyrillic) if not utf-8 when opening files
    vim.opt.fileencodings:remove { "latin1", "default" }
    vim.opt.fileencodings:append { "cp1251", }
end

-- Add lang mapping
--                (        rus;eng  ),
vim.opt.langmap = "№;#," ..
--                (         rus;eng        ),
                  "йцукенгшщзхъ;qwertyuiop[]," ..
--                (          rus;eng           ),
                  "ЙЦУКЕНГШЩЗХЪ;QWERTYUIOP{}," ..
--                (        rus;eng          ),
                  "фывапролджэ;asdfghjkl\\;\'," ..
--                (           rus;eng       ),
                  "ФЫВАПРОЛДЖЭ;ASDFGHJKL:\\\"," ..
--                (       rus;eng        ),
                  "ячсмитьбю;zxcvbnm\\,.," ..
--                (         rus;eng      )
                  "ЯЧСМИТЬБЮ;ZXCVBNM<>"

-- Turn off annoying bell sound
vim.opt.belloff = "all"

--- Set tab options
-- Make \t appear as 8 spaces
vim.opt.tabstop     = 8
-- Allways indent by 4 when using tab. Every 8 spaces tab may potentially be used
vim.opt.softtabstop = 4
-- For > operator. Specifies amount of spaces added
vim.opt.shiftwidth  = 4
-- Always uses spaces even if tabs may be used.
vim.opt.expandtab   = true

--- Netrw settings
vim.g.netrw_sort_by = "name"
-- When sorting by name, order in which to sort
vim.g.netrw_sort_sequence = "[\\/]$,\\.h$,\\.c$,\\.hpp$,\\.cpp$,*,\\.o$,\\.obj$,\\.info$,\\.swp$,\\.bak$,\\~$"
-- Disable the banner on top of the screen
vim.g.netrw_banner = 0
-- On "v" command in netrw open the file on the right
vim.g.netrw_altv = 1
-- By default use "short" listing (w/o timestamps and etc.)
vim.g.netrw_liststyle = 0
-- Preview on the right on "p"
vim.g.netrw_preview = 1
-- Syntax highlighting for special file extensions (not sure if it works at all)
vim.g.netrw_special_syntax = 1

-- Add working directory recursively
vim.opt.path:prepend("**")

-- Settings for C/C++
if vim.env.INCLUDE and vim.fn.has("win32") then
    -- Add include directory to path for easy go-to-file functionality
    local include_paths = vim.env.INCLUDE
    -- For some reason some paths have \\ in them. We need to replace them with single \
    include_paths = vim.fn.substitute(include_paths, "\\\\\\\\", "\\", "g") -- LMAO this \
    -- Replace \ with /
    include_paths = vim.fn.substitute(include_paths, "\\", "/", "g")
    -- Replace ; with ,
    include_paths = vim.fn.substitute(include_paths, ";", ",", "g")
    -- Replace <Space> with \\<Space>
    include_paths = vim.fn.substitute(include_paths, " ", "\\\\ ", "g")

    vim.opt.path:append(include_paths)
end

-- All custom mappings
require("mappings")

-- Lazy plugin manager
local lazy = require("lazy")
lazy.setup("lazyspec")

-- lspconfig
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({}) -- C/C++ config
lspconfig.cmake.setup({}) -- CMake config
lspconfig.omnisharp.setup({ -- C# config
    cmd = { "dotnet", "OmniSharp.dll" },

    settings = {
        FormattingOptions = {
            -- Enables support for reading code style, naming convention and analyzer
            -- settings from .editorconfig.
            EnableEditorConfigSupport = true,
            -- Specifies whether 'using' directives should be grouped and sorted during
            -- document formatting.
            OrganizeImports = nil,
        },
        MsBuild = {
            -- If true, MSBuild project system will only load projects for files that
            -- were opened in the editor. This setting is useful for big C# codebases
            -- and allows for faster initialization of code navigation features only
            -- for projects that are relevant to code that is being edited. With this
            -- setting enabled OmniSharp may load fewer projects and may thus display
            -- incomplete reference lists for symbols.
            LoadProjectsOnDemand = nil,
        },
        RoslynExtensionsOptions = {
            -- Enables support for roslyn analyzers, code fixes and rulesets.
            EnableAnalyzersSupport = nil,
            -- Enables support for showing unimported types and unimported extension
            -- methods in completion lists. When committed, the appropriate using
            -- directive will be added at the top of the current file. This option can
            -- have a negative impact on initial completion responsiveness,
            -- particularly for the first few completion sessions after opening a
            -- solution.
            EnableImportCompletion = nil,
            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
            -- true
            AnalyzeOpenDocumentsOnly = nil,
        },
        Sdk = {
            -- Specifies whether to include preview versions of the .NET SDK when
            -- determining which version to use for project loading.
            IncludePrereleases = true,
        },
    },
})
