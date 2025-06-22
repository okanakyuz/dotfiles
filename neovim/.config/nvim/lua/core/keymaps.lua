local ok_dap, dap = pcall(require, "dap")
local ok_dapui, dapui = pcall(require, "dapui")
if not (ok_dap and ok_dapui) then
  return
end


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


local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
vim.keymap.set("n", "<space>fe", ":Telescope file_browser<CR>")

vim.keymap.set("n", "<leader>g", ":Neogit<CR>", { desc = "Neogit" })

