local M = {}

M.config = {
  timeout_ms = 1000,
}

local timer = vim.loop.new_timer()

local function clear_sticky_maps()
  pcall(vim.keymap.del, "n", ";")
  pcall(vim.keymap.del, "n", ",")
end

local function set_sticky_maps()
  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", ";", function() M.navigate("g;") end, opts)
  vim.keymap.set("n", ",", function() M.navigate("g,") end, opts)

  timer:stop()
  timer:start(
    M.config.timeout_ms,
    0,
    vim.schedule_wrap(function() clear_sticky_maps() end)
  )
end

M.navigate = function(command)
  -- Execute the actual change list jump
  -- We use pcall to catch "At start/end of changelist" errors gracefully
  local ok, err = pcall(vim.cmd, "normal! " .. command)

  if ok then
    set_sticky_maps()
  else
    -- Optional: clear maps if we hit the end of the list
    clear_sticky_maps()
    print(err:match("E%d+:?%s*(.*)"))
  end
end

function M.setup(user_config)
  M.config = vim.tbl_extend("force", M.config, user_config or {})

  -- Bind the initial triggers
  vim.keymap.set(
    "n",
    "g;",
    function() M.navigate("g;") end,
    { desc = "Sticky jump back" }
  )
  vim.keymap.set(
    "n",
    "g,",
    function() M.navigate("g,") end,
    { desc = "Sticky jump forward" }
  )
end

return M
