require './chat_comamnd.rb'
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

  data["message"].each do |obj|
    if (obj["data"] && obj["data"]["text"])
      msg += obj["data"]["text"] + " "
    end

    if (is_command)
      args = obj["data"]["text"] + " "
    end

    # 将位于AT之后的内容作为聊天命令类型&参数
    if (obj["type"] == "at" && !is_command)
      if (obj["data"]["qq"] == "3684951062")
        puts "检测为有效命令\n"
        is_command = true                 
      end
    end

    num+=1

  end

  if (is_command)
    handeler_chat_command(args, qq_id)
  end

  return msg  
end

def handle_private(data)  
    qq_id = data["user_id"]
    nickname = data["sender"]["nickname"]
    puts "\e[32m[私聊消息]\e[0m\n#{qq_id}|#{nickname}:#{get_msg(data, qq_id)}"
end

def handle_group(data)
    qq_id = data["user_id"]
    nickname = data["sender"]["nickname"]
    group_id = data["group_id"]
    puts "\e[32m{#{group_id}|群聊消息]\e[0m\n#{qq_id}|#{nickname}:#{get_msg(data, qq_id)}"
end
