--
require 'nvim-treesitter.configs'.setup{
    ensure_installed = {"vim", "vimdoc", "bash", "c", "cpp", "javascript", "rust", "json", "lua", "python", "css", "markdown"},

    highlight = {enable = true},
    indent = {enable = true},

    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nul,
    }
}
