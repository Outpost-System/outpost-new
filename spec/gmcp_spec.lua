local gmcp = require('gmcp')

local function setGmcp(data)
  _G.gmcp = data
end

describe('gmcp', function ()
  it('should register events when init is called', function ()
    _G.gmod = {}
    stub(_G.gmod, "enableModule")
    stub(_G, "registerAnonymousEventHandler")

    gmcp.init()
    
    assert.stub(_G.registerAnonymousEventHandler).was.called_with("gmcp.Comm.Channel.Text", gmcp.chatCapture)
    assert.stub(_G.registerAnonymousEventHandler).was.called_with("gmcp.Room.Player", gmcp.updatePlayers)
    assert.stub(_G.registerAnonymousEventHandler).was.called_with("gmcp.Room.AddPlayer", gmcp.addPlayer)
    assert.stub(_G.registerAnonymousEventHandler).was.called_with("gmcp.Room.RemovePlayer", gmcp.removePlayer)

    assert.stub(_G.gmod.enableModule).was.called_with("outpost", "Comm.Channel")
  end)

  describe('chat events', function()
    _G.ansi2decho = spy.new(function (s)
      return s
    end)
    it('should capture chat events', function ()
      setGmcp({
        Comm={
          Channel={
            Text={
              channel="ct",
              text = "baz",
              talker = "bar"
            }
          }
        }
      })

      local event = {
        channel="ct",
        text = "baz",
        decho = "baz",
        sender = "bar"
      }

      stub(_G, "raiseEvent")

      gmcp.chatCapture()

      assert.stub(_G.raiseEvent).was.called_with("outpost.chat", match.same(event))
    end)


    it('should capture chat events', function ()
      setGmcp({
        Comm={
          Channel={
            Text={
              channel="gt",
              text = "foo",
              talker = "bar"
            }
          }
        }
      })

      local event = {
        channel="gt",
        text = "foo",
        decho = "foo",
        sender = "bar"
      }

      stub(_G, "raiseEvent")

      gmcp.chatCapture()

      assert.stub(_G.raiseEvent).was.called_with("outpost.chat", match.same(event))
    end)
  end)
end)