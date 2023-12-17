local IS_WIDE = function() return vim.o.columns > 150 end

local IS_START = function() return vim.opt.filetype:get() == "alpha" end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
		"stevearc/aerial.nvim",
	},
	opts = {
		sections = {
			--+-------------------------------------------------+--
			--| A | B | C                             X | Y | Z |--
			--+-------------------------------------------------+--
			lualine_a = {
				{
					"mode",
					fmt = function(str) return str:sub(1, 1) end
				}
			},
			-- fmt = function(m) return IS_WIDE() and m or m:sub(1, 1) end,
			-- cond = function() return not IS_START() end,
			lualine_b = { "branch" },
			lualine_c = {
				{
					"diff",
					symbols = {
						modified = "~",
						removed = "-",
						added = "+",
					},
				},
				-- add empty section to center filename
				{
					"%=",
					separator = "",
				},
				-- A hack to change the path type if the window gets too short. Lualine doesn't accept a function for the
				-- `path` option, so just swap out the entire component
				{
					"filename",
					file_status = true,
					newfile_status = true,
					path = 4, -- full file path
					color = { fg = "#ffffff", gui = "bold" },
					shorting_target = 30,
					symbols = {
						modified = '*',      -- Text to show when the file is modified.
						readonly = '-',      -- Text to show when the file is non-modifiable or readonly.
						-- unnamed = '[No Name]', -- Text to show for unnamed buffers.
						-- newfile = '[New]',     -- Text to show for newly created file before first write
					  }
				},
			},
			lualine_x = {
				{
					function()
						local msg = "No Active Lsp"
						local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
						local clients = vim.lsp.get_active_clients()
						if next(clients) == nil then return msg end

						local client_names = {}
						local active_client = false
						for _, client in ipairs(clients) do
							local filetypes = client.config.filetypes
							if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
								active_client = true
								if not client_names[client.name] then client_names[client.name] = 1 end
							end
						end

						if active_client then
							local names = {}
							for name, _ in pairs(client_names) do
								table.insert(names, name)
							end
							return table.concat(names, ", ")
						end

						return "No Active Lsp"
					end,
					icon = " LSP:",
					color = { gui = "bold" },
					cond = function() return IS_WIDE() and not IS_START() end,
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
				},
			},
			lualine_y = { "" },
			lualine_z = { "" },
			-- lualine_y = { "filetype" },
			-- lualine_z = { "location" },
		},
		tabline = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"aerial",
					sep = " ) ",
					depth = nil,
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { "tabs" },
		},
		options = {
			icons_enabled = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			theme = "tokyonight",
			disabled_filetypes = { "aerial" },
			globalstatus = true,
			options = { fmt = string.lower },
		},
		extensions = {
			"aerial",
			"fugitive",
			"nvim-dap-ui",
			"nvim-tree",
			"quickfix",
		},
	},
}
