local augroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

local exit_if_last = function()
    if vim.fn.winnr "$" == 1 then
        vim.cmd "q"
    end
end

-- Global formatopts
au("BufEnter", {
    pattern = "*",
    callback = function()
        local buftype = vim.opt.buftype:get()
        if buftype ~= "terminal" then
            vim.opt.formatoptions = "lcrqjn"
        end
    end,
})

local term_group = augroup("term", { clear = false })
au("TermOpen", {
    group = term_group,
    pattern = "*",
    callback = function()
        vim.cmd "startinsert"
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.cursorline = false
        vim.opt_local.signcolumn = "no"
    end,
})

au("BufEnter", {
    group = term_group,
    pattern = "*",
    callback = function()
        local buftype = vim.opt.buftype:get()
        if buftype == "terminal" then
            -- quit if the terminal is the last buffer open
            exit_if_last()
            -- enter insert mode automatically when entering terminal
            vim.cmd "startinsert"
        end
    end,
})

local gitcommit_group = augroup("gitcommit", { clear = true })
au("FileType", {
    group = gitcommit_group,
    pattern = "gitcommit",
    callback = function()
        vim.cmd "let b:EditorConfig_disable = 1"
        vim.opt_local.formatoptions = "tcrnqj"
    end,
})

au("BufEnter", {
    pattern = "CMakelists.txt",
    callback = function()
        vim.opt_local.filetype = "cmake"
    end,
})

au("BufEnter", {
    pattern = "Dockerfile.*",
    callback = function()
        vim.opt_local.filetype = "Dockerfile"
    end,
})

au("BufEnter", {
    pattern = "*.py",
    callback = function()
        vim.opt_local.filetype = "python"
    end,
})

au("BufEnter", {
    pattern = "*.yaml, *.yml",
    callback = function()
        vim.opt_local.filetype = "yaml"
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
        vim.opt_local.autoindent = true
    end,
})

au("BufEnter", {
    pattern = "*.toml",
    callback = function()
        vim.opt_local.filetype = "toml"
    end,
})

au("BufEnter", {
    pattern = "*.tmTheme",
    callback = function()
        vim.opt_local.filetype = "tmTheme"
    end,
})

local nvim_tree_group = augroup("NvimTree", { clear = true })
au("FileType", {
    group = nvim_tree_group,
    pattern = "NvimTree",
    callback = function()
        exit_if_last()
        vim.opt_local.cursorline = true
    end,
})

-- Enable treesitter powered indent for vue files only
au("FileType", {
    pattern = "vue",
    command = "TSBufEnable indent",
})

au("FileType", {
    pattern = "qf",
    command = "set number",
})

-- Enable conceallevel = 1 for markdown
au("BufEnter", {
    pattern = "*.md",
    callback = function()
        vim.opt_local.conceallevel = 1
    end
})

-- Enable tab convert to spaces for python
au("FileType", {
    pattern = "python",
    command = "set expandtab tabstop=4 shiftwidth=4",
})

-- EZ rebase keybinds
au("FileType", {
    pattern = "gitrebase",
    callback = function()
        for _, key in ipairs { "p", "r", "e", "s", "f", "d", "x", "b", "l", "r", "t", "m" } do
            vim.keymap.set("n", key, "ciw" .. key .. "<Esc>",
                { noremap = true, silent = true, buffer = true, desc = "Git rebase" })
        end
    end,
})

-- Debugger repl autocomplete
au("FileType", {
    pattern = "dap-repl",
    callback = function()
        require("dap.ext.autocompl").attach()
    end,
})
