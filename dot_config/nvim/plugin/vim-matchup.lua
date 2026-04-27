vim.pack.add({ "https://github.com/andymass/vim-matchup" })

vim.g.matchup_matchparen_offscreen = { method = "popup" }
vim.g.matchup_matchparen_deferred = 1
vim.keymap.set("n", "g%", "<plug>(matchup-g%)", { desc = "Previous match" })
vim.keymap.set(
  "n",
  "z%",
  "<plug>(matchup-g%)",
  { desc = "Go inside the nearest inner contained block" }
)
