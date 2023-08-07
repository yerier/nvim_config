require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  }
})

require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
    ensure_installed = {
        "lua_ls",
        "cmake",
        "clangd",
        "rome",
        "bashls"

    },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local util = require 'lspconfig.util'

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
}

-- require("clangd_extensions").setup()require("clangd_extensions").prepare()

local root_files = {
	'.clangd',
	'.clang-tidy',
	'.clang-format',
	'compile_commands.json',
	'compile_flags.txt',
    'build/compile_commands.json',
	'build.sh', -- buildProject
	'configure.ac', -- AutoTools
}


require("clangd_extensions").setup {
    server = {

        -- options to pass to nvim-lspconfig
        -- i.e. the arguments to require("lspconfig").clangd.setup({})
        require('lspconfig').clangd.setup {
            -- -- on_attach = keybinds.on_attach,
            cmd = {
                "clangd",
                -- "--background-index",
                -- "--suggest-missing-includes",
                -- "--remove:-fconserve-stack",
                -- "--compile-commands-dir=./",
                "--background-index",
                "--clang-tidy",
    		    "--compile_args_from=filesystem", -- lsp-> does not come from compie_commands.json
    		    "--completion-parse=always",
    		    "--completion-style=bundled",
    		    "--cross-file-rename",
		        "--debug-origin",
		        "--function-arg-placeholders",
		        "--header-insertion=iwyu",
		        "-j=4",		-- number of workers
		        -- "--resource-dir="
	    	    "--suggest-missing-includes",
            },
            filetypes = { "c", "cpp", "objc", "objcpp" },
	        root_dir = function(fname)
			        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
		        end,
                single_file_support = true,
	                init_options = {
		        compilationDatabasePath="./build",
	            },
            }
        },
    extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
        },
        ast = {
            -- These are unicode, should be available in any font
            role_icons = {
                 type = "🄣",
                 declaration = "🄓",
                 expression = "🄔",
                 statement = ";",
                 specifier = "🄢",
                 ["template argument"] = "🆃",
            },
            kind_icons = {
                Compound = "🄲",
                Recovery = "🅁",
                TranslationUnit = "🅄",
                PackExpansion = "🄿",
                TemplateTypeParm = "🅃",
                TemplateTemplateParm = "🅃",
                TemplateParamObject = "🅃",
            },
            --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            }, ]]

            highlights = {
                detail = "Comment",
            },
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    },
}

-- require('lspconfig').bashls.setup {
--
-- }
--
-- require('lspconfig').cmake.setup {
--
-- }
--
-- require('lspconfig').jsonls.setup {
--
-- }

require("mason-lspconfig").setup_handlers({
  function (server_name)
    require("lspconfig")[server_name].setup{}
  end
})
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

-- require('lspconfig').clangd.setup {
--     -- on_attach = keybinds.on_attach,
--     cmd = {
--         "clangd",
--         "--background-index",
--         "--suggest-missing-includes",
--         -- "--compile-commands-dir=./",
--     },
--     compileflags = {
--         "-fconserve-stack, -fno-allow-store-data-races"
--     },
--     filetypes = { "c", "cpp", "objc", "objcpp" },
-- }

