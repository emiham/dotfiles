require("session"):setup({
  sync_yanked = true,
})

require("git"):setup()

Status:children_add(function()
  local h = cx.active.current.hovered
  if not h then
    return nil
  else
    return ui.Line({
      ui.Span(os.date("%Y-%m-%d %H:%M", tostring(h.cha.mtime):sub(1, 10)))
        :fg("blue"),
      ui.Span(" "),
    })
  end
end, 500, Status.RIGHT)

require("mime-ext.local"):setup({
  -- Expand the existing filename database (lowercase), for example:
  with_files = {
    makefile = "text/makefile",
    -- ...
  },

  -- Expand the existing extension database (lowercase), for example:
  with_exts = {
    mk = "text/makefile",
    -- ...
  },

  -- If the MIME type is not in both filename and extension databases,
  -- then fallback to Yazi's preset `mime.local` plugin, which uses `file(1)`
  fallback_file1 = false,
})
