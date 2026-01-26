return {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  version = "*",
  dependencies = {
    "Kaiser-Yang/blink-cmp-git",
    "rafamadriz/friendly-snippets",
    "ribru17/blink-cmp-spell",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
      ["<Return>"] = { "accept", "fallback" },

      ["<C-space>"] = {
        function(cmp) cmp.show({ providers = { "snippets" } }) end,
      },
    },
    cmdline = {
      keymap = {
        preset = "cmdline",
      },

      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
      },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    signature = {
      enabled = false,
      window = {
        show_documentation = true,
      },
    },

    sources = {
      default = {
        "lsp",
        "path",
        "buffer",
        "git",
        "snippets",
        "spell",
      },
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
        sql = { inherit_defaults = true, "dadbod" },
        python = { inherit_defaults = true, "ecolog" },
        sh = { inherit_defaults = true, "ecolog" },
        bash = { inherit_defaults = true, "ecolog" },
      },
      providers = {
        git = {
          module = "blink-cmp-git",
          name = "Git",
          enabled = function()
            return vim.tbl_contains(
              { "octo", "gitcommit", "markdown" },
              vim.bo.filetype
            )
          end,
          --- @module 'blink-cmp-git'
          --- @type blink-cmp-git.Options
          opts = {
            commit = {},
            git_centers = {
              github = {
                -- Those below have the same fields with `commit`
                -- Those features will be enabled when `git` and `gh` (or `curl`) are found and
                -- remote contains `github.com`
                issue = {
                  get_token = function() return "" end,
                },
                pull_request = {
                  get_token = function() return "" end,
                },
                -- mention = {
                --     get_token = function() return '' end,
                --     get_documentation = function(item)
                --         local default = require('blink-cmp-git.default.github')
                --             .mention.get_documentation(item)
                --         default.get_token = function() return '' end
                --         return default
                --     end
                -- }
              },
              gitlab = {
                -- Those below have the same fields with `commit`
                -- Those features will be enabled when `git` and `glab` (or `curl`) are found and
                -- remote contains `gitlab.com`
                -- issue = {
                --     get_token = function() return '' end,
                -- },
                -- NOTE:
                -- Even for `gitlab`, you should use `pull_request` rather than`merge_request`
                -- pull_request = {
                --     get_token = function() return '' end,
                -- },
                -- mention = {
                --     get_token = function() return '' end,
                --     get_documentation = function(item)
                --         local default = require('blink-cmp-git.default.gitlab')
                --            .mention.get_documentation(item)
                --         default.get_token = function() return '' end
                --         return default
                --     end
                -- }
              },
            },
          },
        },
        ecolog = {
          name = "ecolog",
          module = "ecolog.integrations.cmp.blink_cmp",
        },
        spell = {
          name = "Spell",
          module = "blink-cmp-spell",
          opts = {
            -- EXAMPLE: Only enable source in `@spell` captures, and disable it
            -- in `@nospell` captures.
            enable_in_context = function()
              local curpos = vim.api.nvim_win_get_cursor(0)
              local captures = vim.treesitter.get_captures_at_pos(
                0,
                curpos[1] - 1,
                curpos[2] - 1
              )
              local in_spell_capture = false
              for _, cap in ipairs(captures) do
                if cap.capture == "spell" then
                  in_spell_capture = true
                elseif cap.capture == "nospell" then
                  return false
                end
              end
              return in_spell_capture
            end,
          },
        },
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
    completion = {
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      menu = {},
    },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" },
}
