return {
  {
    "rachartier/tiny-devicons-auto-colors.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
    event = "VeryLazy",
  },
  {
    "sindrets/diffview.nvim",
    opts = {
      view = {
        merge_tool = {
          layout = "diff4_mixed",
          disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
          winbar_info = false, -- See |diffview-config-view.x.winbar_info|
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "tadaa/vimade",
    opts = {
      recipe = { "default", { animate = false } },
      ncmode = "buffers",
      fadelevel = 0.6,
      tint = {},
      blocklist = {
        default = {
          highlights = {
            laststatus_3 = function(win, active)
              if vim.go.laststatus == 3 then return "StatusLine" end
            end,
            "TabLineSel",
            "Pmenu",
            "PmenuSel",
            "PmenuKind",
            "PmenuKindSel",
            "PmenuExtra",
            "PmenuExtraSel",
            "PmenuSbar",
            "PmenuThumb",
          },
          buf_opts = { buftype = { "prompt" } },
        },
        default_block_floats = function(win, active)
          return win.win_config.relative ~= ""
              and (win ~= active or win.buf_opts.buftype == "terminal")
              and true
            or false
        end,
        link = {},
        groupdiff = true,
        groupscrollbind = false,
        enablefocusfading = false,
        checkinterval = 1000,
        usecursorhold = false,
        nohlcheck = true,
        focus = {
          providers = {
            filetypes = {
              default = {
                { "mini", {} },
                {
                  "treesitter",
                  {
                    min_node_size = 2,
                    min_size = 1,
                    max_size = 0,
                    exclude = {
                      "script_file",
                      "stream",
                      "document",
                      "source_file",
                      "translation_unit",
                      "chunk",
                      "module",
                      "stylesheet",
                      "statement_block",
                      "block",
                      "pair",
                      "program",
                      "switch_case",
                      "catch_clause",
                      "finally_clause",
                      "property_signature",
                      "dictionary",
                      "assignment",
                      "expression_statement",
                      "compound_statement",
                    },
                  },
                },
                {
                  "blanks",
                  {
                    min_size = 1,
                    max_size = "35%",
                  },
                },
                {
                  "static",
                  {
                    size = "35%",
                  },
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
  },
  {
    "max397574/colortils.nvim",
    opts = {},
  },
  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
      view = {
        display_mode = "border",
        header_lnum = 1,
        sticky_header = {
          enabled = true,
          separator = "─",
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("BufRead", {
        pattern = "*.[tc]sv",
        callback = function()
          vim.cmd("CsvViewEnable")
          vim.o.wrap = false
        end,
      })
    end,
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
  {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {},
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      hint_enable = false,
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*:?]],
        keyword = "bg",
      },
      search = {
        command = "rg",
        -- BUG https://github.com/folke/todo-comments.nvim/issues/371
        -- args = {
        --   "--color=never",
        --   "--no-heading",
        --   "--with-filename",
        --   "--line-number",
        --   "--column",
        --   "--",
        -- },
        pattern = [[(?:--|//|/\*|#|;):? \b(KEYWORDS)\b]],
      },
    },
  },
  {
    "kylechui/nvim-surround",
    config = true,
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        override_vim_notify = true, -- Automatically override vim.notify() with Fidget
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {},
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        lazy = true,
      },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function() vim.g.db_ui_use_nerd_fonts = 1 end,
  },
  {
    "ph1losof/ecolog.nvim",
    keys = {
      -- { "<leader>ge", "<cmd>EcologGoto<cr>", desc = "Go to env file" },
      -- { "<leader>ep", "<cmd>EcologPeek<cr>", desc = "Ecolog peek variable" },
      -- { "<leader>es", "<cmd>EcologSelect<cr>", desc = "Switch env file" },
    },
    -- Lazy loading is done internally
    lazy = false,
    opts = {
      load_shell = true,
      integrations = {
        blink_cmp = true,
      },
      -- Enables shelter mode for sensitive values
      shelter = {
        configuration = {
          -- Partial mode configuration:
          -- false: completely mask values (default)
          -- true: use default partial masking settings
          -- table: customize partial masking
          -- partial_mode = false,
          -- or with custom settings:
          partial_mode = {
            show_start = 3, -- Show first 3 characters
            show_end = 3, -- Show last 3 characters
            min_mask = 3, -- Minimum masked characters
          },
          mask_char = "*", -- Character used for masking
          mask_length = nil, -- Optional: fixed length for masked portion (defaults to value length)
          skip_comments = false, -- Skip masking comment lines in environment files (default: false)
        },
        modules = {
          cmp = false,
          peek = false,
          files = false,
          telescope = false,
          telescope_previewer = false,
        },
      },
      -- true by default, enables built-in types (database_url, url, etc.)
      types = true,
      path = vim.fn.getcwd(), -- Path to search for .env files
      preferred_environment = "development", -- Optional: prioritize specific env files
      -- Controls how environment variables are extracted from code and how cmp works
      provider_patterns = true, -- true by default, when false will not check provider patterns
    },
  },
  { "kevinhwang91/nvim-fundo" },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10, -- Needs to be a really low priority, to catch others plugins keybindings.
    config = true,
  },
  {
    "andre-kotake/nvim-chezmoi",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    opts = {
      -- Show extra debug messages.
      edit = {
        -- Automatically apply file on save. Can be one of: "auto", "confirm" or "never"
        apply_on_save = "auto",
      },
    },
    config = function(_, opts) require("nvim-chezmoi").setup(opts) end,
  },

  -- Vim plugins
  { "simeji/winresizer" },
  { "tpope/vim-repeat" },
  { "tpope/vim-abolish" },
  { "tpope/vim-characterize" },
  {
    "glts/vim-radical",
    dependencies = {
      "glts/vim-magnum",
    },
    keys = {
      {
        "gA",
        "<Plug>RadicalView",
        mode = { "n", "x" },
        desc = "Show decimal, hex, octal, binary number representations",
      },
      {
        "crd",
        "<Plug>RadicalCoerceToDecimal",
        mode = "n",
        desc = "Coerce to decimal",
      },
      {
        "crx",
        "<Plug>RadicalCoerceToHex",
        mode = "n",
        desc = "Coerce to hex",
      },
      {
        "cro",
        "<Plug>RadicalCoerceToOctal",
        mode = "n",
        desc = "Coerce to octal",
      },
      {
        "crb",
        "<Plug>RadicalCoerceToBinary",
        mode = "n",
        desc = "Coerce to binary",
      },
    },
  },
  {
    "rhysd/clever-f.vim",
    init = function()
      vim.g.clever_f_timeout_ms = 1
      vim.g.clever_f_highlight_timeout_ms = 3000
      vim.g.clever_f_across_no_line = 1
    end,
  },
  {
    "lambdalisue/suda.vim",
    init = function() vim.g.suda_smart_edit = 1 end,
  },
  { "kshenoy/vim-signature" },
  { "dhruvasagar/vim-table-mode" },
  { "romainl/vim-cool" },
  { "dstein64/vim-startuptime" },
  {
    "instant-markdown/vim-instant-markdown",
    init = function()
      vim.g.instant_markdown_autostart = 0
      vim.g.instant_markdown_browser = "qutebrowser"
    end,
  },
  { "https://github.com/tommcdo/vim-exchange" },
}
