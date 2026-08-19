require("nvchad.autocmds")

-- Pass <Esc> through to lazygit instead of leaving terminal mode.
-- Use <C-x> (NvChad default) if you need normal mode in the lazygit buffer.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lazygit",
    callback = function(args)
        vim.keymap.set("t", "<Esc>", "<Esc>", {
            buffer = args.buf,
            nowait = true,
            silent = true,
            desc = "lazygit: send <Esc> to terminal",
        })
    end,
})
