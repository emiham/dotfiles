return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
      signs = {
        add = { text = "🮇" },
        change = { text = "🮇" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "🮇" },
        change = { text = "🮇" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
    keys = {
      {
        "<leader>h",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            require("gitsigns").nav_hunk("next")
          end
        end,
        desc = "Next Hunk",
      },
      {
        "<leader>H",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            require("gitsigns").nav_hunk("prev")
          end
        end,
        desc = "Prev Hunk",
      },
      {
        "]H",
        function() require("gitsigns").nav_hunk("last") end,
        desc = "Last Hunk",
      },
      {
        "[H",
        function() require("gitsigns").nav_hunk("first") end,
        desc = "First Hunk",
      },
      {
        "<leader>gitsigns",
        ":Gitsigns stage_hunk<CR>",
        desc = "Stage Hunk",
        mode = { "n", "v" },
      },
      -- {
      --   "<leader>gr",
      --   ":Gitsigns reset_hunk<CR>",
      --   desc = "Reset Hunk",
      --   mode = { "n", "v" },
      -- },
      {
        "<leader>gitsigns",
        function() require("gitsigns").stage_buffer() end,
        desc = "Stage Buffer",
      },
      {
        "<leader>gu",
        function() require("gitsigns").undo_stage_hunk() end,
        desc = "Undo Stage Hunk",
      },
      {
        "<leader>gR",
        function() require("gitsigns").reset_buffer() end,
        desc = "Reset Buffer",
      },
      {
        "<leader>gp",
        function() require("gitsigns").preview_hunk_inline() end,
        desc = "Preview Hunk Inline",
      },
      {
        "<leader>gb",
        function() require("gitsigns").blame_line({ full = true }) end,
        desc = "Blame Line",
      },
      {
        "<leader>gB",
        function() require("gitsigns").blame() end,
        desc = "Blame Buffer",
      },
      {
        "<leader>gD",
        function() require("gitsigns").diffthis("~") end,
        desc = "Diff This ~",
      },
      {
        "ih",
        ":<C-U>Gitsigns select_hunk<CR>",
        desc = "Select Hunk",
        mode = { "o", "x" },
      },
    },
  },
  {
    "tpope/vim-fugitive",
    keys = {
      {
        "<leader>gg",
        ":Git<CR>",
        desc = "Status",
      },
      {
        "<leader>gd",
        ":Gdiff<CR>",
        desc = "Diff",
      },
    },
  },
}
