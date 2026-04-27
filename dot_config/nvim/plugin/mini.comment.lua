vim.pack.add({ "https://github.com/echasnovski/mini.comment" })

require("mini.comment").setup({
  function() custom_commentstring = "/* %s */" end,
})
