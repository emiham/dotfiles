return {
  "brenoprata10/nvim-highlight-colors",
  opts = function()
    return {
      enable_var_usage = true,
      formatting = {
        format = require("nvim-highlight-colors").format,
      },
    }
  end,
}
