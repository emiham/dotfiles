return {
  "emiham/seoul256.nvim",
  dev = true,
  dir = "~/code/mine/nvim/emiham/seoul256.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.seoul256_italic_comments = true
    vim.g.seoul256_italic_keywords = true
    vim.g.seoul256_italic_functions = true
    vim.g.seoul256_italic_variables = false
    vim.g.seoul256_contrast = true
    vim.g.seoul256_borders = false
    vim.g.seoul256_disable_background = true
    vim.g.seoul256_background = 237
    vim.g.seoul256_hl_current_line = true
    vim.g.seoul256_srgb = true
    vim.cmd([[colorscheme seoul256]])
  end,
}
