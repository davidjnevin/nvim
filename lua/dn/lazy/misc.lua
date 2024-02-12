return {
	-- utility functions
	"tpope/vim-surround",
	"tpope/vim-repeat",
	-- highlight color codes
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup(nil, { css = true })
		end,
	},
	-- align text
	{ "godlygeek/tabular", cmd = "Tab" },
	-- json schema provider
	"b0o/schemastore.nvim",
	-- Reuired for docstrings
	"heavenshell/vim-pydocstring",
}
