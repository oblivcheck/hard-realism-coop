def handle_msg(data)
  if (data["post_type"] == "message")

    if (data["message_type"] == "private")
      handle_private(data)
    end
    if (data["message_type"] == "group")
      handle_group(data)
    end
  
  end
end

def get_msg(data, qq_id)
  msg = ""
  num = 0
  args = ""
  is_command = false
  args_is_array = true
  # obj: 某条消息
  data["message"].each do |obj|
    if (obj["data"] && obj["data"]["text"])
      msg += obj["data"]["text"] + " "
      if msg.start_with?(" /")
        msg = msg[2..-1]
      elsif msg.start_with?("/")
        msg = msg[1..-1]
      else
        args_is_array = false
      end
    end

    if (is_command)
      args = obj["data"]["text"] + " "
    end
    # data中的user_id是发送者
    if (obj["type"] == "at" && !is_command)
      if (obj["data"]["qq"] != Config.onebot_qq && data["user_id"] != Config.onebot_qq && data["group_id"] == Config.group_id)
        msg_print("AT标识", :red)
        is_command = true                 
      end
    end

    num+=1

  end

  if (is_command)
    handeler_chat_command(msg, qq_id, args_is_array)
  end

  return msg  
end

def handle_private(data)  
  qq_id = data["user_id"]
  nickname = data["sender"]["nickname"]
  msg_print("[私聊消息] \n#{qq_id}|#{nickname}:#{get_msg(data, qq_id)}", :green)
end

def handle_group(data)
  qq_id = data["user_id"]
  nickname = data["sender"]["nickname"]
  group_id = data["group_id"]
  msg_print("[{#{group_id}|群聊消息] \n#{qq_id}|#{nickname}:#{get_msg(data, qq_id)}", qq_id == Config.onebot_qq ? :light_green : :green)
end

