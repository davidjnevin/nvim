-- Mapping helper
---@param mode string
---@param key string
---@param result function | string
local mapper = function(mode, key, result, description)
	if description == nil then
		description = "No keymap description"
	end
	vim.keymap.set(mode, key, result, { noremap = true, silent = true, desc = description })
end

-- Essentials
mapper("i", "jj", "<Esc>", "<Esc>")
mapper("n", "<c-c>", "<Esc>", "<Esc>")
mapper("n", "<Leader>no", ":nohl<CR>", "Disable higlighting")
mapper("n", "<BS>", "daw", "<Backspace>")
mapper("n", "<CR>", ":e<CR>", "Center scrolling")
mapper("n", "<Leader><Leader>", "<c-^>", "Jump to previous buffer")
mapper("n", ":W", ":w", "Write file")
mapper("n", "I", "0I", "Insert at beginning of line")

-- Movement
mapper("n", "<c-j>", "<c-w>j", "Switch to window below")
mapper("n", "<c-h>", "<c-w>h", "Switch to window to the left")
mapper("n", "<c-k>", "<c-w>k", "Switch to window above")
mapper("n", "<c-l>", "<c-w>l", "Switch to window to the right")

-- CMake
mapper('', '<leader>cg', ':CMakeGenerate<cr>', "CMake generate")
mapper('', '<leader>cb', ':CMakeBuild<cr>', "CMake build")
mapper('', '<leader>cq', ':CMakeClose<cr>', "CMake close")
mapper('', '<leader>cc', ':CMakeClean<cr>', "CMake clean")

-- Move without firing 'BufEnter' autocommands
-- mapper("n", "<M-j>", ":noautocmd wincmd j<CR>")
-- mapper("n", "<M-h>", ":noautocmd wincmd h<CR>")
-- mapper("n", "<M-k>", ":noautocmd wincmd k<CR>")
-- mapper("n", "<M-l>", ":noautocmd wincmd l<CR>")

-- Visual-mode commands
mapper("v", "<c-J>", ":MoveBlock(1)<CR>", "Move block down")
mapper("v", "<c-K>", ":MoveBlock(-1)<CR>", "Move block up")

-- Move lines
mapper("n", "<c-K>", ":MoveLine(-1)<CR>", "Move line up")
mapper("n", "<c-J>", ":MoveLine(1)<CR>", "Move line up")

-- Term
mapper("t", "<Esc><Esc>", [[<c-\><c-n>]], "Switch to window below")
mapper("t", "<c-j>", [[<c-\><c-n><c-w>j]], "Switch to window below")
mapper("t", "<c-h>", [[<c-\><c-n><c-w>h]], "Switch to window to the left")
mapper("t", "<c-k>", [[<c-\><c-n><c-w>k]], "Switch to window above")
mapper("t", "<c-l>", [[<c-\><c-n><c-w>l]], "Switch to window to the right")

-- Other basics
mapper("n", "<Down>", "<Nop>", "Disabled" )
mapper("n", "<Up>", "<Nop>", "Disabled")
mapper("n", "<c-e>", "3<c-e>", "Scroll down more quickly")
mapper("n", "<c-y>", "3<c-y>", "Scroll up more quickly")
mapper("n", "<Leader>bn", ":bn<CR>", "Next buffer")
mapper("n", "<Leader>bp", ":bp<CR>", "Prev buffer")
mapper("n", "<Leader>bd", ":bp | bd #<CR>","Delete the current buffer")
mapper("n", "<Leader>nn", ":set number!<CR>", "Toggle line numbers")
mapper("n", "<Leader>zw", ":call ToggleFocus()<CR>", "Toggle focus on current window")

-- terminal
mapper("n", "<Leader>tn", ":call termcmd#vert()<CR>", "Open new term in vertical split")
mapper("n", "<Leader>ts", ":call termcmd#horiz()<CR>", "Open new term in horizontal split")

mapper("n", "<Leader>rr", "<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>", "Start language servers")
-- Lazygit toggle
mapper("n", "<leader>lg", ":LazyGit<CR>", "Lazygit")

-- Test mapper
mapper("n", "<leader>Ts", ":TestSuite<cr>", "Test suite")
mapper("n", "<leader>Tl", ":TestLast<cr>", "Test last")
mapper("n", "<leader>Tf", ":TestFile<cr>", "Test file")
mapper("n", "<leader>Tn", ":TestNearest<cr>", "Test nearest")
mapper("n", "<leader>Tv", ":TestVisit<cr>", "Test visit")
mapper("n", "<leader>Ti", ":TestInfo<cr>", "Test infomation")

-- format buffer
mapper("n", "<leader>F", ":lua vim.lsp.buf.format()<cr>", "Format buffer using lsp")

-- Harpoon
mapper("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", "Harpoon add")
mapper("n", "<leader>hd", ":lua require('harpoon.mark').rm_file()<CR>", "Harpoon remove")
mapper("n", "<leader>hs", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", "Harpoon show menu")
mapper("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", "Harpoon goto 1")
mapper("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", "Harpoon goto 2")
mapper("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", "Harpoon goto 3")
mapper("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", "Harpoon goto 4")
-- mapper("n", "<leader><c-d>", ":lua require('harpoon.mark').clear_all()<CR>", "Harpoon clear all")
-- mapper("n", "<leader>tu", ":lua require('harpoon.term').gotoTerminal(1)<CR>")
-- mapper("n", "<leader>te", ":lua require('harpoon.term').gotoTerminal(2)<CR>")
-- mapper("n", "<leader>cu", ":lua require('harpoon.term').sendCommand(1, 1)<CR>")
