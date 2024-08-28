require 'websocket-eventmachine-client'
require 'json'
require 'colorize'
require './r4s2/cli.rb'
require './r4s2/config.rb'
require './r4s2/shell.rb'
require './r4s2/message.rb'

banners = <<-ART.strip
######                         #       
#     # #    # #####  #   #    #    #  
#     # #    # #    #  # #     #    #  
######  #    # #####    #      #    #  
#   #   #    # #    #   #      ####### 
#    #  #    # #    #   #           #  
#     #  ####  #####    #           #  
ART
bannere = <<-ART.strip
 #####                                  #####  
#     # #    # ###### #      #         #     # 
#       #    # #      #      #               # 
 #####  ###### #####  #      #          #####  
      # #    # #      #      #         #       
#     # #    # #      #      #         #       
 #####  #    # ###### ###### ######    ####### 
ART

puts "#{banners}".colorize(:light_magenta)
puts "#{bannere}".colorize(:green)

if shell_are_you_ready?
  msg_print("Ready.", :red)
else return
end

begin

EM.run do
  address = Config.onebot_address
  port = Config.onebot_port("wsv")
  ws = WebSocket::EventMachine::Client.connect(uri: "ws://#{address}:#{port}")

  ws.onopen do
    msg_print("已经连接至 ws://#{address}:#{port}", :blue)
  end

  ws.onmessage do |msg, type|
    data = JSON.parse(msg)

    if (data["post_type"] == "meta_event")
      if (data["meta_event_type"] != "heartbeat" )
        next
      end
    end
    if (data["post_type"] == "message")
      begin
        handle_msg(data)
      rescue => e
        # 捕获异常并处理
        msg_print(e.message, :light_red)
      end
    end
  end

  ws.onclose do |code, reason|
    msg_print("连接已关闭: #{reason}(#{code})", :light_red);
  end

  EventMachine.next_tick do
    ws.send "Hello！"
  end
end

rescue Interrupt
  msg_print("退出...", :light_red);
  exit
end
