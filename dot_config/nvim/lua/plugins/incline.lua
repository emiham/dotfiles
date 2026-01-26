return {
  "b0o/incline.nvim",
  opts = {},
  event = "VeryLazy",
  config = function()
    local helpers = require("incline.helpers")
    require("incline").setup({
      window = {
        padding = 0,
        margin = { horizontal = 0, vertical = 0 },
      },
      render = function(props)
        local bufname = vim.api.nvim_buf_get_name(props.buf)

        local filename
        if vim.wo.diff then
          filename = vim.fn.fnamemodify(bufname, ":p")
        else
          filename = vim.fn.fnamemodify(bufname, ":t")
        end

        local ft_icon, ft_color =
          require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        local buffer = {
          ft_icon and {
            " ",
            ft_icon,
            " ",
            guibg = ft_color,
            guifg = helpers.contrast_color(ft_color),
          } or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
        }
        return buffer
      end,
    })
  end,
}
