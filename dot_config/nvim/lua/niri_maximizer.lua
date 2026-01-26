local M = {}

--- Checks if the currently focused buffer belongs to a user-editable file
--- (i.e., not a terminal, quickfix list, or plugin sidebar).
-- @return boolean true if it's a user buffer, false otherwise.
function M.is_user_buffer()
  local current_buf = vim.api.nvim_win_get_buf(0)

  -- Check buftype (e.g., 'nofile', 'terminal', 'quickfix')
  local buftype = vim.api.nvim_buf_get_option(current_buf, "buftype")
  if buftype ~= "" then return false end

  -- Check filetype for common plugin windows
  local filetype = vim.api.nvim_buf_get_option(current_buf, "filetype")
  local utility_filetypes = {
    ["NvimTree"] = true, -- File explorers
    ["vista"] = true, -- Tagbar/outline plugins
    ["packer"] = true, -- Plugin managers
    ["TelescopePrompt"] = true, -- Command palettes
    ["dap-ui"] = true, -- Debugger UIs
    ["gitmessenger"] = true, -- Git plugins
    ["qf"] = true, -- Quickfix/location lists
  }

  if utility_filetypes[filetype] then return false end

  return true
end

--- Executes the Niri IPC check and maximization command asynchronously.
-- This function runs entirely in a non-blocking shell job.
function M.check_and_maximize_async(current_width)
  local socket_path = vim.fn.getenv("NIRI_SOCKET")

  if not socket_path or socket_path == "" then return end

  -- We combine the state check and the action into a single shell script
  -- to ensure the entire operation is non-blocking.
  local script = string.format(
    [[
        # 1. Check if the window is maximized (tile_size > 1000)
        # Using -T 1 timeout to prevent socat from hanging.
        IS_MAX=$(printf '"FocusedWindow"\n' | socat -T 1 STDIO "%s" 2>/dev/null | jq -r '.Ok.FocusedWindow.layout.tile_size[0] | if . > 1000 then "true" else "false" end')

        # 2. If it's NOT maximized, run the maximize command
        if [ "$IS_MAX" = "false" ]; then
            niri msg action maximize-column
        fi
    ]],
    socket_path
  )

  local job_options = {
    "sh",
    "-c",
    script,
  }

  local job_callbacks = {
    -- Process output line by line and show in messages
    on_stdout = function(_, data, name)
      for _, line in ipairs(data) do
        if line and #line > 0 then
          -- The shell script echoes messages with the desired prefix
          vim.cmd('echom "' .. line .. '"')
        end
      end
    end,
    on_exit = function(_, exit_code, _)
      if exit_code ~= 0 then
      end
    end,
  }

  -- Start the job asynchronously
  vim.fn.jobstart(job_options, job_callbacks)
end

--- Primary logic fired by WinEnter. Checks the current window width.
function M.check_and_maximize_if_narrow()
  -- Check the width of the currently focused window
  local window_width = vim.fn.winwidth(0)
  local max_width = 80 -- Target width threshold

  -- Heuristic 1: If the window is already wide enough, skip.
  if window_width >= max_width then return end

  -- Heuristic 2: Check if the focused window is a user buffer.
  if M.is_user_buffer() then
    -- The window is narrow and is a user buffer. Proceed to maximization.
    M.check_and_maximize_async(window_width)
  else
  end
end

--- Forces Neovim to equalize the size of all current splits.
function M.resize_splits()
  -- `wincmd =` forces all windows to have equal height/width.
  -- This ensures splits are balanced after any Neovim window resize event.
  vim.cmd("wincmd =")
end

--- Sets up the Autocmds.
function M.setup()
  -- Create an autocmd group to manage our listeners
  local niri_group =
    vim.api.nvim_create_augroup("NiriSplitMaximizerGroup", { clear = true })

  -- 1. Main logic: React to new splits by checking width and maximizing.
  -- We use WinEnter as it fires reliably when focus moves to a newly created window.
  vim.api.nvim_create_autocmd({ "WinEnter" }, {
    group = niri_group,
    callback = M.check_and_maximize_if_narrow,
    desc = "Maximize Niri window if focused Neovim split is too narrow",
  })

  -- 2. Resizing logic: Ensure splits are balanced after any Neovim window resize event.
  vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = niri_group,
    callback = M.resize_splits,
    desc = "Equalize split sizes after Neovim window resize",
  })
end

return M
