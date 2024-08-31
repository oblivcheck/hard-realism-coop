require './r4s2/cli.rb'

def shell_are_you_ready?
  msg_print("Shell Are You Ready?", :light_blue);
  root = '/tmp/r4s2'
  paths = {
    'onebot_address' => Config.onebot_address,
    'onebot_port_http' => Config.onebot_port("http"),
    'onebot_port_wsv' => Config.onebot_port("wsv"),
    'target_group' => Config.group_id,
    'rc_shellpath' => Config.path_rc('true'),
    'rc_tmpfpath' => Config.path_rc('false'),
    'mpds_shellpath' => Config.path_mpds('true'),
    'mpds_tmpfpath' => Config.path_mpds('false'),
    'all_servers_shellpath' => Config.path_all('true'),
    'all_servers_tmpfpath' => Config.path_all('false')
  }

  dir = [
    Config.path_rc('false') + '/ServerInfoCollector/images/',
    Config.path_mpds('false') + '/ServerInfoCollector/images/',
    Config.path_all('false')
  ]

  dir.each do |dir|
    puts "#{dir}"
    # Todo: 重新整理
    Dir.mkdir(dir, 0755) unless Dir.exist?(dir)
  end

  paths.each do |file_name, content|
    file_path = "#{root}/#{file_name}"
    File.open(file_path, 'w') do |file|
      file.write(content)
    end
  end

  true
rescue => e
  msg_print("初始化Shell脚本依赖时发生错误: #{e.message}", :red)
  false
end
