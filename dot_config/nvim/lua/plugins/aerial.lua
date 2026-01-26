return {
  "stevearc/aerial.nvim",
  opts = {
    filter_kind = false,
    backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
  },
  keys = {
    {
      "{",
      "<cmd>AerialPrev<CR>",
      mode = "n",
      desc = "Jump to next symbol",
    },
    {
      "}",
      "<cmd>AerialNext<CR>",
      mode = "n",
      desc = "Jump to previous symbol",
    },
    {
      "<leader>a",
      "<cmd>AerialToggle!<CR>",
      mode = "n",
      desc = "Aerial",
    },
  },
}
