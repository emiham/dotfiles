vim.pack.add({ "https://github.com/L3MON4D3/LuaSnip" })
-- lua-jsgegexp needs to be installed through the package manager

local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load({
  paths = { vim.fn.stdpath("config") .. "/snippets" },
})
local fmt = require("luasnip.extras.fmt").fmt

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then ls.change_choice(1) end
end, { silent = true })

local s, t = ls.snippet, ls.text_node
local f = ls.function_node
local i = ls.insert_node

local function get_date_info(days, fmt)
  return os.date(fmt, os.time() + (days * 86400))
end

local snippets = {
  s("today", t(get_date_info(0, "%Y-%m-%d"))),
  s("tomorrow", t(get_date_info(1, "%Y-%m-%d"))),
  s("underline", {
    f(function()
      local cursor = vim.api.nvim_win_get_cursor(0)
      local row = cursor[1]

      local lines = vim.api.nvim_buf_get_lines(0, row - 2, row - 1, false)
      local prev_line = lines[1] or ""

      local clean_line = prev_line:gsub("%s+$", "")
      local length = #clean_line

      if length > 0 then
        return { string.rep("-", length), "" }
      else
        return ""
      end
    end, {}),
    i(0),
  }),
}

for i_ = 1, 7 do
  local day_name = get_date_info(i_, "%A")
  local date_val = get_date_info(i_, "%Y-%m-%d")

  table.insert(snippets, s(day_name, t(date_val)))
end

ls.add_snippets("all", snippets)
