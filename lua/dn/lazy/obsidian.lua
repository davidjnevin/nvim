return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	-- ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		"BufReadPre " ..
		vim.fn.expand "~" ..
		"/Library/CloudStorage/GoogleDrive-nevin.david@gmail.com/My Drive/ObsidianVault/SecondBrain/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("obsidian").setup({
				workspaces = {
					{
						name = "SecondBrain",
						path =
						"~/Library/CloudStorage/GoogleDrive-nevin.david@gmail.com/My Drive/ObsidianVault/SecondBrain",
					},
				},
				completion = {
					-- Set to false to disable completion.
					nvim_cmp = true,
					-- Trigger completion at 2 chars.
					min_chars = 2,
				},
				-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
				-- way then set 'mappings = {}'.
				mappings = {
					-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
					["gf"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
					-- Toggle check-boxes.
					["<leader>ch"] = {
						action = function()
							return require("obsidian").util.toggle_checkbox()
						end,
						opts = { buffer = true },
					},
					-- Smart action depending on context, either follow link or toggle checkbox.
					["<cr>"] = {
						action = function()
							return require("obsidian").util.smart_action()
						end,
						opts = { buffer = true, expr = true },
					}
				},
		})
	end
}
