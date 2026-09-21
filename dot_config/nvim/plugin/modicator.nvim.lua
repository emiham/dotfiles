vim.pack.add({ "https://github.com/mawkler/modicator.nvim" })

vim.o.cursorline = true
vim.o.number = true
vim.o.termguicolors = true

require("modicator").setup()
