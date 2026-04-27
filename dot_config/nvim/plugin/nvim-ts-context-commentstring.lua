vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
})

vim.g.skip_ts_context_commentstring_module = true

require("ts_context_commentstring").setup({
  enable_autocmd = false,
})
