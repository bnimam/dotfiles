vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

-- load plugins
require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
    },

    { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("options")
require("autocmds")

vim.schedule(function()
    require("mappings")
end)

-- remove line numbers in terminal emulator
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
        -- Ignore space as leader key in terminal mode
        vim.keymap.set("t", "<Space>", "<Space>", { buffer = true, nowait = true })
    end,
})

-- Esc exits terminal mode, then you can use normal Ctrl+W movements
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", nowait = true })

require("configs.float-term")

-- Better mouse scrolling
vim.api.nvim_set_keymap("n", "<ScrollWheelUp>", "<C-y>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<ScrollWheelDown>", "<C-e>", { noremap = true, silent = true })

-- Highlight other occurences of word on cursor
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.document_highlight()
                end,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.clear_references()
                end,
            })
        end
    end,
})

-- Adds line moving / swapping like in vscode
-- Move line up and down (Normal mode)
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

-- Move selection up and down (Visual mode)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
