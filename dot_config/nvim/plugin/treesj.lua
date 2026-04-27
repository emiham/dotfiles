vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/Wansmer/treesj",
})

require("treesj").setup({
  use_default_keymaps = false,
})

vim.keymap.set("n", "<leader>j", ":TSJToggle<CR>", {
  desc = "Join/split block",
})
