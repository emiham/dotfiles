local function open_youtube_url()
  local filename = mp.get_property("filename")
  if not filename then return end

  local id =
    string.match(filename, "%[(" .. string.rep("[%w_%-]", 11) .. ")%]")

  if id then
    local url = "https://www.youtube.com/watch?v=" .. id
    mp.msg.info("Opening URL: " .. url)

    local platform = mp.get_property("platform")
    local args

    if platform == "windows" then
      args = { "cmd", "/c", "start", "", url }
    elseif platform == "darwin" then
      args = { "open", url }
    else
      args = { "xdg-open", url }
    end

    mp.command_native({
      name = "subprocess",
      args = args,
      detach = true,
    })
  else
    mp.osd_message("No valid YouTube ID found in brackets")
  end
end

mp.add_key_binding("y", "open-youtube-from-id", open_youtube_url)
