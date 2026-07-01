vim.pack.add({ "https://github.com/nvim-mini/mini.ai" })

require("mini.ai").setup({
  custom_textobjects = {
    e = { "()()%f[%w-][%w-]+()[ \t]*()" },
    f = require("mini.ai").gen_spec.treesitter({
      a = "@function.outer",
      i = "@function.inner",
    }),
  },
  n_lines = 500,
})
