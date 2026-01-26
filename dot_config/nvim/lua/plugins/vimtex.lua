return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_progname = "nvr"
    vim.g.vimtex_fold_enabled = 1
    vim.g.vimtex_quickfix_enabled = 0
    vim.g.vimtex_syntax_conceal_disable = 1
    vim.g.tex_flavor = "latex"
  end,
}
