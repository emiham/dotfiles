vim.pack.add({ "https://github.com/L3MON4D3/LuaSnip" })
-- lua-jsgegexp needs to be installed through the package manager

local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then ls.change_choice(1) end
end, { silent = true })

local s, t = ls.snippet, ls.text_node

local function get_date_info(days, fmt)
  return os.date(fmt, os.time() + (days * 86400))
end

local snippets = {
  s("today", t(get_date_info(0, "%Y-%m-%d"))),
  s("tomorrow", t(get_date_info(1, "%Y-%m-%d"))),
}

for i = 1, 7 do
  local day_name = get_date_info(i, "%A")
  local date_val = get_date_info(i, "%Y-%m-%d")

  table.insert(snippets, s(day_name, t(date_val)))
end

ls.add_snippets("all", snippets)
