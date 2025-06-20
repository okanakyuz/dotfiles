local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })

vim.keymap.set("n", "<Leader>dr", dap.run_to_cursor, { desc = "DAP: Run to Cursor" })
vim.keymap.set("n", "<Leader>ds", dap.restart, { desc = "DAP: Restart" })
vim.keymap.set("n", "<Leader>dq", dap.terminate, { desc = "DAP: Terminate" })
vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
