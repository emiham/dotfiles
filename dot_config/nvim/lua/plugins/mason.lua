return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "single" },
    },
  },
  {
    "RubixDev/mason-update-all",
    opts = {},
  },
}
