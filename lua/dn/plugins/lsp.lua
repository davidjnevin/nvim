return {
	"neovim/nvim-lspconfig",
	config = function()
		require "dn.lsp_config"
	end,
	dependencies = {
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",

		-- typescript helpers
		{
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			ft = {
				"typescript",
				"html",
				"vue",
				"javascript",
			},
		},
	},
}
