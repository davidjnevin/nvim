return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		-- fzf filtering for telescope
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-ui-select.nvim", -- Use telescope to override vim.ui.select
		"nvim-telescope/telescope-dap.nvim",   -- Use telescope for debugging
		"nvim-telescope/telescope-file-browser.nvim",
	},
	config = function()
		local telescope = require "telescope"
		telescope.setup {
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--vimgrep",
				},
				file_ignore_patterns = {
					"%.png",
				},
				prompt_prefix = "» ",
				selection_caret = " ",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				path_display = { "smart" },
				dynamic_preview_title = true,
				border = true,
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = false,
				set_env = {
					["COLORTERM"] = "truecolor",
				},
				layout_config = {
					prompt_position = "top",
					height = 0.8,
				},
			},
			pickers = {
				buffers = {
					sort_mru = true,
					ignore_current_buffer = true,
					mappings = {
						i = {
							["<c-d>"] = "delete_buffer", -- this overrides the built in preview scroller
							["<c-s>"] = "preview_scrolling_down",
						},
						n = {
							["<c-d>"] = "delete_buffer", -- this overrides the built in preview scroller
							["<c-s>"] = "preview_scrolling_down",
						},
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,         -- let me make typos in file names please
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
				["ui-select"] = {
					require("telescope.themes").get_cursor(),
				},
			},
		}

		telescope.load_extension "fzf"
		telescope.load_extension "dap"
		telescope.load_extension "ui-select"
		telescope.load_extension "file_browser"
	end,
	keys = {
		{
			"<Leader>fg",
			"<cmd>Telescope git_files<CR>",
			desc = "Find files",
		},
		{
			"<Leader>ff",
			"<cmd>Telescope find_files<CR>",
			desc = "Find files",
		},
		{
			"<Leader>fb",
			"<cmd>Telescope buffers<CR>",
			desc = "Switch buffer",
		},
		{
			"<Leader>fl",
			"<cmd>Telescope current_buffer_fuzzy_find<CR>",
			desc = "Find in file",
		},
		{
			"<Leader>ft",
			"<cmd>Telescope file_browser<CR>",
			desc = "File Browser Tree",
		},
		{
			"<Leader>gg",
			"<cmd>Telescope live_grep<CR>",
			desc = "Grep",
		},
		{
			"<Leader>fr",
			"<cmd>Telescope lsp_references<CR>",
			desc = "Find references",
		},
		{
			"<Leader>co",
			"<cmd>Telescope colorscheme<CR>",
			desc = "Switch colorscheme",
		},
		{
			"<Leader>gc",
			"<cmd>Telescope git_branches<CR>",
			desc = "Checkout branches",
		},
		{
			"<Leader>re",
			"<cmd>Telescope git_commits<CR>",
			desc = "Checkout commits",
		},
		{
			"<Leader>qf",
			function()
				require("telescope.builtin").quickfilx(require("telescope.themes").get_ivy())
			end,
			desc = "Jump to items in quickfix list",
		},
		{
			"<Leader>pws",
			function()
				local word = vim.fn.expand("<cword>")
				require("telescope.builtin").grep_string({ search = word })
			end,
			desc = "Grep word under cursor",
		},
		{
			"<Leader>pWs",
			function()
				local word = vim.fn.expand("<cWORD>")
				require("telescope.builtin").grep_string({ search = word })
			end,
			desc = "Grep WORD under cursor",
		},
	},
	cmd = {
		"Telescope",
	},
}
