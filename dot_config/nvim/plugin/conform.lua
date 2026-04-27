vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
  formatters = {
    stylua = {
      prepend_args = {
        "--config-path",
        vim.fn.expand("$HOME/.config/nvim/stylua.toml"),
      },
    },
    prettierd = {
      env = {
        PRETTIERD_DEFAULT_CONFIG = vim.fn.expand(
          "$HOME/.config/nvim/prettierrc.json"
        ),
      },
    },
    beautysh = {
      args = {
        "--indent-size",
        "2",
        "-",
      },
    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    json = { "jq" },
    python = {
      "ruff_fix",
      "ruff_format",
      "ruff_organize_imports",
    },
    javascript = { "prettierd" },
    latex = { "latexindent" },
    c = { "clang-format" },
    sh = { "beautysh" },
    bash = { "beautysh" },
    zsh = { "beautysh" },
    yaml = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    rust = { "rustfmt" },
    java = { "google-java-format" },
    kdl = { "kdlfmt" },
    go = { "gofmt" },
  },
  format_on_save = function(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/imapnotify/") then return end
    return {
      timeout_ms = 500,
      lsp_fallback = true,
    }
  end,
})
