return {
  "andymass/vim-matchup",
  init = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
    vim.g.matchup_matchparen_deferred = 1
    vim.keymap.set(
      "n",
      "g%",
      "<plug>(matchup-g%)",
      { desc = "Previous match" }
    )
    vim.keymap.set(
      "n",
      "z%",
      "<plug>(matchup-g%)",
      { desc = "Go inside the nearest inner contained block" }
    )
  end,
}
