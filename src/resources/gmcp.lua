local GMCP = {}

function GMCP.chatCapture()
  local t = gmcp.Comm.Channel.Text

  local event = {
    channel = t.channel,
    sender = t.talker,
    text = t.text:gsub("<r><%w+,%w+,%w+:>", ""),
    decho = ansi2decho(t.text)
  }

  raiseEvent("outpost.chat", event)
end

function GMCP.updatePlayers()
end

function GMCP.addPlayer()
end

function GMCP.removePlayer()
end

function GMCP.init()
  registerAnonymousEventHandler("gmcp.Comm.Channel.Text", GMCP.chatCapture)

  registerAnonymousEventHandler("gmcp.Room.Player", GMCP.updatePlayers)
  registerAnonymousEventHandler("gmcp.Room.AddPlayer", GMCP.addPlayer)
  registerAnonymousEventHandler("gmcp.Room.RemovePlayer", GMCP.removePlayer)

  gmod.enableModule("outpost", "Comm.Channel")
end

return GMCP