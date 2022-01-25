local config = {}

function config.nvim_lsp()
    require("modules.completion.lspconfig")
end

function config.lightbulb()
    vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
end

function config.cmp()
    local press = function(key)
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes(key, true, true, true),
            "n",
            true
        )
    end
    local has_any_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
            return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
            vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match(
                "%s"
            ) == nil
    end

    local cmp = require("cmp")
    cmp.setup {
        sorting = {
            comparators = {
                cmp.config.compare.offset, cmp.config.compare.exact,
                cmp.config.compare.score, require("cmp-under-comparator").under,
                cmp.config.compare.kind, cmp.config.compare.sort_text,
                cmp.config.compare.length, cmp.config.compare.order
            }
        },
        formatting = {
            format = function(entry, vim_item)
                local lspkind_icons = {
                    Text = "",
                    Method = "",
                    Function = "",
                    Constructor = "",
                    Field = "ﰠ",
                    Variable = "",
                    Class = "ﴯ",
                    Interface = "",
                    Module = "",
                    Property = "ﰠ",
                    Unit = "塞",
                    Value = "",
                    Enum = "",
                    Keyword = "",
                    Snippet = "",
                    Color = "",
                    File = "",
                    Reference = "",
                    Folder = "",
                    EnumMember = "",
                    Constant = "",
                    Struct = "פּ",
                    Event = "",
                    Operator = "",
                    TypeParameter = ""
                }
                -- load lspkind icons
                vim_item.kind =
                    string.format(
                    "%s %s",
                    lspkind_icons[vim_item.kind],
                    vim_item.kind
                )

                vim_item.menu =
                ({
                    cmp_tabnine = "[TN]",
                    orgmode = "[ORG]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[LUA]",
                    buffer = "[BUF]",
                    path = "[PATH]",
                    tmux = "[TMUX]",
                    ultisnips = "[USP]",
                    spell = "[SPELL]",
                    -- copilot = "[CPT]",
                    dictionary = "[DIC]",
                })[entry.source.name]

                return vim_item
            end
        },
        -- You can set mappings if you want
        mapping = {
			['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
			['<C-q>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close()
			}),
			['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),
			["<Tab>"] = cmp.mapping({
				i = function(fallback)
					if cmp.get_selected_entry() == nil and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
						press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
					elseif cmp.visible() then
						cmp.select_next_item()
					elseif has_any_words_before() then
						press("<Tab>")
					else
						fallback()
					end
				end,
				s = function(fallback)
					if cmp.get_selected_entry() == nil and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
						press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
					elseif has_any_words_before() then
						press("<Tab>")
					else
						fallback()
					end
				end
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, {'i', 's'}),
            ["<C-h>"] = cmp.mapping(
                function(fallback)
                    if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                        press("<ESC>:call UltiSnips#JumpBackwards()<CR>")
                    else
                        fallback()
                    end
                end,
                {"i", "s"}
            ),
            ["<C-l>"] = cmp.mapping(
                function(fallback)
                    if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                        press("<ESC>:call UltiSnips#JumpForwards()<CR>")
                    else
                        fallback()
                    end
                end,
                {"i", "s"}
            )
		},

        -- mapping = {
        --     ["<CR>"] = cmp.mapping.confirm({select = true}),
        --     ["<C-p>"] = cmp.mapping.select_prev_item(),
        --     ["<C-n>"] = cmp.mapping.select_next_item(),
        --     ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        --     ["<C-f>"] = cmp.mapping.scroll_docs(4),
        --     ["<C-e>"] = cmp.mapping.close(),
        --     ["<C-Space>"] = cmp.mapping(
        --         function(fallback)
        --             if cmp.visible() then
        --                 if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
        --                     return press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
        --                 end
        --                 cmp.select_next_item()
        --             elseif has_any_words_before() then
        --                 press("<Space>")
        --             else
        --                 fallback()
        --             end
        --         end,
        --         {"i", "s"}
        --     ),
        --     ["<Tab>"] = cmp.mapping(
        --         function(fallback)
        --             if cmp.visible() then
        --                 cmp.select_next_item()
        --             elseif has_any_words_before() then
        --                 press("<Tab>")
        --             else
        --                 fallback()
        --             end
        --         end,
        --         {"i", "s"}
        --     ),
        --     ["<S-Tab>"] = cmp.mapping(
        --         function(fallback)
        --             if cmp.visible() then
        --                 cmp.select_prev_item()
        --             else
        --                 fallback()
        --             end
        --         end,
        --         {"i", "s"}
        --     ),
        --     ["<C-h>"] = cmp.mapping(
        --         function(fallback)
        --             if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        --                 press("<ESC>:call UltiSnips#JumpBackwards()<CR>")
        --             else
        --                 fallback()
        --             end
        --         end,
        --         {"i", "s"}
        --     ),
        --     ["<C-l>"] = cmp.mapping(
        --         function(fallback)
        --             if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        --                 press("<ESC>:call UltiSnips#JumpForwards()<CR>")
        --             else
        --                 fallback()
        --             end
        --         end,
        --         {"i", "s"}
        --     )
        -- },
        snippet = {
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body)
            end
        },
        -- You should specify your *installed* sources.
        sources = {
            {name = "nvim_lsp"},
            {name = "nvim_lua"},
            {name = "ultisnips"},
            {name = "buffer"},
            {name = "path"},
            {name = "spell"},
            {name = "tmux"},
            {name = "orgmode"},
            -- {name = "copilot"},
            {name = 'cmp_tabnine'},
            -- {
            --     name = 'dictionary',
            --     max_item_count = 3,
            --     keyword_length = 2,
            -- }
        }
    }
end

function config.ultisnips()
	vim.g.UltiSnipsRemoveSelectModeMappings = 0
	vim.g.UltiSnipsEditSplit = 'vertical'
    vim.g.UltiSnipsJumpForwardTrigger = "<C-l>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<C-h>"
end

-- function config.luasnip()
--     require("luasnip").config.set_config {
--         history = true,
--         updateevents = "TextChanged,TextChangedI"
--     }
--     require("luasnip/loaders/from_vscode").load()
-- end

function config.tabnine()
    local tabnine = require('cmp_tabnine.config')
    tabnine:setup({max_line = 1000, max_num_results = 20, sort = true})
end

function config.autopairs()
    require("nvim-autopairs").setup {fast_wrap = {}}

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({map_char = {tex = ""}})
    )
end
--
-- function config.dictionary()
--     vim.opt.dictionary:append("/usr/share/dict/words")
-- end

return config
