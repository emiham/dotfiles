if vim.fn.executable("fcitx5") == 1 then
  vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })
  vim.pack.add({ "https://github.com/drop-stones/im-switch.nvim" })

  require("im-switch").setup({
    default_im_events = {
      "InsertLeave",
    },
    save_im_state_events = { "InsertLeavePre" },
    restore_im_events = { "InsertEnter" },
    linux = {
      enabled = true,
      default_im = "Svenska",
      get_im_command = { "fcitx5-remote", "-q" },
      set_im_command = { "fcitx5-remote", "-g" },
    },
  })
end
