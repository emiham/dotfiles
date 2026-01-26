vim.g.python3_host_prog =
  vim.fn.expand("$XDG_DATA_HOME/nvim/py3nvim/bin/python3")

vim.cmd("source ~/.config/vim/vimrc")

-- vimrc overrides
vim.go.laststatus = 3
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"

vim.o.winborder = "single"

-- Bootstrap Lazy
-- TODO 0.12 We can do this with vim.pack.add({ 'https://github.com/folke/lazy.nvim' }) now!
-- Or just move away from Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  change_detection = {
    enabled = false,
  },
})

vim.g.did_load_filetypes = 1

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "Error",
      [vim.diagnostic.severity.WARN] = "Warn",
      [vim.diagnostic.severity.INFO] = "Info",
      [vim.diagnostic.severity.HINT] = "Hint",
    },
  },
})

vim.keymap.set(
  "n",
  "<leader>E",
  function() vim.diagnostic.open_float() end,
  { desc = "Toggle Diagnostics" }
)

vim.keymap.set(
  "n",
  "<leader>p",
  function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = "Toggle Diagnostics" }
)

vim.keymap.set(
  "n",
  "<leader>n",
  function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = "Toggle Diagnostics" }
)

vim.keymap.set(
  "n",
  "<leader>q",
  function() vim.diagnostic.setloclist() end,
  { desc = "Toggle Diagnostics" }
)

vim.diagnostic.config({ virtual_text = false })
local diagnostic_win_id
vim.keymap.set("n", "<leader>e", function()
  if diagnostic_win_id and vim.api.nvim_win_is_valid(diagnostic_win_id) then
    vim.api.nvim_win_close(diagnostic_win_id, false)
    diagnostic_win_id = nil
  else
    _, diagnostic_win_id = vim.diagnostic.open_float()
  end
end, { desc = "Toggle Diagnostics" })

vim.keymap.set(
  "n",
  "<leader>E",
  function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
  { desc = "Toggle Diagnostics" }
)

vim.api.nvim_create_user_command("UpdateEverything", function()
  local headless = #vim.api.nvim_list_uis() == 0

  vim.api.nvim_create_autocmd("User", {
    pattern = "MasonUpdateAllComplete",
    once = true,
    callback = function()
      require("lazy").sync({
        wait = true,
        show = false,
      })
      vim.cmd("TSUpdate")
      vim.api.nvim_echo({ { "\n" } }, false, {})
      if headless then vim.cmd("qa") end
    end,
  })

  vim.cmd("MasonUpdateAll")
end, {})

require("autocommands")

local function split_quotes()
  local selected_text =
    vim.fn.getregion(vim.fn.getpos("'<"), vim.fn.getpos("'>"))[1]

  local leading_space, main_text, trailing_space =
    selected_text:match("^(%s*)(.-)(%s*)$")

  vim.api.nvim_create_user_command(
    "SplitQuotes",
    split_quotes,
    { range = true }
  )

  local quote_char, content = main_text:match("([\"'])(.-)%1")

  if not quote_char or not content then return end

  local parts = vim.split(content, "%s+")

  local quoted_result = quote_char
    .. table.concat(parts, quote_char .. ", " .. quote_char)
    .. quote_char
  local result = leading_space .. quoted_result .. trailing_space

  vim.fn.setreg('"', result)
  vim.cmd("normal! gvp")
end

vim.api.nvim_create_user_command("SplitQuotes", split_quotes, { range = true })

-- Use osc52 as clipboard provider
local function paste()
  return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

-- stylua: ignore start
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to clipboard (motion)" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to clipboard (selection)" })
vim.keymap.set("n", "<leader>Y", '"+Y', { remap = true, desc = "Yank line to clipboard" })
vim.keymap.set("n", "<leader>d", '"+d', { desc = "Delete to clipboard (motion)" })
vim.keymap.set("v", "<leader>d", '"+d', { desc = "Delete to clipboard (selection)" })
vim.keymap.set("n", "<leader>D", '"+D', { desc = "Delete line to clipboard" })
vim.keymap.set("n", "<leader>c", '"+c', { desc = "Change to clipboard (motion)" })
vim.keymap.set("v", "<leader>c", '"+c', { desc = "Change to clipboard (selection)" })
vim.keymap.set("n", "<leader>C", '"+C', { desc = "Change line to clipboard" })
-- stylua: ignore end

local function insert_line(direction)
  vim.opt.paste = true

  local key = direction == "below" and "o" or "O"
  local seq = "m`" .. key .. "<Esc>``"

  local keys = vim.api.nvim_replace_termcodes(seq, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)

  vim.opt.paste = false
end

vim.keymap.set(
  "n",
  "<leader>o",
  function() insert_line("below") end,
  { desc = "Insert line below without autoindent", silent = true }
)

vim.keymap.set(
  "n",
  "<leader>O",
  function() insert_line("above") end,
  { desc = "Insert line above without autoindent", silent = true }
)

vim.keymap.set(
  "n",
  "<leader>z",
  function() vim.fn["UnrolMe"]() end,
  { desc = "Toggle all folds" }
)

vim.keymap.set(
  "n",
  "<leader>m",
  function() require("minty.huefy").open({ border = true }) end,
  { desc = "Open color picker" }
)

-- TODO Move to floating window under cursor
vim.keymap.set("n", "<leader>i", vim.show_pos, { desc = "Inspect" })

vim.keymap.set("n", "<leader>I", function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input("I")
end, { desc = "Inspect Tree" })

-- Better diffs
if vim.fn.has("nvim-0.12") == 1 then
  vim.o.diffopt = "internal,filler,closeoff,inline:word,linematch:40"
elseif vim.fn.has("nvim-0.11") == 1 then
  vim.o.diffopt = "internal,filler,closeoff,linematch:40"
end
vim.opt.fillchars:append("diff:╱")

vim.keymap.set("n", "<leader>R", function()
  local line = vim.api.nvim_get_current_line()
  vim.cmd("terminal " .. line)
end, { desc = "Run current line in terminal" })

vim.keymap.set(
  "n",
  "<leader>x",
  "<cmd>.lua<CR>",
  { desc = "Execute the current line" }
)

vim.keymap.set("n", "gV", "`[v`]", { desc = "Select the last paste" })

vim.keymap.set(
  "n",
  "<leader>X",
  "<cmd>source %<CR>",
  { desc = "Execute the current file" }
)

-- Remove default LSP binds
vim.keymap.del("n", "gra")
vim.keymap.del("v", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "gO")
vim.keymap.del("i", "<C-S>")

require("niri_maximizer").setup()
