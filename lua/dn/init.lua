-- Settings
require("dn.settings")
-- Keymaps
require("dn.mappings")

-- Lazy Plugin Budler
require("dn.lazy_init")

-- require("dn.lazy.toggleterm").setup {}


local augroup = vim.api.nvim_create_augroup
local DnGroup = augroup('dn', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = 'templ',
	}
})

autocmd('TextYankPost', {
	group = yank_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = DnGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
	group = DnGroup,
	callback = function(e)
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { buffer = e.buf, desc = "Go to definition" })
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = e.buf, desc = "Show documentation" })
		vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end,
			{ buffer = e.buf, desc = "Lists all symbol" })
		vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end,
			{ buffer = e.buf, desc = "Show contents in floating window" })
		vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end,
			{ buffer = e.buf, desc = "Show code actions" })
		vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end,
			{ buffer = e.buf, desc = "Show references" })
		vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end,
			{ buffer = e.buf, desc = "Rename reference" })
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
			{ buffer = e.buf, desc = "Signature help" })
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end,
			{ buffer = e.buf, desc = "Go to next diagnostic" })
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end,
			{ buffer = e.buf, desc = "Go to prev diagnostic" })
	end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25
