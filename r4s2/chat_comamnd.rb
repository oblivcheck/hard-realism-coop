def handeler_chat_command(args, qq_id)
  target_group = `cat /tmp/r4s2/target_group`

  case args.strip
  when "地址"
# system("bash shell/msg2qq.sh -t \"#{target_group}\" -g -s \"[CQ:at,qq=#{qq_id}]\n纯净服端口: 48001~48012\n尸潮服端口: 37000\"")
# 很奇怪
# message = "[CQ:at,qq=#{qq_id}] \n [CQ:at,qq=#{qq_id}] 纯净服端口: 48001~48012\n尸潮服端口: 37000"
# system("bash shell/msg2qq.sh -t \"#{target_group}\" -g -s \"#{message}\"")
    system("echo #{qq_id} > /tmp/r4s2/qq_id");
    system("bash shell/dizhi.sh");
  when "纯净"
    system("bash shell/msg2qq.sh -t \"#{target_group}\" -g -s \"[CQ:at,qq=#{qq_id}]\n 生成图片中...\"")
    system("bash shell/chunjing.sh");
  when "尸潮"
    system("bash shell/msg2qq.sh -t \"#{target_group}\" -g -s \"[CQ:at,qq=#{qq_id}]\n 生成图片中...\"")
    system("bash shell/shichao.sh");
  else
    system("bash shell/msg2qq.sh -g -t \"#{target_group}\" -s  \"[@群三方 尸潮]\n 获取多人尸潮服务器信息\n\n[@群三方 纯净]\n 获取纯净服务器信息\n\n[@群三方 地址]\n获取服务器现在的IP，并给出控制台命令\n\n\n[自助上传地图]\n目前仅对纯净#11#12服务器有效\n请将文件移动到群文件的对应文件夹中\n可以直接上传.vpk文件，也支持打包了多个vpk的.zip或.7z压缩包\n!!注意，上传的文件名中不能存在空格，否则将无法识别或出现问题\"")
  end
end
