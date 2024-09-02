require './r4s2/cli.rb'

def shell_are_you_ready?
  msg_print("Shell Are You Ready?", :light_blue);
  if system("mkdir -p #{Config.path_all(false)} #{Config.path_all(true)}")
    return true
  end
  msg_print("初始化Shell脚本依赖时发生错误", :red)
  return false
end
