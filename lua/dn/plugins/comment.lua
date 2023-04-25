return {

	-- commenting Just Works
	{
		"numToStr/Comment.nvim",
		config = function()
			require('Comment').setup({
				ignore = '^$',
			})
		end
	}
}
