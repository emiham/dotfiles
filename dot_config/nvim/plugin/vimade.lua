vim.pack.add({ "https://github.com/tadaa/vimade" })

require("vimade").setup({
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
})
