return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require("configs.conform"),
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("configs.lspconfig")
        end,
    },

    -- test new blink
    { import = "nvchad.blink.lazyspec" },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("configs.treesitter")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },

    {
        "saghen/blink.cmp",
        lazy = false,
        opts = {
            completion = {
                list = {
                    selection = { preselect = false },
                },
            },
        },
    },

    {
        "lalitmee/cobalt2.nvim",
        event = { "ColorSchemePre" }, -- if you want to lazy load
        dependencies = { "tjdevries/colorbuddy.nvim", tag = "v1.0.0" },
        init = function()
            require("colorbuddy").colorscheme("cobalt2")
        end,
    },
}
