-- Essentials
vim.g.mapleader = " "
vim.g.loaded_python_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0


-- vim.g.python3_host_skip_check = 0
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.pyxversion = 3
vim.g.bulitin_lsp = true

vim.g.pydocstring_doq_path = "/usr/bin/python3"
-- Behaviors
vim.opt.belloff = "all"                                    -- NO BELLS!
vim.opt.completeopt = { "menuone", "noselect" }            -- ins-completion how I like it
vim.opt.swapfile = false                                   -- no swap files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true                                    -- keep track of my 'undo's between sessions
vim.opt.backup = false                                     -- no backups
vim.opt.inccommand = "nosplit"                             -- preview %s commands live as I type
vim.opt.grepprg = "rg --vimgrep --smart-case --no-heading" -- search with rg
vim.opt.grepformat = "%f:%l:%c:%m"                         -- filename:line number:column number:error message
vim.opt.mouse = "nv"                                       -- use mouse in normal, visual modes
vim.opt.mousescroll = "ver:3,hor:0"                        -- scroll vertically by 3 lines, no horizontal scrolling

-- Indentation
vim.opt.autoindent = false  -- continue indentation to new line
vim.opt.smartindent = false -- add extra indent when it makes sense
vim.opt.smarttab = true    -- <Tab> at the start of a line behaves as expected
vim.opt.expandtab = true    -- <Tab> inserts spaces
vim.opt.shiftwidth = 4      -- >>, << shift line by 4 spaces
vim.opt.tabstop = 4         -- <Tab> appears as 4 spaces
vim.opt.softtabstop = 4     -- <Tab> behaves as 4 spaces when editing

-- Colors
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Look and feel
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes" -- show the sign column always
vim.opt.list = false       -- show list chars
vim.opt.listchars = {
	-- these list chars
	tab = "<->",
	nbsp = "␣",
	extends = "…",
	precedes = "…",
	trail = "·",
	multispace = "·",       -- show chars if I have multiple spaces between text
	leadmultispace = " ",   -- ...but don't show any when they're at the start
}
vim.opt.scrolloff = 10      -- padding between cursor and top/bottom of window
vim.opt.sidescrolloff = 10  -- padding between cursor and left/right of window
vim.opt.foldlevel = 0       -- allow folding the whole way down
vim.opt.foldlevelstart = 99 -- open files with all folds open
vim.opt.splitright = true   -- prefer vsplitting to the right
vim.opt.splitbelow = true   -- prefer splitting below
vim.opt.wrap = false        -- don't wrap my text
vim.opt.cursorline = true   -- hightlight line cursor is on
vim.opt.laststatus = 3      -- single global statusline

-- Searching
vim.opt.wildmenu = true   -- tab complete on command line
vim.opt.ignorecase = true -- case insensitive search...
vim.opt.smartcase = true  -- unless I use caps
vim.opt.hlsearch = true   -- highlight matching text
vim.opt.incsearch = true  -- update results while I type

-- Cmake
vim.g.cmake_root_markers = { 'CMakeLists.txt' }
vim.g.cmake_link_compile_commands = 1

-- GTest
vim.g.gtest_command = "./tests"
