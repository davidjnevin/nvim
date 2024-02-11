return {
	-- utility functions
	"nvim-lua/plenary.nvim",

	"tpope/vim-surround",
	"tpope/vim-repeat",
	-- highlight color codes
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup(nil, { css = true })
		end,
	},
	-- .editorconfig support
	{
		"editorconfig/editorconfig-vim",
		init = function()
			vim.g.EditorConfig_exclude_patterns = { "fugitive://.*" }
		end,
	},
	-- convert quotes to template string quotes automatically
	{
		"axelvc/template-string.nvim",
		config = true,
		ft = {
			"typescript",
			"vue",
			"javascript",
		},
	},
	-- align text
	{ "godlygeek/tabular", cmd = "Tab" },
	-- json schema provider
	"b0o/schemastore.nvim",
	-- Reuired for docstrings
	"heavenshell/vim-pydocstring",
}
