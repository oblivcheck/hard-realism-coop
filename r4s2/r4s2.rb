require 'websocket-eventmachine-client'
require 'json'
require 'colorize'
require './r4s2/config.rb'
require './r4s2/cli.rb'
require './r4s2/shell.rb'
require './r4s2/module.rb'
require './r4s2/message.rb'
# require './r4s2/sync.rb'
require './r4s2/server.rb'

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
$data = nil

if shell_are_you_ready?
  msg_print("Ready.", :red)
else return
end

begin

Receive.listen
Control.listen

EM.run do
  address = Config.onebot_address
  port = Config.onebot_port("wsv")
  ws = WebSocket::EventMachine::Client.connect(uri: "ws://#{address}:#{port}")

  ws.onopen do
    msg_print("已经连接至 ws://#{address}:#{port}", :blue)
  end

  # Msg2qq::Acceptinput.thread(ws)
  # GroupFileSync.sync(ws)
  # puts "#{info}"
  ws.onmessage do |msg, type|
    data = JSON.parse(msg)
    if (data["post_type"] == "meta_event")
      if (data["meta_event_type"] == "heartbeat" )
        next
      end
    end
    puts JSON.pretty_generate(data)
    if (data["post_type"] == "message")
      begin
        msg = handle_msg(data)
        if (msg != nil)
          ws.send "#{msg}"
        end
      rescue => e
        # Todo: 捕获异常并处理
        msg_print(e.message, :light_red)
      end
    end
  end

  ws.onclose do |code, reason|
    msg_print("连接已关闭: #{reason}(#{code})", :light_red);
  end

end

rescue Interrupt
  msg_print("退出...", :light_red);
  exit
end
