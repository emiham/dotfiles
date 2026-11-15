vim.pack.add({ "https://github.com/nvim-mini/mini.starter" })

require("mini.starter").setup({
  footer = ":DiffviewOpen origin/HEAD...HEAD",
})
