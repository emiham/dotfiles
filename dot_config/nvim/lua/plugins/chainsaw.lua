return {
  "chrisgrieser/nvim-chainsaw",
  event = "VeryLazy",
  config = function()
    local chainsaw = require("chainsaw")
    chainsaw.setup()
    vim.keymap.set(
      { "n", "v" },
      "<leader>Pv",
      function() chainsaw.variableLog() end,
      { desc = "Print variable for debugging" }
    )
    vim.keymap.set(
      "n",
      "<leader>Pe",
      function() chainsaw.emojiLog() end,
      { desc = "Print emoji for debugging" }
    )
    vim.keymap.set(
      { "n", "v" },
      "<leader>Po",
      function() chainsaw.objectLog() end,
      { desc = "Print object for debugging" }
    )
    vim.keymap.set(
      { "n", "v" },
      "<leader>Pt",
      function() chainsaw.typeLog() end,
      { desc = "Print type for debugging" }
    )
    vim.keymap.set(
      { "n", "v" },
      "<leader>Pa",
      function() chainsaw.assertLog() end,
      { desc = "Print assert for debugging" }
    )
    vim.keymap.set(
      "n",
      "<leader>Ps",
      function() chainsaw.sound() end,
      { desc = "Play sound for debugging" }
    )
    vim.keymap.set(
      "n",
      "<leader>Pm",
      function() chainsaw.messageLog() end,
      { desc = "Enter message for debugging" }
    )
    vim.keymap.set(
      "n",
      "<leader>PT",
      function() chainsaw.timeLog() end,
      { desc = "Print time for debugging" }
    )
    vim.keymap.set(
      "n",
      "<leader>PD",
      function() chainsaw.debugLog() end,
      { desc = "Print debug statements for debugging" }
    )
    vim.keymap.set(
      "n",
      "<leader>PS",
      function() chainsaw.stacktraceLog() end,
      { desc = "Print stacktrace for debugging" }
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
  end,
}
