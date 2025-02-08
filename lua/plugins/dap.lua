return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		require("dapui").setup()


		
		local dap, dapui = require("dap"), require("dapui")
		--choose between codelldb and cpptools
		--local codelldb = require("mason-registry").get_package("codelldb"):get_install_path() .. "/codelldb"
		--local cpptools = require("mason-registry").get_package("cpptools"):get_install_path()
		--.. "/extension/debugAdapters/bin/OpenDebugAD7"

		-- dap.defaults.fallback.external_terminal = {
		-- 	command = "/usr/bin/kitty",
		-- 	args = { "-e" },
		-- }
		dap.defaults.fallback.force_external_terminal = false

		--Test(Compile c++)

		local function c_cpp_compile()
			vim.cmd("w")  -- Save the current file
		
			local file_extension = vim.fn.expand("%:e")
			local fullpath = vim.fn.expand("%:p")
			local output_dir = vim.fn.getcwd() .. "\\out"
			local output_file = output_dir .. "\\" .. vim.fn.expand("%:r") .. ".exe"
		
			-- Ensure the output directory exists
			vim.fn.mkdir(output_dir, "p")
		
			local command
			if file_extension == "cpp" then
				command = 'g++ -g -std=c++17  -o "'
						.. output_file
						.. '" "'
						.. fullpath
						.. '"'
			elseif file_extension == "c" then
				command = 'gcc -g -std=c11 -o "'
						.. output_file
						.. '" "'
						.. fullpath
						.. '"'
			else
				print("Unsupported file type")
				return
			end
		
			-- Replace forward slashes with backslashes for Windows compatibility
			command = vim.fn.substitute(command, '/', '\\', 'g')
		
			-- Execute the command
			local result = vim.fn.system(command)
		
			-- Check if the compilation was successful
			if vim.v.shell_error ~= 0 then
				print("Compilation failed: " .. result)
			else
				print("Compilation successful: " .. output_file)
			end
		end

		vim.api.nvim_create_user_command("Compile", c_cpp_compile, {})

		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "C:\\Users\\Amr khaled\\.vscode\\extensions\\ms-vscode.cpptools-1.23.6-win32-x64\\debugAdapters\\bin\\OpenDebugAD7.exe",
			--command = cpptools,
			options = {
				detached = false
			}
		}

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				-- CHANGE THIS to your path!
				command = "C:/Users/Amr khaled/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb",
				args = { "--port", "${port}" },

				-- On windows you may have to uncomment this:
				detached = false,
			},
		}

		dap.adapters.lldb = {
			name = "lldb",
			type = "executable",
			command = "/usr/bin/lldb-dap",
		}

		dap.adapters.python = function(cb, config)
			if config.request == "attach" then
				---@diagnostic disable-next-line: undefined-field
				local port = (config.connect or config).port
				---@diagnostic disable-next-line: undefined-field
				local host = (config.connect or config).host or "127.0.0.1"
				cb({
					type = "server",
					port = assert(port, "`connect.port` is required for a python `attach` configuration"),
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			else
				cb({
					type = "executable",
					command = "C:/Users/Amr khaled/AppData/Local/nvim-data/mason/packages/debugpy/venv/bin/python3",
					args = { "-m", "debugpy.adapter" },
					options = {
						source_filetype = "python",
					},
				})
			end
		end

		dap.configurations.cpp = {
			{
				name = "Launch codelldb",
				type = "codelldb",
				request = "launch",
				program = function()
					vim.cmd("Compile")
					return "${workspaceFolder}/out/" .. vim.fn.expand("%:t:r")
				end,
				cwd = "${workspaceFolder}/out",
				stopOnEntry = false,

			},
			{
				name = "Launch vs-cpptools",
				type = "cppdbg",
				request = "launch",
				program = function()
					vim.cmd("Compile")
					return "${workspaceFolder}/out/" .. vim.fn.expand("%:t:r")
				end,
				cwd = "${workspaceFolder}/out",
				stopAtEntry = false,
				-- externalConsole = false,
				MIMode = "gdb",

				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "enable pretty printing",
						ignoreFailures = false,
					},
				},
			},
		}

		-- remove executable after debugging ends
		dap.listeners.after.event_terminated["remove_executable"] = function(session, body)
			if session.config.type == "cppdbg" or session.config.type == "codelldb" then
				--local executable_path = vim.fn.expand("%:t:r")
				--os.remove(executable_path)
				os.execute("remove-Item -Recurse -Force .fuse_*")
			end
		end

		--dap.adapters.lldb = {
		--	type = "executable",
		--	command = "/usr/bin/lldb-vscode", -- adjust as needed
		--	name = "lldb",
		--	termianl = "integratedTerminal",
		--}

		--dap.configurations.cpp = {
		--{
		--	name = "Launch",
		--	type = "lldb",
		--	request = "launch",
		--	program = function()
		--		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		--	end,
		--	termianl = "integratedTerminal",
		--	cwd = "${workspaceFolder}",
		--	},
		--	}

		--		dap.configurations.cpp = {
		--		{
		--		name = "DebugMe",
		--	type = "lldb",
		--	request = "launch",
		-- TODO: Ask for an executable path if the following does not exist!
		--	program = "${fileDirname}/${fileBasenameNoExtension}",
		--program = function()
		--	return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		--end,
		--cwd = "${workspaceFolder}",
		--console = "integratedTerminal",
		--	},
		--	}

		dap.configurations.c = dap.configurations.cpp

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
					if vim.fn.executable(cwd .. "/venv/bin/python3") == 1 then
						return cwd .. "/venv/bin/python3"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python3") == 1 then
						return cwd .. "/.venv/bin/python"
					else
						return "/usr/bin/python3"
					end
				end,
				console = "integratedTerminal",
			},
		}

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		--[[require("nvim-dap-virtual-text").setup({
			enabled = true, -- enable this plugin (the default)
			enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
			highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
			highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
			show_stop_reason = true, -- show stop reason when stopped for exceptions
			commented = false, -- prefix virtual text with comment string
			only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
			all_references = false, -- show virtual text on all all references of the variable (not only definitions)
			clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
			display_callback = function(variable, buf, stackframe, node, options)
				if options.virt_text_pos == "inline" then
					return " = " .. variable.value
				else
					return variable.name .. " = " .. variable.value
				end
			end,
			-- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
			virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

			-- experimental features:
			all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
			virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
			virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
			-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
		}) ]]

		-- local sign = vim.fn.sign_define

		-- sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
		-- --sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
		-- --sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

		-- vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
		-- vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
		-- vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
		-- vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
	end,
}
