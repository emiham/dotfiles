return {
  "mbbill/undotree",
  init = function()
    vim.g.undotree_WindowLayout = 4
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_SplitWidth = 32
    vim.g.undotree_DiffpanelHeight = 20
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
  keys = {
    {
      "<leader>u",
      "<cmd>UndotreeToggle<cr>",
      desc = "Toggle Undotree",
    },
  },
}
