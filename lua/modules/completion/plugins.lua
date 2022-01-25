local completion = {}
local conf = require("modules.completion.config")

completion["neovim/nvim-lspconfig"] = {
    opt = true,
    event = "BufReadPre",
    config = conf.nvim_lsp
}
completion["williamboman/nvim-lsp-installer"] = {
    opt = true,
    after = "nvim-lspconfig"
}
completion["tami5/lspsaga.nvim"] = {opt = true, after = "nvim-lspconfig"}
completion["kosayoda/nvim-lightbulb"] = {
    opt = true,
    after = "nvim-lspconfig",
    config = conf.lightbulb
}
completion["ray-x/lsp_signature.nvim"] = {opt = true, after = "nvim-lspconfig"}
completion["hrsh7th/nvim-cmp"] = {
    config = conf.cmp,
    event = "InsertEnter",
    requires = {
        {"lukas-reineke/cmp-under-comparator"},
        {"quangnguyen30192/cmp-nvim-ultisnips", after = "ultisnips"},
        {"hrsh7th/cmp-buffer", after = "cmp-nvim-ultisnips"},
        {"hrsh7th/cmp-nvim-lsp", after = "cmp-buffer"},
        {"hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp"},
        {"andersevenrud/cmp-tmux", after = "cmp-nvim-lua"},
        {"hrsh7th/cmp-path", after = "cmp-tmux"},
        {"f3fora/cmp-spell", after = "cmp-path"},
        --{"hrsh7th/cmp-copilot", after = "cmp-spell"}
        {
            'tzachar/cmp-tabnine',
            run = './install.sh',
            after = 'cmp-spell',
            config = conf.tabnine
        },
        -- {
        --     "uga-rosa/cmp-dictionary",
        --     after = "cmp-tabnine",
        --     config = conf.dictionary
        -- }
    }
}
completion["SirVer/ultisnips"] = {
    after = "nvim-cmp",
    config = conf.ultisnips,
    requires = "honza/vim-snippets"
}

completion['flaviusbuffon/jc-snippet'] = {
    opt = true,
    after = 'ultisnips',
}
completion["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = conf.autopairs
}
completion["github/copilot.vim"] = {opt = true, cmd = "Copilot"}

return completion
