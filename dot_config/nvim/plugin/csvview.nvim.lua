vim.pack.add({ "https://github.com/hat0uma/csvview.nvim" })

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.[tc]sv",
  callback = function()
    vim.cmd("CsvViewEnable")
    vim.o.wrap = false
  end,
})

---@module "csvview"
---@type CsvView.Options
require("csvview").setup({
  parser = { comments = { "#", "//" } },
  keymaps = {
    textobject_field_inner = { "if", mode = { "o", "x" } },
    textobject_field_outer = { "af", mode = { "o", "x" } },
    jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
    jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
    jump_next_row = { "<Enter>", mode = { "n", "v" } },
    jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
  },
  view = {
    display_mode = "border",
    header_lnum = 1,
    sticky_header = {
      enabled = true,
      separator = "─",
    },
  },
})
