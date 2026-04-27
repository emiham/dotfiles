vim.pack.add({ "https://github.com/ph1losof/ecolog.nvim" })

require("ecolog").setup({
  load_shell = true,
  integrations = {
    blink_cmp = true,
  },
  -- Enables shelter mode for sensitive values
  shelter = {
    configuration = {
      -- Partial mode configuration
      partial_mode = {
        show_start = 3, -- Show first 3 characters
        show_end = 3, -- Show last 3 characters
        min_mask = 3, -- Minimum masked characters
      },
      mask_char = "*", -- Character used for masking
      mask_length = nil, -- Optional: fixed length for masked portion
      skip_comments = false, -- Skip masking comment lines
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
  -- Controls how environment variables are extracted from code
  provider_patterns = true,
})
