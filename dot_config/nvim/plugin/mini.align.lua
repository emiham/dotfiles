vim.pack.add({ "https://github.com/echasnovski/mini.align" })

require("mini.align").setup({
  mappings = {
    start = "gl",
    start_with_preview = "gL",
  },
})
