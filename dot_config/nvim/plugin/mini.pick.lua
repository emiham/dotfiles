vim.pack.add({
  "https://github.com/nvim-mini/mini.pick",
  "https://github.com/nvim-mini/mini.extra",
})

require("mini.pick").setup({
  mappings = {
    choose_marked = "<C-CR>",
  },
})

vim.keymap.set(
  "n",
  "<leader>ff",
  function() require("mini.pick").builtin.files() end,
  { desc = "Pick Files" }
)
vim.keymap.set(
  "n",
  "<leader>fg",
  function() require("mini.pick").builtin.grep_live() end,
  { desc = "Live Grep" }
)
vim.keymap.set(
  "n",
  "<leader>fb",
  function() require("mini.pick").builtin.buffers() end,
  { desc = "Buffers" }
)
vim.keymap.set(
  "n",
  "<leader>fR",
  function() require("mini.pick").builtin.resume() end,
  { desc = "Resume Last Search" }
)
vim.keymap.set(
  "n",
  "<leader>fh",
  function() require("mini.pick").builtin.help() end,
  { desc = "Help Tags" }
)
vim.keymap.set(
  "n",
  "<leader>fH",
  function() require("mini.extra").pickers.hl_groups() end,
  { desc = "Highlights" }
)
vim.keymap.set(
  "n",
  "<leader>fk",
  function() require("mini.extra").pickers.keymaps() end,
  { desc = "Keymaps" }
)
vim.keymap.set(
  "n",
  "<space>fF",
  function() require("mini.extra").pickers.explorer() end,
  { desc = "File explorer" }
)
vim.keymap.set(
  "n",
  "<leader>fd",
  function() require("mini.extra").pickers.diagnostic() end,
  { desc = "Diagnostics" }
)
vim.keymap.set(
  "n",
  "<leader>fr",
  function() require("mini.extra").pickers.lsp({ scope = "references" }) end,
  { desc = "References" }
)
vim.keymap.set(
  "n",
  "z=",
  function() require("mini.extra").pickers.spellsuggest() end,
  { desc = "Spelling suggestions" }
)
