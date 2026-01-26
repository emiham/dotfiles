return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = "all",
        modules = {},
        sync_install = false,
        auto_install = true,
        ignore_install = { "ipkg" },
        highlight = {
          enable = true,
          custom_captures = {},
        },
        indent = {
          enable = true,
          disable = { "yaml", "python" },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>si",
            scope_incremental = "<C-s>",
            node_incremental = "<C-j>",
            node_decremental = "<C-k>",
          },
        },
        disable = function(lang, buf)
          local max_filesize = 100 * 1024
          local ok, stats =
            pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then return true end
        end,
        matchup = {
          enable = true,
        },
        textobjects = {
          -- TODO Set up movement and more objects
          -- https://ofirgall.github.io/learn-nvim/chapters/05-text-objects.html
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = {
                query = "@class.inner",
                desc = "Select inner part of a class region",
              },
              ["as"] = {
                query = "@local.scope",
                query_group = "locals",
                desc = "Select language scope",
              },
              ["aB"] = "@frame.outer",
              ["iB"] = "@frame.inner",
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "<c-v>",
            },
            include_surrounding_whitespace = function(context)
              return context.query_string:match("%.outer$")
            end,
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false,
    },
    init = function() vim.g.skip_ts_context_commentstring_module = true end,
  },
  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>j",
        ":TSJToggle<CR>",
        desc = "Join/split block",
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
    },
  },
  { "RRethy/nvim-treesitter-endwise" },
}
