def handeler_chat_command(args, qq_id, is_array)
  target_group = Config.group_id
  if (is_array )
    case args[0]
      when "kick"
        puts "kick"
      when "rs"
        puts "rs"
      else
        info = <<-TEXT.strip
          [踢出玩家，直到服务器下一次重新启动]
          /kick 目标 原因
          "/kick 0 黑枪王"

          [重新启动目标服务器]
          /rs 服务器标识
          "/rs 12"

          [立即同步群内文件夹]
          /sync
        TEXT
        system("bash shell/msg2qq.sh -g -t \"#{target_group}\" -s \"$(cat config/commands.txt)\" ")
    end
  else
    case args.strip
    when "地址"
      system("echo #{qq_id} > /tmp/r4s2/qq_id")
      system("bash shell/dizhi.sh")
    when "服务器"
      system("echo #{qq_id} > /tmp/r4s2/qq_id")
      system("bash shell/msg2qq.sh -g -t \"#{target_group}\" -s \"[CQ:at,qq=#{qq_id}] 生成中...\" ")
      system("bash shell/all-servers.sh")
    else
      system("bash shell/msg2qq.sh -g -t \"#{target_group}\" -s \"$(cat config/info.txt)\" ")
    end
  end
end
