vim.pack.add({ "https://github.com/stevearc/aerial.nvim" })
require("aerial").setup({
  filter_kind = false,
  backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
})

vim.keymap.set(
  "n",
  "{",
  "<cmd>AerialPrev<CR>",
  { desc = "Jump to next symbol" }
)
vim.keymap.set(
  "n",
  "}",
  "<cmd>AerialNext<CR>",
  { desc = "Jump to previous symbol" }
)
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Aerial" })
