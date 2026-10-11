vim.pack.add({ "https://github.com/stevearc/quicker.nvim" })

require("quicker").setup()
vim.keymap.set(
  "n",
  "<leader>q",
  function()
    require("quicker").toggle()
  end,
  {
    desc = "Toggle quickfix",
  }
)
