return {
    -- Debug Adapter Protocol (DAP)
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            -- Set up breakpoints with red bug icons
            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error", linehl = "", numhl = "" })

            -- Keybindings for debugging
            vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Start/Continue Debugging" })
            vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Step Over" })
            vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Step Into" })
            vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Step Out" })
            vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Set Conditional Breakpoint" })
            vim.keymap.set("n", "<leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, { desc = "Set Log Point" })
            vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end, { desc = "Open REPL" })
            vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate Debugging" })


            
            -- Set up DAP adapters for Python and C++
            dap.adapters.python = {
                type = "executable",
                command = "python",
                args = { "-m", "debugpy.adapter" },
            }
            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch Python File",
                    program = "${file}",
                    pythonPath = function()
                        return vim.fn.exepath("python")
                    end,
                },
            }

            dap.adapters.cppdbg = {
                id = "cppdbg",
                type = "executable",
                command = "C:\\Users\\Amr khaled\\.vscode\\extensions\\ms-vscode.cpptools-1.23.6-win32-x64\\debugAdapters\\bin\\OpenDebugAD7.exe",
            }
            
            dap.configurations.cpp = {
                {
                    name = "Launch C++",
                    type = "cppdbg",
                    request = "launch",
                    program = "${workspaceFolder}/a.exe",
                    cwd = "${workspaceFolder}",
                    stopAtEntry = false,
                },
            }
        end,
    },

    -- DAP UI
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dapui = require("dapui")
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
        end,
    },

    -- Virtual Text for DAP
    {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },

    -- Telescope DAP integration
    {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
        config = function()
            require("telescope").load_extension("dap")
        end,
    },
}
