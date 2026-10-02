vim.pack.add({ "https://github.com/tpope/vim-fugitive" })

vim.keymap.set("n", "<leader>gg", ":vertical Git<CR>", { desc = "Status" })
vim.keymap.set("n", "<leader>gd", ":vertical Gdiff<CR>", { desc = "Diff" })
