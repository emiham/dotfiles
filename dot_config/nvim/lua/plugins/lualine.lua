local function getWords()
  if vim.bo.filetype == "text" or vim.bo.filetype == "markdown" then
    return tostring(vim.fn.wordcount().words) .. " words"
  elseif vim.bo.filetype == "tex" then
    local count = vim.fn["vimtex#misc#wordcount"]()
    if count ~= nil then return count .. " words" end
  end

  return ""
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "seoul256",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
          { "diagnostics", sources = { "nvim_diagnostic" } },
          { getWords },
        },
        lualine_c = {
          {
            "aerial",
            colored = true,
          },
        },
        lualine_x = {
          "encoding",
          "fileformat",
          {
            "filetype",
            colored = true,
            icon_only = false,
            icon = { align = "right" },
          },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
}
