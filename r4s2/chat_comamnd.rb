def handeler_chat_command(args, qq_id)
  target_group = `cat /tmp/r4s2/target_group`

  case args.strip
  when "地址"
    system("echo #{qq_id} > /tmp/r4s2/qq_id");
    system("bash shell/dizhi.sh");
  when "服务器"
    system("echo #{qq_id} > /tmp/r4s2/qq_id");
    system("bash shell/all-servers.sh");
  else
    system("bash shell/msg2qq.sh -g -t \"#{target_group}\" -s  \"[@群三方 服务器]\n获取服务器信息\n\n[@群三方 地址]\n获取服务器现在的IP，并给出控制台命令\n\n\n[自助上传地图]\n目前仅对纯净#11#12服务器有效\n请将文件移动到群文件的对应文件夹中\n可以直接上传.vpk文件，也支持打包了多个vpk的.zip或.7z压缩包\n!!注意，上传的文件名中不能存在空格，否则将无法识别或出现问题\"")

  end
end
