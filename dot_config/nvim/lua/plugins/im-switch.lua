local M = {}

if vim.fn.executable("fcitx5") == 1 then
  M = {
    "drop-stones/im-switch.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
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
    },
  }
end

return M
