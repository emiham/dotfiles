vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

require("diffview").setup({
  view = {
    merge_tool = {
      layout = "diff4_mixed",
      disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
      winbar_info = false, -- See |diffview-config-view.x.winbar_info|
    },
  },
})
