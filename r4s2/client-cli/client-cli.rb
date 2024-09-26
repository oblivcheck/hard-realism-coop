require "socket"
require 'digest/sha2'
require 'colorize'
require 'fileutils'

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
  if ARGV.size < 2
#    puts "缺少参数:"
#    puts "命令 [R/S/U] \"参数1 参数2 ...\""
#    puts "[R] 参数1 = 服务器标识， 参数2 =  要执行的rcon命令"
#    puts "[S] 参数1 = 操作类型， 参数2 =  操作要求的参数"
#    abort
      Archive.Upload
      sleep 3
      abort
  end

  socket = TCPSocket.new("tx.sayuri.city", 27244)
  socket.puts "::sctest_greenflu/"

  if socket.gets != "_READY_\n"
    Log.cl("等待服务器响应超时", 0)
    return
  end
  
  type = "R"
  if ARGV[0] == "S"
    type = "S"
  elsif ARGV[0] == "U"
    type = "U"
    upload(ARGV[1])
  end
  args = ARGV[1]
  data = "_#{type}_|#{args}"
  socket.puts(data)
  lines = []
  while (line = socket.gets)
    lines << line
  end
  lines = lines.join
  Log.cl("#{lines}")
  socket.close
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
        return ["prepare","complete"]
      end
      if Archive.windows?
        path = ENV['OCRAN_EXECUTABLE'] || "Unknow Dir"
        path = File.dirname(path)
        puts "?# #{File.join(path)}"
        return [File.join(path, "\\prepare"), File.join(path, "\\complete")]
      end
    end
    def Upload
      path = Archive.path
      Dir.mkdir(path[0]) unless Dir.exist?(path[0])
      Dir.mkdir(path[1]) unless Dir.exist?(path[1])
      path[0] = File.join(path[0])
      path[1] = File.join(path[1])
      list = Dir.glob("#{path[0]}/*.vpk")
      if Archive.windows?
        Dir.chdir(path[0])
        list = Dir.glob(["*.vpk", "*.7z", "*.rar", "*.zip"])
      end
      list.each do |file|
        msg = upload(file)
        if msg == "_SWI_" || msg == "_SUS_"
          Archive.linux? ? FileUtils.mv(file, "#{path[1]}") : FileUtils.mv(file, "#{path[1]}")
          next
        else
          Log.cl("文件 #{file} 上传失败，稍后需要重新上传", 0)
        end
      end
      Log.cl("prepare文件夹中的文件已全部检查，移动至complete文件夹", 1)
    end
  end
end

main
