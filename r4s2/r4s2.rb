require 'websocket-eventmachine-client'
require 'json'
require 'colorize'
require './r4s2/cli.rb'
require './r4s2/config.rb'
require './r4s2/preshell.rb'
require './r4s2/chat_command.rb'
require './r4s2/message.rb'

EM.run do
  address = Config.onebot_address
  port = Config.onebot_port
  ws = WebSocket::EventMachine::Client.connect(uri: "ws://#{address}:#{port}")

  ws.onopen do
    msg_print("已经连接至 ws://#{address}:#{port}", :blue)
  end

  ws.onmessage do |msg, type|
    data = JSON.parse(msg)

    if (data["post_type"] == "meta_event")
      if (data["meta_event_type"] == "heartbeat" )
        next
      end
    end
    handle_msg(data)
  end

  ws.onclose do |code, reason|
    msg_print("退出代码:#{code}", :red);
  end

  EventMachine.next_tick do
    ws.send "Hello！"
  end
end
