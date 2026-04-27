-- vim.pack.add({
--   "https://github.com/emiham/seoul256.nvim",
-- })
vim.cmd.packadd("seoul256.nvim")

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
