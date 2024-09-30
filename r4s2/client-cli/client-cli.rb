require "socket"
require "digest"
require 'colorize'
require 'fileutils'
require 'cli/ui'

module Log
  def self.prefix
    Time.now.strftime('%Y-%m-%d %H:%M:%S')
  end
  def self.sv(info, level = -1)
    print "#{Log.prefix} ".colorize(:light_black)
    print "[服务器] ".colorize(:green)
    case level
    when -1
      print "#{info}\n"
    when 0
      print "#{info}\n".colorize(:red)
    when 1
      print "#{info}\n".colorize(:yellow)
    end
  end
  def self.cl(info, level = -1)
    print "#{Log.prefix} ".colorize(:light_black)
    print "[client-cli] \n".colorize(:green)
    case level
    when -1
      puts "#{info}"
    when 0
      puts "#{info}".colorize(:red)
    when 1
      puts "#{info}".colorize(:yellow)
    end
  end

end

def upload(file_path)
  socket = TCPSocket.new("tx.sayuri.city", 27243)
  name = File.basename(file_path)
  file_size = File.size(file_path)
  
  socket.puts "::sctest_greenflu/"
  if socket.gets != "_READY_\n"
    Log.cl("等待服务器响应超时", 0)
    return
  end
  
  file_size_fd = format('%.4f', file_size / 1048576.0)
  Log.cl ("准备上传文件: #{name} ，大小: #{file_size} bytes (#{file_size_fd} mbits)")
  data = "#{name},#{file_size.to_s},#{File.extname(file_path)},test"
  socket.puts(data)

  sha256 = Digest::SHA256.new
  File.open(file_path, 'rb') do |file|
    start_time = Time.now.to_i
    read_count = 0
    total_count = 0
    while chunk = file.read(1024)
      socket.write(chunk)
      sha256.update(chunk)
      read_count+=1
      total_count+=1
      if Time.now.to_i >= start_time + 1
        uploaded_size = total_count * 1024 
        update_uspeed(name, read_count * 1024, file_size.to_i - uploaded_size)
        read_count=0
        start_time = Time.now.to_i
      end
    end
  end

  sha256 = sha256.hexdigest
  # puts "#{sha256}"
  socket.puts "#{sha256}"
  msg = socket.gets
  msg.nil? ? msg : msg = msg.chomp
  if msg == "_VF_"
    Log.cl("文件校验失败，请重试", 1)
    sleep 5
    return
  end
  begin  
    if msg == "_VS_"
      Log.cl("文件上传成功")
    end
    msg = socket.gets
    msg.nil? ? msg : msg = msg.chomp
    if msg == "_SEF_"
      Log.cl("开始解压缩...")
    end
    msg = socket.gets
    msg.nil? ? msg : msg = msg.chomp
    if msg == "_SWI_"
      Log.cl("写入信息...")
    end
    msg = socket.gets
    msg.nil? ? msg : msg = msg.chomp
    if msg == "_SUS_"
      Log.cl("成功...")
    end
  rescue => e
    Log.cl("#{e.class}|#{e.message}", 0)
  end
  sleep 3
  socket.close
  return msg
end

def update_uspeed(name, speed, not_uploaded_size)
  mbits = format('%.4f', speed / 1048576.0)
  Log.cl("[#{name}]  #{mbits} mbits/s (#{not_uploaded_size})  #{(not_uploaded_size / speed).round(0).to_i} 秒")
end

def main
  loop do
    CLI::UI::Prompt.ask('要进行哪些操作？') do |handler|
      handler.option('上传地图') do
        Archive.Upload
      end
      handler.option('其他命令') do
        Control.cli_ui
      end
      handler.option('退出') do
        exit
      end
    end
  end
end

module Control
  @config = "key.conf"
  File.open(@config, "w") unless File.exist?(@config)
  @key = File.new(@config, "r").readline(@config).chomp
  def self.cli_ui
    CLI::UI::StdoutRouter.enable
    flag = []
    onext, obreak = false
    loop do
      puts "--".colorize(:red)
      CLI::UI::Prompt.ask('选择一项操作类型:') do |handler|
        handler.option('连接至服务器控制台') do
          puts "尝试r1 ~ r14 作为服务器序号"
          puts "exit: 返回"
          puts "_r13: 连接至#13服务器"
          tag = nil
          print "<#{tag}>"
          loop do
            input = gets.chomp
            break if input.downcase == 'exit' 
            if input[0] == '_'
              tag = input[1,3]
              next
            end
            Control.connect(["_R_", "#{tag} #{input}"])
          end
        end
        handler.option('获取服务器已安装的vpk文件列表') do
          @flag = ["_S_", "list_file"]
        end
        handler.option('创建vpk文件软链接') do
          @flag = ["_S_", "move"]
        end
        handler.option('数据-附件 文件同步') do
          puts "等待服务器处理完成信息.."
          @flag = ["_S_", "sync_data"]
        end
        handler.option('下载附件的数据文件压缩包') do
          @flag = ["_S_", "download_data"]
        end
        handler.option('删除指定附件(目前仅查看)') do
          @flag = ["_S_", "delete_data"]
          msg = Control.connect(@flag, false)
          #puts "#{msg[-6..-1]}"
          next if msg.nil?
          if msg[-1] == "_END_\n"
            CLI::UI::Prompt.ask('选择要删除的文件：') do |handler|
              msg[2..-2].each do |opt|
                handler.option(opt.chomp) do
                  #puts "暂时不支持删除...".colorize(:yellow)
                  sleep 6
                  # 这里需要考虑文件名称与分隔符号
                  #data_name = opt.chomp.split(']')  
                  #Control.connect("_S_", "delete_data ")
                end
              end
            end
          end
          onext = true
        end
        handler.option('返回') do
          obreak = true
        end
      end
      break if obreak == true
      next if onext == true
      puts " 等待服务器处理信息...".colorize(:yellow)
      Control.connect(@flag)
    end
  end

  def self.connect(args, output = true)
    socket = TCPSocket.new("tx.sayuri.city", 27244)
    if @key.nil?
      socket.puts "x"
    else socket.puts "#{@key}"
    end

    if socket.gets != "_READY_\n"
      Log.cl("等待服务器响应超时", 0)
      Log.cl("", 0)
      return
    end

    data = "#{args[0]}|#{args[1]}"
    socket.puts(data)
    lines = []
    while (line = socket.gets)
      lines << line
    end
    lines = lines.join if output
    Log.cl("#{lines}") if output
    socket.close
    return lines
  end
end

module Archive
  class << self
    def os
      type = "windows"
      type = "linux" if RUBY_PLATFORM == "x86_64-linux"
      return type
    end
    def windows?
      Archive.os == "windows"
    end
    def linux?
      Archive.os == "linux"
    end
    def path
      if Archive.linux?
        return ["prepare","complete", "data"]
      end
      if Archive.windows?
        path = ENV['OCRAN_EXECUTABLE'] || "Unknow Dir"
        path = File.dirname(path)
        return [File.join(path, "\\prepare"), File.join(path, "\\complete"), File.join(path, "\\data")]
      end
    end
    def Upload
      path = Archive.path
      Dir.mkdir(path[0]) unless Dir.exist?(path[0])
      Dir.mkdir(path[1]) unless Dir.exist?(path[1])

      path[0] = File.join(path[0])
      path[1] = File.join(path[1])
      Dir.chdir(path[0])
      list = Dir.glob(["*.vpk", "*.7z", "*.rar", "*.zip"])
      puts list
      list.each do |file|
        msg = upload(file)
        if msg == "_SWI_" || msg == "_SUS_"
          FileUtils.mv(file, "../#{path[1]}")
          next
        else
          Log.cl("文件 #{file} 上传失败，稍后需要重新上传", 0)
        end
      end
      Dir.chdir("../")
      Log.cl("prepare文件夹中的文件已全部检查，移动至complete文件夹", 1)
    end
  end
end

begin
main
rescue Interrupt
  puts "退出"
end

