vim.pack.add({ "https://github.com/chrisgrieser/nvim-chainsaw" })

local chainsaw = require("chainsaw")
chainsaw.setup()

vim.keymap.set(
  { "n", "v" },
  "<leader>Pv",
  function() chainsaw.variableLog() end,
  { desc = "Print variable" }
)
vim.keymap.set(
  "n",
  "<leader>Pe",
  function() chainsaw.emojiLog() end,
  { desc = "Print emoji" }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>Po",
  function() chainsaw.objectLog() end,
  { desc = "Print object" }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>Pt",
  function() chainsaw.typeLog() end,
  { desc = "Print type" }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>Pa",
  function() chainsaw.assertLog() end,
  { desc = "Print assert" }
)
vim.keymap.set(
  "n",
  "<leader>Ps",
  function() chainsaw.sound() end,
  { desc = "Play sound" }
)
vim.keymap.set(
  "n",
  "<leader>Pm",
  function() chainsaw.messageLog() end,
  { desc = "Enter message" }
)
vim.keymap.set(
  "n",
  "<leader>PT",
  function() chainsaw.timeLog() end,
  { desc = "Print time" }
)
vim.keymap.set(
  "n",
  "<leader>PD",
  function() chainsaw.debugLog() end,
  { desc = "Print debug statements" }
)
vim.keymap.set(
  "n",
  "<leader>PS",
  function() chainsaw.stacktraceLog() end,
  { desc = "Print stacktrace" }
)
vim.keymap.set(
  "n",
  "<leader>Pc",
  function() chainsaw.clearLog() end,
  { desc = "Clear console" }
)
vim.keymap.set(
  "n",
  "<leader>Pd",
  function() chainsaw.removeLogs() end,
  { desc = "Remove debug prints" }
)
