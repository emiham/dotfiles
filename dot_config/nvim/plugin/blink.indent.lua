vim.pack.add({ "https://github.com/saghen/blink.indent" })

require("blink.indent").setup({
  static = {
    char = "▏",
  },
  scope = {
    char = "▏",
    -- TODO Rename
    highlights = { "MiniIndentScopeSymbol" },
  },
})
