-- Floating terminal with tab support
local state = {
    wins = {},
    idx = 0,
    float = nil,
}

local function float_opts()
    local W = math.floor(vim.o.columns * 0.85)
    local H = math.floor(vim.o.lines * 0.80)
    return {
        relative = "editor",
        width = W,
        height = H,
        col = math.floor((vim.o.columns - W) / 2),
        row = math.floor((vim.o.lines - H) / 2),
        style = "minimal",
        border = "rounded",
    }
end

local function set_tab_title()
    if #state.wins == 0 or not (state.float and vim.api.nvim_win_is_valid(state.float)) then
        return
    end
    local tabs = {}
    for i in ipairs(state.wins) do
        table.insert(tabs, i == state.idx and ("[" .. i .. "]") or tostring(i))
    end
    vim.api.nvim_win_set_config(state.float, {
        title = " Term  " .. table.concat(tabs, "  ") .. " ",
        title_pos = "center",
    })
end

local function close_float()
    if state.float and vim.api.nvim_win_is_valid(state.float) then
        vim.api.nvim_win_close(state.float, false)
    end
    state.float = nil
end

local function cycle_tab(dir)
    if #state.wins < 2 then
        return
    end
    state.idx = ((state.idx - 1 + dir) % #state.wins) + 1
    if state.float and vim.api.nvim_win_is_valid(state.float) then
        vim.api.nvim_win_set_buf(state.float, state.wins[state.idx])
        set_tab_title()
        vim.cmd("startinsert")
    end
end

local create_term_buf
local spawn_shell

local function on_term_close(buf)
    for i, b in ipairs(state.wins) do
        if b == buf then
            table.remove(state.wins, i)
            if state.idx > #state.wins then
                state.idx = math.max(1, #state.wins)
            end
            break
        end
    end

    vim.schedule(function()
        if #state.wins == 0 then
            close_float()
            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        else
            if state.float and vim.api.nvim_win_is_valid(state.float) then
                vim.api.nvim_win_set_buf(state.float, state.wins[state.idx])
                if vim.api.nvim_buf_is_valid(buf) then
                    vim.api.nvim_buf_delete(buf, { force = true })
                end
                set_tab_title()
                vim.cmd("startinsert")
            end
        end
    end)
end

local function line_is_empty()
    local line = vim.api.nvim_get_current_line()
    return line:match("[%$%%>#❯]%s*$") ~= nil or line:match("^%s*$") ~= nil
end

local function attach_keymaps(buf)
    local opts = { buffer = buf, nowait = true, silent = true }

    vim.keymap.set("n", "q", close_float, opts)
    vim.keymap.set({ "t", "n" }, "<S-Tab>", function()
        cycle_tab(-1)
    end, opts)

    vim.keymap.set("n", "<Tab>", function()
        cycle_tab(1)
    end, opts)

    vim.keymap.set("t", "<Tab>", function()
        if line_is_empty() then
            cycle_tab(1)
        else
            local chan = vim.b.terminal_job_id
            if chan then
                vim.api.nvim_chan_send(chan, "\t")
            end
        end
    end, opts)
end

create_term_buf = function()
    local buf = vim.api.nvim_create_buf(false, true)
    table.insert(state.wins, buf)
    state.idx = #state.wins
    attach_keymaps(buf)
    return buf
end

spawn_shell = function(buf)
    vim.fn.termopen(vim.o.shell, {
        on_exit = function()
            on_term_close(buf)
        end,
    })
end

local function open_float(buf)
    local win = vim.api.nvim_open_win(buf, true, float_opts())
    vim.wo[win].number = false
    vim.wo[win].relativenumber = false
    vim.wo[win].signcolumn = "no"
    state.float = win
    set_tab_title()
    vim.cmd("startinsert")
end

-- <leader>tt — open / re-open the floating terminal
vim.keymap.set("n", "<leader>tt", function()
    if state.float and vim.api.nvim_win_is_valid(state.float) then
        vim.api.nvim_set_current_win(state.float)
        vim.cmd("startinsert")
        return
    end

    if #state.wins == 0 then
        local buf = create_term_buf()
        open_float(buf)
        spawn_shell(buf)
    else
        open_float(state.wins[state.idx])
    end
end, { desc = "Open floating terminal" })

-- <leader>tn — new terminal tab inside the float
vim.keymap.set({ "n", "t" }, "<leader>tn", function()
    if not (state.float and vim.api.nvim_win_is_valid(state.float)) then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<leader>tt", true, false, true), "n", false)
        return
    end
    local buf = create_term_buf()
    vim.api.nvim_win_set_buf(state.float, buf)
    set_tab_title()
    spawn_shell(buf)
    vim.cmd("startinsert")
end, { desc = "New terminal tab" })
