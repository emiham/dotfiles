require("session"):setup({
  sync_yanked = true,
})

require("git"):setup()

Status:children_add(function()
  local h = cx.active.current.hovered
  if not h then return nil
  else
    return ui.Line({
      ui.Span(os.date("%Y-%m-%d %H:%M", tostring(h.cha.mtime):sub(1, 10)))
      :fg("blue"),
      ui.Span(" "),
    })
  end
end, 500, Status.RIGHT)
