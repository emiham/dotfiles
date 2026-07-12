local function open_youtube_url()
  local filename = mp.get_property("filename")

  local id = string.match(filename, "%[(.-)%]")

  if id and #id == 11 then
    local url = "https://www.youtube.com/watch?v=" .. id
    mp.msg.info("Opening URL: " .. url)
    local platform = mp.get_property("platform")
    if platform == "windows" then
      mp.commandv("run", "cmd", "/c", "start", url)
    elseif platform == "darwin" then
      mp.commandv("run", "open", url)
    else
      mp.commandv("run", "xdg-open", url)
    end
  else
    mp.osd_message("No valid YouTube ID found in brackets")
  end
end

mp.add_key_binding("y", "open-youtube-from-id", open_youtube_url)
