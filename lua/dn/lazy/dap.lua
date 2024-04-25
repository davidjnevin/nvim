return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"  },
	config = function()
		local dap = require "dap"
		local dapui = require "dapui"
		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		dap.adapters.python = {
			type = "executable",
			command = os.getenv "VIRTUAL_ENV",
			args = { "python", "-m", "debugpy.adapter" },
		}

		dap.configurations.python = {
			{
				-- The first three options are required by nvim-dap
				type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = "launch",
				name = "Launch file",

				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

				program = "${file}", -- This configuration will launch the current file if used.
				pythonPath = function()
					-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
					-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
					-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
						return cwd .. "/.venv/bin/python"
					else
						return "/usr/bin/python"
					end
				end,
			},
		}
		dap.adapters.node2 = {
			type = "executable",
			command = "node",
			args = { os.getenv "HOME" .. "/vscode-node-debug2/out/src/nodeDebug.js" },
		}
		dap.configurations.typescript = {
			{
				type = "node2",
				request = "attach",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				skipFiles = { "<node_internals>/**/*.js" },
				port = 9229,
			},
		}

		-- C/C++
		dap.adapters.lldb = {
			type = 'executable',
			command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
			name = 'lldb'
		}
		dap.configurations.cpp = {
			{
				name = "lldb",
				type = "cpp",
				request = "launch",
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = '${workspaceFolder}',
				externalTerminal = false,
				stopOnEntry = false,
				args = {}
			},
		}

		dapui.setup {
			icons = { expanded = "", collapsed = "", current_frame = "" },
			layouts = {
				{
					elements = {
						"scopes",
						"breakpoints",
					},
					position = "left",
					size = 40,
				},
			},
			floating = {
				max_height = nil, -- These can be integers or a float between 0 and 1.
				max_width = nil, -- Floats will be treated as percentage of your screen.
				border = "single", -- Border style. Can be "single", "double" or "rounded"
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
		}

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "→", texthl = "WarningMsg", linehl = "", numhl = "" })
	end,
}
