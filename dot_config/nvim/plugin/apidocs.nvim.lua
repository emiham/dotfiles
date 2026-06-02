vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-mini/mini.pick",
  "https://github.com/nvim-mini/mini.extra",
  -- "https://github.com/emmanueltouzery/apidocs.nvim"
})
vim.cmd.packadd("apidocs.nvim")
require("apidocs").setup({ picker = "mini.pick" })
vim.keymap.set(
  "n",
  "<leader>fa",
  "<cmd>ApidocsOpen<cr>",
  { desc = "API Docs" }
)
vim.keymap.set(
  "n",
  "<leader>fA",
  "<cmd>ApidocsSearch<cr>",
  { desc = "API Docs (grep)" }
)
