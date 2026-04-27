vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/LiadOz/nvim-dap-repl-highlights",
  "https://github.com/rcarriga/nvim-dap-ui",
})

vim.fn.sign_define("DapBreakpoint", {
  text = "・",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})
require("dapui").setup()

vim.keymap.set(
  "n",
  "<leader>bb",
  function() require("dapui").toggle() end,
  { desc = "DAP: Toggle UI" }
)

vim.keymap.set(
  "n",
  "<leader>bc",
  function() require("dap").continue() end,
  { desc = "DAP: Continue / Start" }
)

vim.keymap.set(
  "n",
  "<leader>bp",
  function() require("dap").toggle_breakpoint() end,
  { desc = "DAP: Toggle breakpoint" }
)

vim.keymap.set(
  "n",
  "<leader>bo",
  function() require("dap").step_over() end,
  { desc = "DAP: Step over" }
)

vim.keymap.set(
  "n",
  "<leader>bi",
  function() require("dap").step_into() end,
  { desc = "DAP: Step into" }
)
