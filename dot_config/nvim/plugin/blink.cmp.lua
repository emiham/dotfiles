vim.pack.add({
  "https://github.com/Kaiser-Yang/blink-cmp-git",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/ribru17/blink-cmp-spell",
  "https://github.com/brenoprata10/nvim-highlight-colors",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.x"),
  },
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "blink.cmp" and kind == "update" then
      vim.cmd("BlinkCmp build")
    end
  end,
})

require("nvim-highlight-colors").setup({
  enable_var_usage = true,
  formatting = {
    format = require("nvim-highlight-colors").format,
  },
  custom_colors = {
    -- { label = "white", color = "#d0d0d0" },
    -- { label = "black", color = "#4e4e4e" },
    -- { label = "red", color = "#d68787" },
    -- { label = "green", color = "#5f865f" },
    -- { label = "yellow", color = "#d8af5f" },
    -- { label = "blue", color = "#85add4" },
    -- { label = "magenta", color = "#d7afaf" },
    -- { label = "cyan", color = "#87afaf" },
    -- { label = "white", color = "#d0d0d0" },
  },
})

require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
    ["<Down>"] = { "snippet_forward", "select_next", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
    ["<Up>"] = { "snippet_backward", "select_prev", "fallback" },
    ["<Return>"] = { "accept", "fallback" },
    ["<Left>"] = { "snippet_forward" },
    ["<Right>"] = { "snippet_backward" },

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
    menu = {
      draw = {
        components = {
          -- customize the drawing of kind icons
          kind_icon = {
            text = function(ctx)
              -- default kind icon
              local icon = ctx.kind_icon
              -- if LSP source, check for color derived from documentation
              if ctx.item.source_name == "LSP" then
                local color_item = require("nvim-highlight-colors").format(
                  ctx.item.documentation,
                  { kind = ctx.kind }
                )
                if color_item and color_item.abbr ~= "" then
                  icon = color_item.abbr
                end
              end
              return icon .. ctx.icon_gap
            end,
            highlight = function(ctx)
              -- default highlight group
              local highlight = "BlinkCmpKind" .. ctx.kind
              -- if LSP source, check for color derived from documentation
              if ctx.item.source_name == "LSP" then
                local color_item = require("nvim-highlight-colors").format(
                  ctx.item.documentation,
                  { kind = ctx.kind }
                )
                if color_item and color_item.abbr_hl_group then
                  highlight = color_item.abbr_hl_group
                end
              end
              return highlight
            end,
          },
        },
      },
    },
  },
  snippets = { preset = "luasnip" },
})
