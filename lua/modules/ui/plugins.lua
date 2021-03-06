local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = {opt = false}
ui["sainnhe/edge"] = {opt = false, config = conf.edge}
ui["hoob3rt/lualine.nvim"] = {
    opt = true,
    after = "lualine-lsp-progress",
    config = conf.lualine
}
ui["arkav/lualine-lsp-progress"] = {
    opt = true,
    after = "nvim-gps"
}
ui["glepnir/dashboard-nvim"] = {opt = true, event = "BufWinEnter"}
ui["kyazdani42/nvim-tree.lua"] = {
    opt = true,
    -- cmd = {"NvimTreeToggle", "NvimTreeOpen"},
    event = "BufRead",
    config = conf.nvim_tree
}
ui["lewis6991/gitsigns.nvim"] = {
    opt = true,
    event = {"BufRead", "BufNewFile"},
    config = conf.gitsigns,
    requires = {"nvim-lua/plenary.nvim", opt = true}
}
ui["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    event = "BufRead",
    config = conf.indent_blankline
}
ui["akinsho/nvim-bufferline.lua"] = {
    opt = true,
    event = "BufRead",
    config = conf.nvim_bufferline
}

ui["folke/tokyonight.nvim"] = {
    opt = false,
    config = conf.tokyonight
}

ui["catppuccin/nvim"] = {
    opt = false,
    as = "catppuccin",
    config = conf.catppuccin
}

ui["petertriho/nvim-scrollbar"] = {
    opt = true,
    event = "BufRead",
    config = function()
        require("scrollbar").setup()
    end
}

ui["wfxr/minimap.vim"] = {
    opt = true,
    event = "BufRead"
}

return ui
