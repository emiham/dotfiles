vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

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
  disable = function(lang, buf)
    local max_filesize = 100 * 1024
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
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
