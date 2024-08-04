require 'websocket-eventmachine-client'
require 'json'
require './handle_msg.rb'

EM.run do

  ws = WebSocket::EventMachine::Client.connect(:uri => 'ws://10.10.10.100:5800')

  ws.onopen do
    puts "\e[31m已连接\e[0m"
  end

  ws.onmessage do |msg, type|
    data = JSON.parse(msg)

    if (data["post_type"] == "meta_event")
      if (data["meta_event_type"] == "heartbeat" )
        next
      end
    end

#    puts "原始数据: #{msg}"
    handle_msg(data)
  end

  ws.onclose do |code, reason|
    puts "\e[31m退出代码: #{code}\e[0m"
  end

  EventMachine.next_tick do
    ws.send "Hello！"
  end
end
