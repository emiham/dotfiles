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

vim.api.nvim_create_user_command("CsvSort", function(opts)
  local bufnr = vim.api.nvim_get_current_buf()
  local csvview_util = require("csvview.util")

  local cursor_info = csvview_util.get_cursor(bufnr)
  if not cursor_info or not cursor_info.pos then
    vim.notify("Could not detect CSV column under cursor", vim.log.levels.WARN)
    return
  end

  local col_idx = cursor_info.pos[2]
  local flags = opts.args

  local cmd = string.format("%%!csvsort -c %d %s", col_idx, flags)
  vim.cmd(cmd)
  vim.cmd.CsvViewDisable()
  vim.cmd.CsvViewEnable()
end, { nargs = "*" })
