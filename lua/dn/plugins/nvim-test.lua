return {
	"klen/nvim-test",
	config = function()
		require("nvim-test").setup({
			run = true, -- run tests (using for debug)
			commands_create = true, -- create commands (TestFile, TestLast, ...)
			filename_modifier = ":.", -- modify filenames before tests run(:h filename-modifiers)
			silent = false, -- less notifications
			term = "terminal", -- a terminal to run ("terminal"|"toggleterm")
			termOpts = {
				direction = "vertical", -- terminal's direction ("horizontal"|"vertical"|"float")
				width = 96, -- terminal's width (for vertical|float)
				height = 24, -- terminal's height (for horizontal|float)
				go_back = false, -- return focus to original window after executing
				stopinsert = "auto", -- exit from insert mode (true|false|"auto")
				keep_one = true, -- keep only one terminal for testing
			},
			runners = { -- setup tests runners
				javascriptreact = "nvim-test.runners.jest",
				javascript = "nvim-test.runners.jest",
				lua = "nvim-test.runners.",
				python = "nvim-test.runners.pytest",
			},
		})
	end,
}
