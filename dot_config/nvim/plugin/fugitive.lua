vim.pack.add({ "https://github.com/tpope/vim-fugitive" })

vim.keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "Status" })
vim.keymap.set("n", "<leader>gd", ":Gdiff<CR>", { desc = "Diff" })
