vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })

require("fidget").setup({
  notification = {
    override_vim_notify = true,
  },
  progress = {
    ignore = {
      function(msg)
        if msg.lsp_client.name == "lua_ls" then
          if
            msg.title == "Diagnosing"
            or msg.title == "Processing file symbols..."
            or msg.title == "Processing completion..."
            or msg.title == "Processing full semantic tokens..."
            or msg.title == "Processing incremental semantic tokens..."
          then
            return true
          end
        end
        return false
      end,
    },
  },
})
