--
require 'nvim-treesitter.configs'.setup{
    ensure_installed = {"vim", "help", "bash", "c", "cpp", "javascript", "rust", "json", "lua", "python"},

    highlight = {enable = true},
    indent = {enable = true},

    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nul,
    }
}
