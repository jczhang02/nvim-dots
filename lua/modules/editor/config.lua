local config = {}
local dap_dir = vim.fn.stdpath("data") .. "/dapinstall/"
local sessions_dir = vim.fn.stdpath("data") .. "/sessions/"

function config.aerial()
    -- Call the setup function to change the default behavior
    require("aerial").setup(
        {
            -- Priority list of preferred backends for aerial.
            -- This can be a filetype map (see :help aerial-filetype-map)
            backends = {"lsp", "treesitter", "markdown"},
            -- Enum: persist, close, auto, global
            --   persist - aerial window will stay open until closed
            --   close   - aerial window will close when original file is no longer visible
            --   auto    - aerial window will stay open as long as there is a visible
            --             buffer to attach to
            --   global  - same as 'persist', and will always show symbols for the current buffer
            close_behavior = "auto",
            -- Set to false to remove the default keybindings for the aerial buffer
            default_bindings = true,
            -- Enum: prefer_right, prefer_left, right, left, float
            -- Determines the default direction to open the aerial window. The 'prefer'
            -- options will open the window in the other direction *if* there is a
            -- different buffer in the way of the preferred direction
            default_direction = "prefer_right",
            -- Disable aerial on files with this many lines
            disable_max_lines = 10000,
            -- A list of all symbols to display. Set to false to display all symbols.
            -- This can be a filetype map (see :help aerial-filetype-map)
            -- To see all available values, see :help SymbolKind
            filter_kind = {
                "Class",
                "Constructor",
                "Enum",
                "Function",
                "Interface",
                "Module",
                "Method",
                "Struct"
            },
            -- Enum: split_width, full_width, last, none
            -- Determines line highlighting mode when multiple splits are visible.
            -- split_width   Each open window will have its cursor location marked in the
            --               aerial buffer. Each line will only be partially highlighted
            --               to indicate which window is at that location.
            -- full_width    Each open window will have its cursor location marked as a
            --               full-width highlight in the aerial buffer.
            -- last          Only the most-recently focused window will have its location
            --               marked in the aerial buffer.
            -- none          Do not show the cursor locations in the aerial window.
            highlight_mode = "split_width",
            -- Highlight the closest symbol if the cursor is not exactly on one.
            highlight_closest = true,
            -- When jumping to a symbol, highlight the line for this many ms.
            -- Set to false to disable
            highlight_on_jump = 300,
            -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
            -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
            -- default collapsed icon. The default icon set is determined by the
            -- "nerd_font" option below.
            -- If you have lspkind-nvim installed, aerial will use it for icons.
            icons = {},
            -- When you fold code with za, zo, or zc, update the aerial tree as well.
            -- Only works when manage_folds = true
            link_folds_to_tree = false,
            -- Fold code when you open/collapse symbols in the tree.
            -- Only works when manage_folds = true
            link_tree_to_folds = true,
            -- Use symbol tree for folding. Set to true or false to enable/disable
            -- 'auto' will manage folds if your previous foldmethod was 'manual'
            manage_folds = false,
            -- The maximum width of the aerial window
            max_width = 40,
            -- The minimum width of the aerial window.
            -- To disable dynamic resizing, set this to be equal to max_width
            min_width = 10,
            -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
            -- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
            nerd_font = "auto",
            -- Call this function when aerial attaches to a buffer.
            -- Useful for setting keymaps. Takes a single `bufnr` argument.
            on_attach = nil,
            -- Automatically open aerial when entering supported buffers.
            -- This can be a function (see :help aerial-open-automatic)
            open_automatic = false,
            -- Set to true to only open aerial at the far right/left of the editor
            -- Default behavior opens aerial relative to current window
            placement_editor_edge = false,
            -- Run this command after jumping to a symbol (false will disable)
            post_jump_cmd = "normal! zz",
            -- When true, aerial will automatically close after jumping to a symbol
            close_on_select = false,
            -- Show box drawing characters for the tree hierarchy
            show_guides = false,
            -- Customize the characters used when show_guides = true
            guides = {
                -- When the child item has a sibling below it
                mid_item = "├─",
                -- When the child item is the last in the list
                last_item = "└─",
                -- When there are nested child guides to the right
                nested_top = "│ ",
                -- Raw indentation
                whitespace = "  "
            },
            -- Options for opening aerial in a floating win
            float = {
                -- Controls border appearance. Passed to nvim_open_win
                border = "rounded",
                -- Controls row offset from cursor. Passed to nvim_open_win
                row = 1,
                -- Controls col offset from cursor. Passed to nvim_open_win
                col = 0,
                -- The maximum height of the floating aerial window
                max_height = 100,
                -- The minimum height of the floating aerial window
                -- To disable dynamic resizing, set this to be equal to max_height
                min_height = 4
            },
            lsp = {
                -- Fetch document symbols when LSP diagnostics update.
                -- If false, will update on buffer changes.
                diagnostics_trigger_update = true,
                -- Set to false to not update the symbols when there are LSP errors
                update_when_errors = true
            },
            treesitter = {
                -- How long to wait (in ms) after a buffer change before updating
                update_delay = 300
            },
            markdown = {
                -- How long to wait (in ms) after a buffer change before updating
                update_delay = 300
            }
        }
    )
end

function config.symbols_outline()
    vim.g.symbols_outline = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = true,
        position = "right",
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        keymaps = {
            close = "<Esc>",
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            rename_symbol = "r",
            code_actions = "a"
        },
        lsp_blacklist = {},
        symbols = {
            File = {icon = "", hl = "TSURI"},
            Module = {icon = "", hl = "TSNamespace"},
            Namespace = {icon = "", hl = "TSNamespace"},
            Package = {icon = "", hl = "TSNamespace"},
            Class = {icon = "𝓒", hl = "TSType"},
            Method = {icon = "ƒ", hl = "TSMethod"},
            Property = {icon = "", hl = "TSMethod"},
            Field = {icon = "", hl = "TSField"},
            Constructor = {icon = "", hl = "TSConstructor"},
            Enum = {icon = "ℰ", hl = "TSType"},
            Interface = {icon = "ﰮ", hl = "TSType"},
            Function = {icon = "", hl = "TSFunction"},
            Variable = {icon = "", hl = "TSConstant"},
            Constant = {icon = "", hl = "TSConstant"},
            String = {icon = "𝓐", hl = "TSString"},
            Number = {icon = "#", hl = "TSNumber"},
            Boolean = {icon = "⊨", hl = "TSBoolean"},
            Array = {icon = "", hl = "TSConstant"},
            Object = {icon = "⦿", hl = "TSType"},
            Key = {icon = "🔐", hl = "TSType"},
            Null = {icon = "NULL", hl = "TSType"},
            EnumMember = {icon = "", hl = "TSField"},
            Struct = {icon = "𝓢", hl = "TSType"},
            Event = {icon = "🗲", hl = "TSType"},
            Operator = {icon = "+", hl = "TSOperator"},
            TypeParameter = {icon = "𝙏", hl = "TSParameter"}
        }
    }
end

function config.vim_cursorwod()
    vim.api.nvim_command("augroup user_plugin_cursorword")
    vim.api.nvim_command("autocmd!")
    vim.api.nvim_command(
        "autocmd FileType NvimTree,lspsagafinder,dashboard let b:cursorword = 0"
    )
    vim.api.nvim_command(
        "autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif"
    )
    vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
    vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
    vim.api.nvim_command("augroup END")
end

function config.nvim_treesitter()
    vim.api.nvim_command("set foldmethod=expr")
    vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")

    require "nvim-treesitter.configs".setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,
            disable = {"vim", "org"},
            additional_vim_regex_highlighting = {"latex", "org"}
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner"
                }
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]["] = "@function.outer",
                    ["]m"] = "@class.outer"
                },
                goto_next_end = {
                    ["]]"] = "@function.outer",
                    ["]M"] = "@class.outer"
                },
                goto_previous_start = {
                    ["[["] = "@function.outer",
                    ["[m"] = "@class.outer"
                },
                goto_previous_end = {
                    ["[]"] = "@function.outer",
                    ["[M"] = "@class.outer"
                }
            }
        },
        rainbow = {
            enable = true,
            extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
            max_file_lines = 1000 -- Do not enable for files with more than 1000 lines, int
        },
        context_commentstring = {enable = true, enable_autocmd = false},
        matchup = {enable = true},
        context = {enable = true, throttle = true}
    }
end

function config.matchup()
    vim.cmd [[let g:matchup_matchparen_offscreen = {'method': 'popup'}]]
end

function config.nvim_gps()
    require("nvim-gps").setup(
        {
            icons = {
                ["class-name"] = " ", -- Classes and class-like objects
                ["function-name"] = " ", -- Functions
                ["method-name"] = " " -- Methods (functions inside class-like objects)
            },
            languages = {
                -- You can disable any language individually here
                ["c"] = true,
                ["cpp"] = true,
                ["go"] = true,
                ["java"] = true,
                ["javascript"] = true,
                ["lua"] = true,
                ["python"] = true,
                ["rust"] = true
            },
            separator = " > "
        }
    )
end

function config.autotag()
    require("nvim-ts-autotag").setup(
        {
            filetypes = {
                "html",
                "xml",
                "javascript",
                "typescriptreact",
                "javascriptreact",
                "vue"
            }
        }
    )
end

function config.nvim_colorizer()
    require("colorizer").setup()
end

function config.neoscroll()
    require("neoscroll").setup(
        {
            -- All these keys will be mapped to their corresponding default scrolling animation
            mappings = {
                "<C-u>",
                "<C-d>",
                "<C-b>",
                "<C-f>",
                "<C-y>",
                "<C-e>",
                "zt",
                "zz",
                "zb"
            },
            hide_cursor = true, -- Hide cursor while scrolling
            stop_eof = true, -- Stop at <EOF> when scrolling downwards
            use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
            respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            easing_function = nil, -- Default easing function
            pre_hook = nil, -- Function to run before the scrolling animation starts
            post_hook = nil -- Function to run after the scrolling animation ends
        }
    )
end

function config.format()
    require("format").setup {
        ["*"] = {
            {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
        },
        vim = {
            {
                cmd = {"luafmt -w replace"},
                start_pattern = "^lua << EOF$",
                end_pattern = "^EOF$"
            }
        },
        vimwiki = {
            {
                cmd = {"prettier -w --parser babel"},
                start_pattern = "^{{{javascript$",
                end_pattern = "^}}}$"
            }
        },
        lua = {
            {
                cmd = {
                    function(file)
                        return string.format(
                            "luafmt -l %s -w replace %s",
                            vim.bo.textwidth,
                            file
                        )
                    end
                }
            }
        },
        c = {
            {
                cmd = {
                    function(file)
                        return string.format(
                            "clang-format -i -style=Google %s",
                            file
                        )
                    end
                }
            }
        },
        cpp = {
            {
                cmd = {
                    function(file)
                        return string.format(
                            "clang-format -i -style=Google %s",
                            file
                        )
                    end
                }
            }
        },
        tex = {
            {
                cmd = {
                    function(file)
                        return string.format(
                            "latexindent -c /home/jczhang/.texcrufts/ -w -d %s",
                            file
                        )
                    end
                }
            }
        },
        bib = {
            {
                cmd = {
                    function(file)
                        return string.format(
                            "latexindent -c /home/jczhang/.texcrufts/ -w -d %s",
                            file
                        )
                    end
                }
            }
        },
        go = {
            {
                cmd = {"gofmt -w", "goimports -w"},
                tempfile_postfix = ".tmp"
            }
        },
        python = {
            {
                cmd = {
                    "autopep8 --in-place --aggressive --aggressive"
                }
            }
        },
        sh = {
            {
                cmd = {
                    function(file)
                        return string.format("shfmt -w %s", file)
                    end
                }
            }
        },
        rust = {
            {
                cmd = {
                    function(file)
                        return string.format("rustfmt %s", file)
                    end
                }
            }
        },
        html = {
            {cmd = {"prettier -w"}}
        },
        javascript = {
            {cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}
        },
        json = {
            {cmd = {"prettier -w"}}
        },
        markdown = {
            {cmd = {"prettier -w"}},
            {
                cmd = {"black"},
                start_pattern = "^```python$",
                end_pattern = "^```$",
                target = "current"
            }
        }
    }
end

function config.auto_session()
    local opts = {
        log_level = "info",
        auto_session_enable_last_session = true,
        auto_session_root_dir = sessions_dir,
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_suppress_dirs = nil
    }

    require("auto-session").setup(opts)
end

function config.toggleterm()
    require("toggleterm").setup {
        -- size can be a number or function which is passed the current terminal
        size = function(term)
            if term.direction == "horizontal" then
                return 20
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.40
            end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = false,
        shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = "vertical",
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell -- change the default shell
    }
end

function config.dapui()
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    require("dapui").setup(
        {
            icons = {expanded = "▾", collapsed = "▸"},
            mappings = {
                -- Use a table to apply multiple mappings
                expand = {"<CR>", "<2-LeftMouse>"},
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r"
            },
            sidebar = {
                elements = {
                    -- Provide as ID strings or tables with "id" and "size" keys
                    {
                        id = "scopes",
                        size = 0.25 -- Can be float or integer > 1
                    },
                    {id = "breakpoints", size = 0.25},
                    {id = "stacks", size = 0.25},
                    {id = "watches", size = 00.25}
                },
                size = 40,
                position = "left"
            },
            tray = {
                elements = {"repl"},
                size = 10,
                position = "bottom"
            },
            floating = {
                max_height = nil,
                max_width = nil,
                mappings = {close = {"q", "<Esc>"}}
            },
            windows = {indent = 1}
        }
    )
end

function config.dap()
    local dap = require("dap")

    dap.adapters.go = function(callback, config)
        local stdout = vim.loop.new_pipe(false)
        local handle
        local pid_or_err
        local port = 38697
        local opts = {
            stdio = {nil, stdout},
            args = {"dap", "-l", "127.0.0.1:" .. port},
            detached = true
        }
        handle, pid_or_err =
            vim.loop.spawn(
            "dlv",
            opts,
            function(code)
                stdout:close()
                handle:close()
                if code ~= 0 then
                    print("dlv exited with code", code)
                end
            end
        )
        assert(handle, "Error running dlv: " .. tostring(pid_or_err))
        stdout:read_start(
            function(err, chunk)
                assert(not err, err)
                if chunk then
                    vim.schedule(
                        function()
                            require("dap.repl").append(chunk)
                        end
                    )
                end
            end
        )
        -- Wait for delve to start
        vim.defer_fn(
            function()
                callback({type = "server", host = "127.0.0.1", port = port})
            end,
            100
        )
    end
    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.configurations.go = {
        {type = "go", name = "Debug", request = "launch", program = "${file}"},
        {
            type = "go",
            name = "Debug test", -- configuration for debugging test files
            request = "launch",
            mode = "test",
            program = "${file}"
        }, -- works with go.mod packages and sub packages
        {
            type = "go",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}"
        }
    }

    dap.adapters.python = {
        type = "executable",
        command = os.getenv("HOME") ..
            "/.local/share/nvim/dapinstall/python_dbg/bin/python",
        args = {"-m", "debugpy.adapter"}
    }
    dap.configurations.python = {
        {
            -- The first three options are required by nvim-dap
            type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = "launch",
            name = "Launch file",
            -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

            program = "${file}", -- This configuration will launch the current file if used.
            pythonPath = function()
                -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                local cwd = vim.fn.getcwd()
                if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                    return cwd .. "/venv/bin/python"
                elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                    return cwd .. "/.venv/bin/python"
                else
                    return "/usr/bin/python"
                end
            end
        }
    }
end

function config.dapinstal()
    require("dap-install").setup(
        {
            installation_path = dap_dir,
            verbosely_call_debuggers = false
        }
    )
end

function config.gentags()
    vim.g.gutentags_generate_on_new = 1
    vim.g.gutentags_generate_on_write = 1
    vim.g.gutentags_generate_on_missing = 1
    vim.g.gutentags_generate_on_empty_buffer = 0
end

function config.specs()
    require("specs").setup {
        show_jumps = true,
        min_jump = 10,
        popup = {
            delay_ms = 0, -- delay before popup displays
            inc_ms = 10, -- time increments used for fade/resize effects
            blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
            width = 10,
            winhl = "PMenu",
            fader = require("specs").pulse_fader,
            resizer = require("specs").shrink_resizer
        },
        ignore_filetypes = {},
        ignore_buftypes = {nofile = true}
    }
end

return config
