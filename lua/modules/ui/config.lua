local config = {}

function config.edge()
    vim.cmd [[set background=dark]]
    vim.g.edge_style = "aura"
    vim.g.edge_enable_italic = 1
    vim.g.edge_disable_italic_comment = 1
    vim.g.edge_show_eob = 1
    vim.g.edge_better_performance = 1
end

function config.tokyonight()
    -- Example config in Lua
    vim.g.tokyonight_style = "storm"
    -- vim.g.tokyonight_italic_functions = true
    -- vim.g.tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer"}

    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    vim.g.tokyonight_colors = {hint = "orange", error = "#ff0000"}
    vim.cmd [[colorscheme tokyonight]]
end

function config.catppuccin()
    require("catppuccin").setup(
        {
            transparent_background = false,
            term_colors = true,
            styles = {
                comments = "italic",
                functions = "italic",
                keywords = "italic",
                strings = "NONE",
                variables = "NONE"
            },
            integrations = {
                treesitter = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = "italic",
                        hints = "italic",
                        warnings = "italic",
                        information = "italic"
                    },
                    underlines = {
                        errors = "underline",
                        hints = "underline",
                        warnings = "underline",
                        information = "underline"
                    }
                },
                lsp_trouble = true,
                lsp_saga = true,
                gitgutter = false,
                gitsigns = true,
                telescope = true,
                nvimtree = {enabled = true, show_root = true},
                which_key = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false
                },
                dashboard = true,
                neogit = false,
                vim_sneak = false,
                fern = false,
                barbar = false,
                bufferline = true,
                markdown = true,
                lightspeed = false,
                ts_rainbow = true,
                hop = true
            }
        }
    )
end

function config.lualine()
    local gps = require("nvim-gps")

    local function gps_content()
        if gps.is_available() then
            return gps.get_location()
        else
            return ""
        end
    end
    local mini_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {"location"}
    }
    local simple_sections = {
        lualine_a = {"mode"},
        lualine_b = {"filetype"},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {"location"}
    }
    local minimap = {
        sections = mini_sections,
        filetypes = {"minimap"}
    }
    local aerial = {
        sections = mini_sections,
        filetypes = {"aerial"}
    }
    local dapui_scopes = {
        sections = simple_sections,
        filetypes = {"dapui_scopes"}
    }

    local dapui_breakpoints = {
        sections = simple_sections,
        filetypes = {"dapui_breakpoints"}
    }

    local dapui_stacks = {
        sections = simple_sections,
        filetypes = {"dapui_stacks"}
    }

    local dapui_watches = {
        sections = simple_sections,
        filetypes = {"dapui_watches"}
    }

    require("lualine").setup(
        {
            options = {
                icons_enabled = true,
                theme = "catppuccin",
                disabled_filetypes = {},
                component_separators = "|",
                section_separators = {left = "", right = ""}
            },
            sections = {
                lualine_a = {"mode"},
                lualine_b = {{"branch"}, {"diff"}},
                lualine_c = {
                    {"lsp_progress"},
                    {gps_content, cond = gps.is_available}
                },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = {"nvim_diagnostic"},
                        symbols = {error = " ", warn = " ", info = " "}
                    }
                },
                lualine_y = {
                    {
                        "filetype",
                        "encoding"
                    },
                    {
                        "fileformat",
                        icons_enabled = true,
                        symbols = {
                            unix = "LF",
                            dos = "CRLF",
                            mac = "CR"
                        }
                    }
                },
                lualine_z = {"progress", "location"}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {"filename"},
                lualine_x = {"location"},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            extensions = {
                "quickfix",
                "nvim-tree",
                "toggleterm",
                "fugitive",
                minimap,
                aerial,
                dapui_scopes,
                dapui_breakpoints,
                dapui_stacks,
                dapui_watches
            }
        }
    )
end

--
-- function config.lualine()
--     local gps = require("nvim-gps")
--
--     local function gps_content()
--         if gps.is_available() then
--             return gps.get_location()
--         else
--             return ""
--         end
--     end
--
--     require("lualine").setup {
--         options = {
--             icons_enabled = true,
--             theme = "tokyonight",
--             disabled_filetypes = {},
--             component_separators = "|",
--             section_separators = {left = "", right = ""}
--         },
--         sections = {
--             lualine_a = {"mode"},
--             lualine_b = {{"branch"}, {"diff"}},
--             lualine_c = {
--                 {"lsp_progress"},
--                 {gps_content, cond = gps.is_available}
--             },
--             lualine_x = {
--                 {
--                     "diagnostics",
--                     sources = {"nvim_diagnostic"},
--                     color_error = "#BF616A",
--                     color_warn = "#EBCB8B",
--                     color_info = "#81A1AC",
--                     color_hint = "#88C0D0",
--                     symbols = {error = " ", warn = " ", info = " "}
--                 }
--             },
--             lualine_y = {"filetype", "encoding", "fileformat"},
--             lualine_z = {"progress", "location"}
--         },
--         inactive_sections = {
--             lualine_a = {},
--             lualine_b = {},
--             lualine_c = {"filename"},
--             lualine_x = {"location"},
--             lualine_y = {},
--             lualine_z = {}
--         },
--         tabline = {},
--         extensions = {}
--     }
-- end

function config.nvim_tree()
    local tree_cb = require "nvim-tree.config".nvim_tree_callback
    require("nvim-tree").setup {
        gitignore = true,
        ignore = {".git", "node_modules", ".cache"},
        open_on_tab = false,
        disable_netrw = true,
        hijack_netrw = true,
        auto_close = true,
        update_cwd = true,
        highlight_opened_files = true,
        auto_ignore_ft = {"startify", "dashboard"},
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {}
        },
        view = {
            width = 30,
            side = "left",
            auto_resize = false,
            mappings = {
                custom_only = true,
                -- list of mappings to set on the tree manually
                list = {
                    {
                        key = {"<CR>", "o", "<2-LeftMouse>"},
                        cb = tree_cb("tabnew")
                    },
                    {key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
                    {key = "<C-v>", cb = tree_cb("vsplit")},
                    {key = "<C-x>", cb = tree_cb("split")},
                    {key = "<C-t>", cb = tree_cb("tabnew")},
                    {key = "<", cb = tree_cb("prev_sibling")},
                    {key = ">", cb = tree_cb("next_sibling")},
                    {key = "P", cb = tree_cb("parent_node")},
                    {key = "<BS>", cb = tree_cb("close_node")},
                    {key = "<S-CR>", cb = tree_cb("close_node")},
                    {key = "<Tab>", cb = tree_cb("preview")},
                    {key = "K", cb = tree_cb("first_sibling")},
                    {key = "J", cb = tree_cb("last_sibling")},
                    {key = "I", cb = tree_cb("toggle_ignored")},
                    {key = "H", cb = tree_cb("toggle_dotfiles")},
                    {key = "R", cb = tree_cb("refresh")},
                    {key = "a", cb = tree_cb("create")},
                    {key = "d", cb = tree_cb("remove")},
                    {key = "r", cb = tree_cb("rename")},
                    {key = "<C-r>", cb = tree_cb("full_rename")},
                    {key = "x", cb = tree_cb("cut")},
                    {key = "c", cb = tree_cb("copy")},
                    {key = "p", cb = tree_cb("paste")},
                    {key = "y", cb = tree_cb("copy_name")},
                    {key = "Y", cb = tree_cb("copy_path")},
                    {key = "gy", cb = tree_cb("copy_absolute_path")},
                    {key = "[c", cb = tree_cb("prev_git_item")},
                    {key = "]c", cb = tree_cb("next_git_item")},
                    {key = "-", cb = tree_cb("dir_up")},
                    {key = "s", cb = tree_cb("system_open")},
                    {key = "q", cb = tree_cb("close")},
                    {key = "g?", cb = tree_cb("toggle_help")}
                }
            }
        }
    }
end

function config.nvim_bufferline()
    require("bufferline").setup {
        options = {
            number = "none",
            modified_icon = "✥",
            buffer_close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 14,
            max_prefix_length = 13,
            tab_size = 20,
            show_buffer_close_icons = true,
            show_buffer_icons = true,
            show_tab_indicators = true,
            diagnostics = "nvim",
            always_show_bufferline = true,
            separator_style = "thin",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    padding = 1
                }
            }
        }
    }
end

function config.gitsigns()
    if not packer_plugins["plenary.nvim"].loaded then
        vim.cmd [[packadd plenary.nvim]]
    end
    require("gitsigns").setup {
        signs = {
            add = {hl = "GitGutterAdd", text = "▋"},
            change = {hl = "GitGutterChange", text = "▋"},
            delete = {hl = "GitGutterDelete", text = "▋"},
            topdelete = {hl = "GitGutterDeleteChange", text = "▔"},
            changedelete = {hl = "GitGutterChange", text = "▎"}
        },
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,
            ["n ]g"] = {
                expr = true,
                '&diff ? \']g\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\''
            },
            ["n [g"] = {
                expr = true,
                '&diff ? \'[g\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\''
            },
            ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
            ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
            ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
            ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
            ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
            -- Text objects
            ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
            ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>'
        },
        watch_gitdir = {interval = 1000, follow_files = true},
        current_line_blame = true,
        current_line_blame_opts = {delay = 1000, virtual_text_pos = "eol"},
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        diff_opts = {internal = true}
    }
end

function config.indent_blankline()
    -- vim.cmd [[highlight IndentTwo guifg=#D08770 guibg=NONE gui=nocombine]]
    -- vim.cmd [[highlight IndentThree guifg=#EBCB8B guibg=NONE gui=nocombine]]
    -- vim.cmd [[highlight IndentFour guifg=#A3BE8C guibg=NONE gui=nocombine]]
    -- vim.cmd [[highlight IndentFive guifg=#5E81AC guibg=NONE gui=nocombine]]
    -- vim.cmd [[highlight IndentSix guifg=#88C0D0 guibg=NONE gui=nocombine]]
    -- vim.cmd [[highlight IndentSeven guifg=#B48EAD guibg=NONE gui=nocombine]]
    -- vim.g.indent_blankline_char_highlight_list = {
    --     "IndentTwo", "IndentThree", "IndentFour", "IndentFive", "IndentSix",
    --     "IndentSeven"
    -- }
    vim.opt.termguicolors = true
    vim.opt.list = true
    vim.opt.listchars:append("space:⋅")
    require("indent_blankline").setup {
        char = "│",
        show_first_indent_level = true,
        filetype_exclude = {
            "startify",
            "dashboard",
            "dotooagenda",
            "log",
            "fugitive",
            "gitcommit",
            "packer",
            "vimwiki",
            "markdown",
            "json",
            "txt",
            "vista",
            "help",
            "todoist",
            "NvimTree",
            "peekaboo",
            "git",
            "TelescopePrompt",
            "undotree",
            "flutterToolsOutline",
            "" -- for all buffers without a file type
        },
        buftype_exclude = {"terminal", "nofile"},
        show_trailing_blankline_indent = false,
        show_current_context = true,
        context_patterns = {
            "class",
            "function",
            "method",
            "block",
            "list_literal",
            "selector",
            "^if",
            "^table",
            "if_statement",
            "while",
            "for",
            "type",
            "var",
            "import"
        },
        space_char_blankline = " "
    }

    -- because lazy load indent-blankline so need readd this autocmd
    vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
end

return config
