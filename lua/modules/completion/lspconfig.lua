if not packer_plugins["nvim-lspconfig"].loaded then
    vim.cmd [[packadd nvim-lspconfig]]
end

if not packer_plugins["nvim-lsp-installer"].loaded then
    vim.cmd [[packadd nvim-lsp-installer]]
end

if not packer_plugins["lsp_signature.nvim"].loaded then
    vim.cmd [[packadd lsp_signature.nvim]]
end

if not packer_plugins["lspsaga.nvim"].loaded then
    vim.cmd [[packadd lspsaga.nvim]]
end

if not packer_plugins["cmp-nvim-lsp"].loaded then
    vim.cmd [[packadd cmp-nvim-lsp]]
end

vim.cmd([[packadd aerial.nvim]])

local nvim_lsp = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function custom_attach(client)
    require("lsp_signature").on_attach(
        {
            bind = true,
            use_lspsaga = false,
            floating_window = true,
            fix_pos = true,
            hint_enable = true,
            hi_parameter = "Search",
            handler_opts = {"double"}
        }
    )
    require("aerial").on_attach(client)
end

vim.lsp.handlers["textDocument/formatting"] = function(err, result, ctx)
    if err ~= nil or result == nil then
        return
    end
    if
        vim.api.nvim_buf_get_var(ctx.bufnr, "init_changedtick") ==
            vim.api.nvim_buf_get_var(ctx.bufnr, "changedtick")
     then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, ctx.bufnr, "utf-8")
        vim.fn.winrestview(view)
        if ctx.bufnr == vim.api.nvim_get_current_buf() then
            vim.b.saving_format = true
            vim.cmd [[update]]
            vim.b.saving_format = false
        end
    end
end

local function switch_source_header_splitcmd(bufnr, splitcmd)
    bufnr = nvim_lsp.util.validate_bufnr(bufnr)
    local params = {uri = vim.uri_from_bufnr(bufnr)}
    vim.lsp.buf_request(
        bufnr,
        "textDocument/switchSourceHeader",
        params,
        function(err, result)
            if err then
                error(tostring(err))
            end
            if not result then
                print("Corresponding file can’t be determined")
                return
            end
            vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
        end
    )
end

lsp_installer.on_server_ready(
    function(server)
        local opts = {}

        if (server.name == "sumneko_lua") then
            opts.settings = {
                Lua = {
                    diagnostics = {globals = {"vim", "packer_plugins"}},
                    workspace = {
                        library = {
                            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000
                    },
                    telemetry = {enable = false}
                }
            }
        elseif (server.name == "clangd") then
            opts.args = {"--background-index", "-std=c++20"}
            opts.commands = {
                ClangdSwitchSourceHeader = {
                    function()
                        switch_source_header_splitcmd(0, "edit")
                    end,
                    description = "Open source/header in current buffer"
                },
                ClangdSwitchSourceHeaderVSplit = {
                    function()
                        switch_source_header_splitcmd(0, "vsplit")
                    end,
                    description = "Open source/header in a new vsplit"
                },
                ClangdSwitchSourceHeaderSplit = {
                    function()
                        switch_source_header_splitcmd(0, "split")
                    end,
                    description = "Open source/header in a new split"
                }
            }
        end
        opts.capabilities = capabilities
        opts.flags = {debounce_text_changes = 500}
        opts.on_attach = custom_attach

        server:setup(opts)
    end
)

nvim_lsp.html.setup {
    cmd = {"html-languageserver", "--stdio"},
    filetypes = {"html"},
    init_options = {
        configurationSection = {"html", "css", "javascript"},
        embeddedLanguages = {css = true, javascript = true}
    },
    settings = {},
    single_file_support = true,
    flags = {debounce_text_changes = 500},
    capabilities = capabilities,
    on_attach = custom_attach
}
