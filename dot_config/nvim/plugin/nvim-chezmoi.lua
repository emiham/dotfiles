vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/andre-kotake/nvim-chezmoi",
})

require("nvim-chezmoi").setup({
  edit = {
    apply_on_save = "auto",
  },
})
