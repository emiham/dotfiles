vim.pack.add({
  {
    src = "https://github.com/igorlfs/nvim-dap-view",
    version = vim.version.range("1.*"),
  },
})

vim.keymap.set("n", "<leader>ds", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes, { border = "rounded" })
end, { desc = "DAP Scopes" })
