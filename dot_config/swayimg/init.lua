swayimg.mode = "viewer"
swayimg.antialiasing = false
swayimg.decoration = false
swayimg.overlay = false
swayimg.exif_orientation = true
swayimg.dnd_button = "MouseRight"

swayimg.imagelist.order = "alpha"
swayimg.imagelist.reverse = false
swayimg.imagelist.recursive = false
swayimg.imagelist.adjacent = true
-- swayimg.imagelist.enable_fsmon(true) -- enable file system monitoring

swayimg.text.font = "monospace"
swayimg.text.size = 14
-- swayimg.text.spacing = 0
swayimg.text.padding = 10
swayimg.text.color = 0xffd0d0d0
swayimg.text.background = 0x00000000
swayimg.text.shadow = 0x0d000000
swayimg.text.timeout = 5
swayimg.text.status_timeout = 3
swayimg.text.visible = false

-- Image viewer mode
swayimg.viewer.default_scale = "optimal"
swayimg.viewer.default_position = "center"
swayimg.viewer.drag_button = "MouseLeft"
swayimg.viewer.set_window_background(0xff3a3a3a)
swayimg.viewer.set_image_chessboard(20, 0xff3a3a3a, 0xff4e4e4e)
swayimg.viewer.autocenter = true
swayimg.viewer.loop = true
swayimg.viewer.preload = 3
-- swayimg.viewer.history = 1
swayimg.viewer.mark_color = 0xff808080
swayimg.viewer.set_text("topleft", {
  "File: {name}",
  "Path: {path}",
  "Format: {format}",
  "File size: {sizehr}",
  "File time: {time}",
  "EXIF date: {meta.Exif.Photo.DateTimeOriginal}",
  "EXIF camera: {meta.Exif.Image.Model}",
})
swayimg.viewer.set_text("topright", {
  "Image: {list.index} of {list.total}",
  "Frame: {frame.index} of {frame.total}",
  "Size: {frame.width}x{frame.height}",
})
swayimg.viewer.set_text("bottomleft", { "Scale: {scale}" })

local function zoom(factor)
  local pos = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.scale
  swayimg.viewer.set_abs_scale(scale * (1 + factor), pos.x, pos.y)
end

-- rotate image
swayimg.viewer.on_key("]", function() swayimg.viewer.rotate(90) end)
swayimg.viewer.on_key("[", function() swayimg.viewer.rotate(270) end)

-- flip image
swayimg.viewer.on_key("m", function() swayimg.viewer.flip_vertical() end)
swayimg.viewer.on_key(
  "Shift+m",
  function() swayimg.viewer.flip_horizontal() end
)

swayimg.slideshow.timeout = 5
swayimg.slideshow.default_scale = "fit"
swayimg.slideshow.set_window_background("auto")
swayimg.slideshow.history = 0
swayimg.slideshow.set_text("topleft", { "{name}" }) -- top left text block scheme

swayimg.gallery.aspect = "fill"
swayimg.gallery.thumb_size = 300
swayimg.gallery.padding_size = 5
swayimg.gallery.border_size = 5
swayimg.gallery.border_color = 0xffaaaaaa
swayimg.gallery.selected_scale = 1.15
swayimg.gallery.selected_color = 0xff404040
swayimg.gallery.unselected_color = 0xff202020
swayimg.gallery.window_color = 0xff3a3a3a
swayimg.gallery.cache = 0
swayimg.gallery.preload = false
swayimg.gallery.pstore = false
swayimg.gallery.set_text("topleft", { "File: {name}" })
swayimg.gallery.set_text("topright", { "{list.index} of {list.total}" })

swayimg.gallery.on_key("Return", function() swayimg.mode = "viewer" end)
swayimg.gallery.on_key("Left", function() swayimg.gallery.select("left") end)

-- force set scale mode on window resize (useful for tiling compositors)
swayimg.on_window_resize(function()
  if swayimg.mode ~= "gallery" then swayimg.fix_scale = "optimal" end
end)

swayimg.gallery.on_image_change(function()
  local image = swayimg.gallery.get_image() or "no image"
  swayimg.title = "Gallery: " .. image.path
end)

-- stylua: ignore start
swayimg.viewer.on_key("j", function() swayimg.viewer.open("next") end)
swayimg.viewer.on_key("k", function() swayimg.viewer.open("prev") end)
swayimg.viewer.on_key("Space", function() swayimg.viewer.open("next") end)
swayimg.viewer.on_key("n", function() swayimg.viewer.open("next") end)
swayimg.viewer.on_key("p", function() swayimg.viewer.open("prev") end)

swayimg.viewer.on_key("Shift-j", function() swayimg.viewer.open("next_dir") end)
swayimg.viewer.on_key("Shift-k", function() swayimg.viewer.open("prev_dir") end)

swayimg.viewer.on_key("g", function() swayimg.viewer.open("first") end)
swayimg.viewer.on_key("Shift-g", function() swayimg.viewer.open("last") end)

function trash_image()
  local image = swayimg[swayimg.mode].get_image()
  local escaped_path = "'" .. image.path .. "'"
  os.execute("trash-put " .. escaped_path)
  swayimg.text.status = "File " .. image.path .. " trashed"
end

swayimg.viewer.on_key("a", function() swayimg.antialiasing = not swayimg.antialiasing end)
swayimg.viewer.on_key("Plus", function() zoom(0.1) end)
swayimg.viewer.on_key("Minus", function() zoom(-0.1) end)

swayimg.viewer.on_mouse("Ctrl-ScrollUp", function() zoom(0.1) end)
swayimg.viewer.on_mouse("Ctrl-ScrollDown", function() zoom(-0.1) end)

swayimg.viewer.on_key("backspace", function()
  swayimg.viewer.reset()
end)

swayimg.viewer.on_key("Escape", function() swayimg.mode = "gallery" end)

swayimg.gallery.on_key("h", function() swayimg.gallery.select("left") end)
swayimg.gallery.on_key("j", function() swayimg.gallery.select("down") end)
swayimg.gallery.on_key("k", function() swayimg.gallery.select("up") end)
swayimg.gallery.on_key("l", function() swayimg.gallery.select("right") end)
swayimg.gallery.on_key("g", function() swayimg.gallery.select("first") end)
swayimg.gallery.on_key("Shift-g", function() swayimg.gallery.select("last") end)
swayimg.gallery.on_key("Ctrl-u", function() swayimg.gallery.select("pgup") end)
swayimg.gallery.on_key("Ctrl-d", function() swayimg.gallery.select("pgdown") end)
swayimg.gallery.on_key("Return", function() swayimg.mode = "viewer" end)
swayimg.gallery.on_key("Ctrl-p", function()
  -- print paths to all marked files
  local entries = swayimg.imagelist.get()
  for _, entry in ipairs(entries) do
    if entry.mark then print(entry.path) end
  end
end)

for _, mode in ipairs({"viewer", "gallery"}) do
  swayimg[mode].on_key("i", function() swayimg.text.visible = not swayimg.text.visible end)
  swayimg[mode].on_key("Shift+d", function() trash_image() end)
  swayimg[mode].on_key("q", function() swayimg.exit() end)
end

swayimg.gallery.on_key("Shift+r", function()
  if swayimg.imagelist.recursive then
    local cwd = io.popen("pwd -P"):read("*l")
    local escaped_cwd = cwd:gsub("([%^%$%%%.%*%+%-%?%[%]])", "%%%1")

    local current_images = swayimg.imagelist.get()
    local targets_to_remove = {}

    for _, item in ipairs(current_images) do
      if item.path and item.path:match('^' .. escaped_cwd .. '/.+/.+') then
        table.insert(targets_to_remove, item.path)
      end
    end

    swayimg.imagelist.remove(targets_to_remove)
  else
    swayimg.imagelist.add(".")
  end
  swayimg.imagelist.recursive = not swayimg.imagelist.recursive
end)
