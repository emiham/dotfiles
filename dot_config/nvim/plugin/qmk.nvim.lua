vim.pack.add({ "https://github.com/codethread/qmk.nvim" })

require("qmk").setup({
  ---@type qmk.UserConfig
  name = "LAYOUT_corne",
  layout = {
    "_ _ x x x x x x _ x x x x x x",
    "_ _ x x x x x x _ x x x x x x",
    "_ _ x x x x x x _ x x x x x x",
    "_ _ _ _ _ x x x _ x x x _ _ _",
  },
  variant = "zmk",
  comment_preview = {
    position = "none",
  },
})
