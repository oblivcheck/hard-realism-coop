class Message
  attr_reader :raw, 
  :sender, :sender_name, 
  :type, 
  :target, :target_name, 
  :at_me, 
  :is_command, :command,
  :text

  def initialize(raw)
    @raw = raw
    me = Config.onebot_qq
    # parsed = JSON.parse(raw)
    parsed = raw.is_a?(String) ? JSON.parse(raw) : raw
    @sender = parsed['user_id']
    puts "#{raw}"
    @sender_name = parsed["sender"]["nickname"]
    @type = parsed["message_type"]
    group = (@type == "group")
    if group
      @target = @raw["group_id"]
    else
      @target = @me
    end

    # 这条消息的Text段是否包含特定前缀
    num = 0
    @raw["message"].each do |obj|
      if (obj["data"] && obj["data"]["text"])
        msg = obj["data"]["text"]
        @text = msg
        if msg.start_with?(" /")
          msg = msg[2..-1]
          @is_command = true
        elsif msg.start_with?("/")
          msg = msg[1..-1]
          @is_command = true
        end
      end

      # 命令发送者不能是机器人自己
      if @sender == me
        @is_command = false
      end
      # 处理AT与消息类型
      if group
        if @target != Config.group_id
          @is_command = false          
        end
        if (obj["type"] == "at" || (num != 0 && obj["type"] == "text") )
          @at_me = true
        end        
      end
      # 传递命令
      if ( !group && @is_command || @at_me && @is_command )
        @command = msg
      end
    end
    num = num + 1
  end

end


def handle_msg(data)
  msg = Message.new(data)
  qq_id = msg.sender
  nickname = msg.sender_name
  if ( msg.type == "group")
    group_id = msg.target
    msg_print("[{#{group_id}|群聊消息] \n#{qq_id}|#{nickname}:#{msg.text}", qq_id == Config.onebot_qq ? :light_green : "")
    chat_command(msg.is_command ? msg.command : msg.text, qq_id, msg.is_command);
  else
    msg_print("[私聊消息] \n#{qq_id}|#{nickname}:#{msg.text}", "")
    # Todo: 处理受限命令
  end
end

# 自动转义换行符
def format(text)
  text.gsub("\n", "\\n")
end
# Todo: 封装为chatcommand
def chat_command(args, qq_id, is_command)
  target_group = Config.group_id
  puts "#{args}"
  if (is_command == true)
    args = args.split
    case args[0]
      when "kick"
        _ccmd_kick(qq_id, target_group, args)
      when "rs"
        _ccmd_restart(qq_id, target_group, args)
    else
      msg = format(File.read("config/commands.txt"))
      msg2qq(target_group, "#{msg}")
    end
  else
    case args
    when " 地址"
      system("echo #{qq_id} > /tmp/r4s2/qq_id")
      system("bash shell/dizhi.sh")
    when " 服务器"
      system("echo #{qq_id} > /tmp/r4s2/qq_id")
      msg2qq(target_group, "[CQ:at,qq=#{qq_id}] 生成中...")
      system("bash shell/all-servers.sh")      
    else
      msg = format(File.read("config/info.txt"))
      msg2qq(target_group, "#{msg}")
    end
  end
end

def msg2qq(target, msg)
  msg = format(msg)
  system("bash shell/msg2qq.sh -g -t \"#{target}\" -s \"#{msg}\" ")
end

def _ccmd_kick(qq_id, target_group, args)
  if args[1].nil?
    info = format(File.read("config/svtag.txt"))
    msg2qq(target_group, "/kick [目标服务器] [userid]\n\n#{info}")
    msg2qq(target_group, "[查询##1服务器中的玩家名称与userid]\n/kick r1")
  else
    if args[2].nil?
      msg2qq(target_group, "没有指定userid")  
      msg2qq(target_group, "[查询##1服务器中的玩家名称与userid]\n/kick r1")
      result = `./shell/rcon/rcon -c shell/rcon/rcon.yaml -e #{args[1]} status`
      # Todo: 默认提供一份完整的userid+name列表
      if result.include?("os      : Linux Dedicated")
        list_name = result.scan(/"([^"]+)"\s+STEAM/).flatten
        list_userid = result.scan(/STEAM\s+(\S+)/).flatten
        msg = "标识为 #{args[1]} 的服务器玩家列表(userid+name)\n\n"
        list_name.each_with_index do |name, index|
          msg = msg + "[#{index * 2 + 1}] #{name}\n"          
        end
        msg2qq(target_group, msg)
      end
    else
      # Note: 没有拓展的情况下，时长不为0的封禁仅在服务器未重启的情况下有效
      msg = `./shell/rcon/rcon -c shell/rcon/rcon.yaml -e #{args[1]} "sm_ban #{args[1]} 3600 \"REQ[#{target_group}-#{qq_id}] 由QQ群内踢出\""`
      msg2qq(target_group, "[CQ:at,qq=#{qq_id}]\n#{msg}")
    end
  end
end

def _ccmd_restart(qq_id, target_group, args)
  if args[1].nil?
    msg2qq(target_group, "/rs [目标服务器]\n\n[重启##1服务器]\n/rs r1")
  else
    msg = `./shell/rcon/rcon -c shell/rcon/rcon.yaml -e #{args[1]} status`
    restart_ready = false
    if msg.include?("os      : Linux Dedicated")
      if msg.include?(": 0 humans, 0 bots")
        # Todo: 捕获标准输出与标准错误输出，并获取状态码
        # Todo: 需要一份服务器序号与名称的对应表
        msg2qq(target_group, "正在尝试重启目标服务器...")
        msg = `./shell/rcon/rcon -c shell/rcon/rcon.yaml -e #{args[1]} "say \"REQ[#{qq_id}] 此服务器即将重启\""`
        sleep 3
        msg = `./shell/rcon/rcon -c shell/rcon/rcon.yaml -e #{args[1]} _restart`
        restart_ready = true
      else
        msg2qq(target_group, "无法重启服务器: 服务器中还有玩家")          
      end
    # Todo: 添加一个强制重启的功能(shell实现所用的方法)
    else
        msg = format(File.read("config/svtag.txt"))
        msg2qq(target_group, msg)                  
    end
    # 完成时进行提醒
    if restart_ready
      start_time = Time.now
      success = false
      while (Time.now - start_time) < 60
        msg = `./shell/rcon/rcon -c shell/rcon/rcon.yaml -e #{args[1]} status`
        # Note: 此处将阻塞直到回应或超时
        # Note: 消息是并行处理的
        if msg.include?("os      : Linux Dedicated")
          msg2qq(target_group, "[CQ:at,qq=#{qq_id}] 目标服务器已重启")        
          success = true
          break
        end
        sleep(3)
      end
      if !success
        timeout = Time.now - start_time
        msg2qq(target_group, "[CQ:at,qq=#{qq_id}] 重启失败？ 服务器响应超时(#{timeout}s)")      
      end
    end
  end
end
