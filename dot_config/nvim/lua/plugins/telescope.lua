return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>ff",
        function() require("telescope.builtin").find_files() end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function() require("telescope.builtin").live_grep() end,
        desc = "Live Grep",
      },
      {
        "<leader>fb",
        function() require("telescope.builtin").buffers() end,
        desc = "Buffers",
      },
      {
        "<leader>fr",
        function() require("telescope.builtin").resume() end,
        desc = "Resume Last Search",
      },
      {
        "<leader>fh",
        function() require("telescope.builtin").help_tags() end,
        desc = "Help Tags",
      },
      {
        "<leader>fH",
        function() require("telescope.builtin").highlights() end,
        desc = "Highlights",
      },
      {
        "<leader>fk",
        function() require("telescope.builtin").keymaps() end,
        desc = "Keymaps",
      },
      {
        "<leader>fn",
        function() require("telescope").extensions.fidget.fidget() end,
        desc = "Highlights",
      },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<Esc>"] = "close",
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
      pickers = {},
      extensions = {
        fzf = {},
        aerial = {},
        fidget = {},
      },
    },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    init = function()
      vim.keymap.set(
        "n",
        "<space>fF",
        ":Telescope file_browser<CR>",
        { desc = "File browser" }
      )
    end,
  },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
      -- optional, if using telescope for vim.ui.select
      "stevearc/dressing.nvim",
    },
    opts = {
      -- your config goes here
    },
  },
}
