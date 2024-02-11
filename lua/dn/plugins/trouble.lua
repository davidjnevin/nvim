return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup {
			icons = false,
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	end,
}
