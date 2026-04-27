return {
  "brenoprata10/nvim-highlight-colors",
  opts = function()
    return {
      enable_var_usage = true,
      formatting = {
        format = require("nvim-highlight-colors").format,
      },
      custom_colors = {
        -- { label = "white", color = "#d0d0d0" },
        -- { label = "black", color = "#4e4e4e" },
        -- { label = "red", color = "#d68787" },
        -- { label = "green", color = "#5f865f" },
        -- { label = "yellow", color = "#d8af5f" },
        -- { label = "blue", color = "#85add4" },
        -- { label = "magenta", color = "#d7afaf" },
        -- { label = "cyan", color = "#87afaf" },
        -- { label = "white", color = "#d0d0d0" },
      },
    }
  end,
}
