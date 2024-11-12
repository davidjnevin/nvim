return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        require("ibl").setup {}
        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.ACTIVE, function(bufnr)
            return vim.tbl_contains(
                { "html", "yaml", "svelte", "python", "java", "cpp" },
                vim.api.nvim_get_option_value("filetype", { buf = bufnr })
            )
        end)
    end,
}
