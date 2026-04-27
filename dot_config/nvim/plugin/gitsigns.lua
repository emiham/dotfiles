vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup({
  signs = {
    add = { text = "🮇" },
    change = { text = "🮇" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "🮇" },
    change = { text = "🮇" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
})

vim.keymap.set("n", "<leader>h", function()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    require("gitsigns").nav_hunk("next")
  end
end, { desc = "Next Hunk" })

vim.keymap.set("n", "<leader>H", function()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    require("gitsigns").nav_hunk("prev")
  end
end, { desc = "Prev Hunk" })

vim.keymap.set(
  "n",
  "]H",
  function() require("gitsigns").nav_hunk("last") end,
  { desc = "Last Hunk" }
)
vim.keymap.set(
  "n",
  "[H",
  function() require("gitsigns").nav_hunk("first") end,
  { desc = "First Hunk" }
)

vim.keymap.set(
  { "n", "v" },
  "<leader>gitsigns",
  ":Gitsigns stage_hunk<CR>",
  { desc = "Stage Hunk" }
)

-- {
--   "<leader>gr",
--   ":Gitsigns reset_hunk<CR>",
--   desc = "Reset Hunk",
--   mode = { "n", "v" },
--  },

vim.keymap.set(
  "n",
  "<leader>gitsigns",
  function() require("gitsigns").stage_buffer() end,
  { desc = "Stage Buffer" }
)
vim.keymap.set(
  "n",
  "<leader>gu",
  function() require("gitsigns").undo_stage_hunk() end,
  { desc = "Undo Stage Hunk" }
)
vim.keymap.set(
  "n",
  "<leader>gR",
  function() require("gitsigns").reset_buffer() end,
  { desc = "Reset Buffer" }
)
vim.keymap.set(
  "n",
  "<leader>gp",
  function() require("gitsigns").preview_hunk_inline() end,
  { desc = "Preview Hunk Inline" }
)
vim.keymap.set(
  "n",
  "<leader>gb",
  function() require("gitsigns").blame_line({ full = true }) end,
  { desc = "Blame Line" }
)
vim.keymap.set(
  "n",
  "<leader>gB",
  function() require("gitsigns").blame() end,
  { desc = "Blame Buffer" }
)
vim.keymap.set(
  "n",
  "<leader>gD",
  function() require("gitsigns").diffthis("~") end,
  { desc = "Diff This ~" }
)

vim.keymap.set(
  { "o", "x" },
  "ih",
  ":<C-U>Gitsigns select_hunk<CR>",
  { desc = "Select Hunk" }
)
