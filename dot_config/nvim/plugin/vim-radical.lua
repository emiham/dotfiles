vim.pack.add({ "https://github.com/glts/vim-magnum" })
vim.pack.add({ "https://github.com/glts/vim-radical" })

vim.keymap.set({ "n", "x" }, "gA", "<Plug>RadicalView", {
  desc = "Show decimal, hex, octal, binary number representations",
})

vim.keymap.set("n", "crd", "<Plug>RadicalCoerceToDecimal", {
  desc = "Coerce to decimal",
})

vim.keymap.set("n", "crx", "<Plug>RadicalCoerceToHex", {
  desc = "Coerce to hex",
})

vim.keymap.set("n", "cro", "<Plug>RadicalCoerceToOctal", {
  desc = "Coerce to octal",
})

vim.keymap.set("n", "crb", "<Plug>RadicalCoerceToBinary", {
  desc = "Coerce to binary",
})
