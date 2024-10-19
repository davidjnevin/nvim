return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    event = {
        "BufReadPre " ..
        vim.fn.expand "~" ..
        "/Documnets/SecondBrain/**.md"
    },
    config = function()
        require("obsidian").setup({
            workspaces = {
                {
                    name = "SecondBrain",
                    path = "~/Documents/SecondBrain",
                },
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
            disable_frontmatter = true,
            attachments = {
                img_folder = "assets/imgs",
            },
            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },
            wiki_link_func = "use_alias_only",
            follow_url_func = function(url)
                vim.fn.jobstart({ "xdg-open", url })     -- linux
            end,
        })
    end
}
