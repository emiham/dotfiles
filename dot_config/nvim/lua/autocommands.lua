local config_home = os.getenv("XDG_CONFIG_HOME")
  or (os.getenv("HOME") .. "/.config")

local view_group = vim.api.nvim_create_augroup("auto_view", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
  desc = "Save view with mkview for real files",
  group = view_group,
  callback = function(args)
    if vim.b[args.buf].view_activated then
      vim.cmd.mkview({ mods = { emsg_silent = true } })
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Try to load file view if available and enable view saving for real files",
  group = view_group,
  callback = function(args)
    if not vim.b[args.buf].view_activated then
      local filetype =
        vim.api.nvim_get_option_value("filetype", { buf = args.buf })
      local buftype =
        vim.api.nvim_get_option_value("buftype", { buf = args.buf })
      local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }
      if
        buftype == ""
        and filetype
        and filetype ~= ""
        and not vim.tbl_contains(ignore_filetypes, filetype)
      then
        vim.b[args.buf].view_activated = true
        vim.cmd.loadview({ mods = { emsg_silent = true } })
      end
    end
  end,
})

vim.api.nvim_create_augroup("nvim_swapfile", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "/home/emil/code/dotfiles" .. "/waybar/*",
  callback = function()
    vim.fn.jobstart({ "pkill", "-SIGUSR2", "waybar" }, { detach = true })
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "**/xremap/config.yml" },
  callback = function()
    vim.fn.jobstart(
      { "systemctl", "--user", "restart", "xremap" },
      { detach = true }
    )
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "/etc/systemd/system/*.*",
  callback = function()
    vim.fn.jobstart({ "sudo", "systemctl", "daemon-reload" }, {
      stdout_buffered = true,
      stderr_buffered = true,
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.fn.expand(config_home .. "/systemd/user/*.*"),
  callback = function()
    vim.fn.jobstart({ "systemctl", "--user", "daemon-reload" }, {
      stdout_buffered = true,
      stderr_buffered = true,
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "tmux.conf" },
  callback = function()
    vim.fn.jobstart({
      "tmux",
      "source-file",
      config_home .. "/tmux/tmux.conf",
    }, { detach = true })
  end,
})

-- Reload once after first save if the file was empty/new when opened.
local grp =
  vim.api.nvim_create_augroup("ReloadNewEmptyOnFirstSave", { clear = true })

-- Mark buffers that were empty at open (new file or zero-byte file)
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = grp,
  callback = function(args)
    local buf = args.buf
    if args.event == "BufNewFile" then
      vim.b[buf].reload_on_first_write = true
    else
      local lc = vim.api.nvim_buf_line_count(buf)
      local first = (vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or "")
      vim.b[buf].reload_on_first_write = (lc == 1 and first == "")
    end
    vim.b[buf].reloaded_after_first_write = false
  end,
})

-- On first write, reload with nested autocommands so filetype detection runs
vim.api.nvim_create_autocmd("BufWritePost", {
  group = grp,
  nested = true, -- critical: allow :edit! to trigger BufRead*/FileType
  callback = function(args)
    local buf = args.buf
    if
      vim.b[buf].reload_on_first_write
      and not vim.b[buf].reloaded_after_first_write
    then
      vim.b[buf].reloaded_after_first_write = true
      vim.cmd("edit!") -- re-read from disk
      vim.cmd("silent! filetype detect") -- belt-and-suspenders
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Disable spell only in floating windows
    local win = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then vim.opt_local.spell = false end
  end,
})
