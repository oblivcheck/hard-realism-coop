require 'ffi-libarchive'
require 'digest'
require './r4s2/cli.rb'

module Verify
  @key = Config.server_verify_key 
  module Alive
    def self.thread_limit(server, msg)
      client = server.accept
      client.puts msg
      client.close
    end 
  end
  
  def self.wait(socket)
    return IO.select([socket], nil, nil, @timeout)
  end

  def self.key(socket)
    return -1 unless Verify.wait(socket)
    return socket.gets.chomp == @key ? 1 : 0
  end
end

module Receive
  @s_address = Config.r_server_address
  @s_port = Config.r_server_port
  @server = TCPServer.new("#{@s_address}", @s_port)
  @data_path = Config.server_data_path
  @save_path = Config.server_save_path
  @maxnum = Config.r_server_thread_maxnum
  @key = Config.server_verify_key
  @num = 0
  @timeout = Config.r_server_thread_timeout
  @thread = nil


  def self.maxnum
    @maxnum
  end
  class File
    attr_accessor :name, :size, :type, :uploader, :sha256, :time, :include
    def initialize(file)
      @file = file
      self.name = file[:name]
      self.size = file[:size]
      self.type = file[:type]
      self.uploader = file[:uploader]

      self.sha256 = file[:sha256]
      self.time = file[:time]
      self.include = file[:include]
    end
    def hash
      {
        name: self.name,
        size: self.size,
        type: self.type,
        uploader: self.uploader,
        sha256: self.sha256,
        time: self.time,
        include: self.include
      }
    end
  end
  def self.valid_formats?(extname)
    valid = [".7z", ".zip", ".rar"]
    is_valid = false
    valid.each do |format|
      if format == extname
        is_valid = true
        break
      end
    end
    return is_valid
  end
  
  def self.is_vpk?(extname)
    return (extname == ".vpk")
  end
  module Archive
    @data_path = Config.server_data_path
    @save_path = Config.server_save_path
    def self.scan_data
      paths = []
      Dir.new(@data_path).each_child do |obj|
        obj = "#{@data_path}/#{obj}"
        # 现在只会处理一层嵌套
        if ::File.directory?(obj)
          Dir.new(obj).each_child do |sub|
            paths << "#{obj}/#{sub}"
          end
          next
        else paths << obj
        end
      end
      return paths
    end

    def self.scan_vpk(all = nil)
      paths = []
      Dir.new(@save_path).each_child do |obj|
        if ! obj.nil?
          paths << obj
        elsif ! ::File.directory?(obj)
          if obj.extname == ".vpk"
            paths << obj
          end
        end
      end
      return paths
    end
    # Note: 更应该叫删除
    def self.sync
      data_paths = Receive::Archive.scan_data
      # 寻找文件存放目录下的所有文件
      file_paths = Receive::Archive.scan_vpk(true)
      copy = [data_paths.clone, file_paths.clone]
      # 默认文件存放目录不存在嵌套
      data_paths.each do |path|
        extname = ::File.extname(path)
        name = ::File.basename(path, extname)
        file = Receive::Archive.read(path)
        if file.type != ".vpk"
          name = name[1..-1]
        end 
        sha256 = file.sha256
        f_sha256 = nil
        # 如果压缩包被匹配，需要调整#{name}
        if sha256.nil? || sha256 == "Unknow"
          sha256 = Digest::SHA256.file("#{@save_path}/#{name}").hexdigest
          file.sha256 = sha256
          Receive::Archive.write(file, true)
          Log.sv("[R/SYNC]", "#{path} 的数据文件中sha256值已被更新...")
        end
        if ::File.exist?("#{@save_path}/#{name}")
          Log.sv("[R/SYNC]", "开始计算 #{@save_path}/#{name} sha256")
          f_sha256 = Receive::Archive.sha256_of_file("#{@save_path}/#{name}")
          Log.sv("[R/SYNC]", "完成计算 #{@save_path}/#{name} sha256")
        else
          Log.sv("[R/SYNC]", "#{@save_path}/#{name} 文件不存在...")
        end 
        if sha256 == f_sha256
          # 所以..这不是路径
          copy[0].delete(path)
          copy[1].delete(name)
        end
      end
      file_paths.each do |path|
        `rm "#{@save_path}/#{path}"`
      end
      return copy
    end

    def self.sha256_of_file(path, size = 1024)
      sha256 = Digest::SHA256.new
      ::File.open(path, 'rb') do |file|
        buffer = ""
        while file.read(size, buffer)
          sha256.update(buffer)
        end
      end
      sha256.hexdigest
    end

    def self.unzip(file, path, e_path = nil)
      flags = ::Archive::EXTRACT_PERM
      reader = ::Archive::Reader.open_filename(path)
      # entry 看上去是压缩包内的实例
      hash = file.include
      reader.each_entry do |entry|
        reader.extract(entry, flags.to_i,  destination: e_path)
        name = entry.pathname
        # 下面是在创建文件描述中的include部分
        if hash.nil?
          hash = [::File.basename(name) => name]
          file.include = hash
        else
          # 单个文件被压缩通常不会创建同名文件夹
          hash << {::File.basename(name) => name}
          file.include = hash
        end
      end
      #puts "## #{hash}"
      #puts "## #{file.include}"
      reader.close
      return e_path.nil? ? ::File.basename(path) : e_path
    end

    def self.read(path)
      hash = JSON.load_file(path)
      hash.transform_keys!(&:to_sym)  
      file = Receive::File.new(name: hash[:name], 
        size: hash[:sie], type: hash[:type], 
        uploader: hash[:uploader],sha256: hash[:sha256], 
        time: hash[:time], include: hash[:include])
      return file
    end

    def self.write(file, sync = false)
      name = file.name
      type = file.type
      if Receive.valid_formats?(type)
        # 创建一个以压缩包名为名称的目录（没有后缀）
        path = "#{@data_path}/#{::File.basename(name, type)}"
        Dir.mkdir(path) unless Dir.exist?(path)
        ::File.open("#{path}/_#{file.name}.json", "w") do |json|
          json.write(JSON.pretty_generate(file.hash))
        end
        return if sync 
        archive_name = file.name
        hash = file.include
        #puts hash
        hash.each do |vpk|
          #puts vpk
          vpk.each do |vpk_name, vpk_path|
            next unless ::File.extname(vpk_name) == ".vpk"
            ::File.open("#{path}/#{vpk_name}.json", "w") do |json|
              # puts "# #{vpk_name}"
              file.name = vpk_name
              file.type = ".vpk"
              file.size = ::File.size(vpk_path)
              file.sha256 = "Unknow"
              file.include = [:from => archive_name.to_s] 
              json.write(JSON.pretty_generate(file.hash))
            end
          end
        end
      elsif Receive.is_vpk?(type)
        if sync
          from = file.include.flatten[0].values[0]
          ::File.open("#{@data_path}/#{::File.basename(from, '.7z')}/#{file.name}.json", "w") do |json|
            json.write(JSON.pretty_generate(file.hash))
          end
        else
          ::File.open("#{@data_path}/#{file.name}.json", "w") do |json|
            json.write(JSON.pretty_generate(file.hash))
          end
        end
      else
        msg_print("不支持的文件格式: #{file.type}", :red)
      end
    end

    def self.delete(data_name)
      root =  Dir.pwd
      dir = Dir.new(@data_path)
      Dir.chdir(dir)
      path = Dir.glob(["#{data_name}.json"])
      if path.size == 0
        dir.each_child do |sub|
          # puts "#{sub}/#{data_name}.json"
          next unless ::File.directory?(sub)
          Dir.chdir(sub)
          path = Dir.glob("#{data_name}.json")
          path = Dir.glob("_#{data_name}.json")
          Dir.chdir("../")
          break unless path.size == 0
        end
      end
      Dir.chdir(root)
      if path.size == 0
        return "删除 #{data_name} 失败"
      end

      hash = JSON.load_file(path)
      if hash[:type] == ".vpk" 
        `rm "#{@data_path}/#{path}"`
        `rm "#{@save_path}/#{File.basename(path)}"`
      else
        `rm -r "#{@data_path}/#{File.basename(path)}"`
        `rm "#{@save_path}/#{File.basename(path)}"`
        hash[:include].each do |file|
          `rm "#{file}"`
        end
      end
      return "删除 #{data_name} 成功"
    end
  end

  def self.thread
    @thread
  end

  module Worker
    @threads = []
    @maxnum = Receive.maxnum
    @mutex = Thread::Mutex.new
    @save_path = Config.server_save_path
    @data_path = Config.server_data_path
    @clients = []
    
    def self.get_num
      counter = 0
      @threads.each do |thread|
        if thread == nil
          next
        end

        if thread.status != nil
          counter += 1
          next
        end
      end
      return counter
    end

    def self.update_clients(socket)
      @clients << socket
    end

    def self.get_client
      return nil if @clients.size == 0
      @clients.flatten.each do |client|
        if client.closed?
          @clients.delete(client)
          next
        end
        return client
      end
      return nil
    end

    def self.create
      return nil unless @threads.size < @maxnum
      thread = Thread.new do
        num = @threads.index(thread)
        loop do
          sleep 0.1
          client = nil
          @mutex.synchronize do
            client = Receive::Worker.get_client
            @clients.delete(client)
          end
          Receive::Worker.handle(client, num) unless client.nil?
        end
      end
      @threads << thread
      return thread
    end

    # def self.delete()
    def self.handle(socket, num)
begin
      address = socket.peeraddr(:numeric)
      address = [address[2], address[1]].to_s
      prefix = "[R/#{num}]"
      case Verify.key(socket)
      when -1
        Log.sv(prefix, "#{address} 等待验证信息超时...")
        socket.close
        return
      when 0 
        Log.sv(prefix, "#{address} 密钥验证失败...")
        socket.close
        return
      end

      socket.puts("_READY_")

      info = Receive::Worker.revd_info(socket)
      if info.nil?
        Log.sv(prefix, "#{address} 文件信息为空...")
        socket.close
        return
      end

      file = Receive::Worker.revd_file(socket, info, address, prefix)
      return if file.nil?

      sha256 = file.sha256
      c_sha256 = Receive::Worker.revd_sha2(socket)
      case c_sha256
      when -1
        Log.sv(prefix, "#{address} 等待客户端sha256信息超时...", 0)
        socket.close
        return
      when 0
        Log.sv(prefix, "#{address} 客户端sha256信息为空...", 0) 
        socket.close
        return
      end

      verify = Receive::Worker.verify_file(c_sha256, sha256)
      if ! verify
        Log.sv(prefix, "#{address} 文件 #{info[0]} 校验失败")
        socket.puts("_VF_")
        socket.close
        return
      end

      Log.sv(prefix, "#{address} 文件 #{info[0]} 接收完成")
      file.time = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
      socket.puts "_VS_"

      export_path = "#{@save_path}"
      if Receive.valid_formats?(file.type)
        Log.sv(prefix, "#{address} 文件 #{info[0]} 开始解压...")
        socket.puts "_SEF_"
        extname = ::File.extname(file.name);
        export_path = "#{@save_path}/#{::File.basename(file.name, extname)}"
        `mkdir -p "#{export_path}" `
        Receive::Archive.unzip(file, "#{@save_path}/#{file.name}", export_path)
      else
        socket.puts "_NONE_"
      end
      Log.sv(prefix, "#{address} 文件 #{info[0]} 写入信息...")
      socket.puts "_SWI_"
      Receive::Archive.write(file)
      socket.puts "_SUS_"
      Log.sv(prefix, "#{address} 文件 #{info[0]} 上传完成！")
      # 重命名addons目录下的vpk文件，避免某些文件名不被专用服务器识别
      # 可能需要更改源文件的名称而不是软链接?
      Log.sv(prefix, "#{address} 正在为文件 #{info[0]} 创建符号链接")
      socket.puts "_CSL_"
      if Receive.valid_formats?(file.type)
        Log.sv(prefix, "#{address} 文件 #{info[0]} linkvpk.sh #{export_path} #{info[4]} ")
        `bash shell/linkvpk.sh "#{export_path}" "#{info[4]}" `
      else
        Log.sv(prefix, "#{address} 文件 #{info[0]} |linkvpk.sh|#{export_path}/#{info[0]}|#{info[4]} ")
        `bash shell/linkvpk.sh "#{export_path}/#{info[0]}" "#{info[4]}" `
      end
      Log.sv(prefix, "#{address} 正在通知服务器重新启动...")
      socket.puts "_RESET_"
      msg = `bash shell/restart.sh`
      socket.puts "#{msg}"
    
      socket.close
rescue => e
      Log.sv(prefix, "处理(#{address})时出现异常: #{e.class}|#{e.message}", 0)
      e.backtrace.each do |line|
        puts line
      end 
end
    end

    def self.revd_info(socket)
      data = socket.gets
      return nil if data.nil?
      return data.chomp.split(",")
    end
 
    def self.revd_file(socket, info, address, prefix)
      name, size, type, uploader, target_server = info
      size = size.to_i
      file = Receive::File.new(name: name, size: size, type: type, uploader: uploader)
      path = "#{@save_path}/#{file.name}"
      Log.sv(prefix, "#{address} 开始接收文件 #{name} (#{size / 1048576.0} Mbit) | #{size} byte")
      sha256 = Digest::SHA256.new
      revd_data = 0
      faild = false
      ::File.open(path, 'wb') do |obj|
        while revd_data < size
          chunk = socket.read([1024, size - revd_data].min)
          if chunk.nil?
            faild = true
            Log.sv(prefix, "#{address} 文件 #{name} 传输中断", 1)
            ::File.delete(path) if ::File.exist?(path)
            socket.close unless socket.closed?
            revd_data = -1
            break
          end
          obj.write(chunk)
          revd_data += chunk.length
          sha256.update(chunk)
        end
        if faild
          revd_data = -1
          break
        end
      end
      return nil if (revd_data == -1)
      sha256 = sha256.hexdigest
      file.sha256 = sha256
      return file
    end

    def self.revd_sha2(socket)
      return -1 unless IO.select([socket], nil, nil, @timeout)
      data = socket.gets
      return 0 if data.nil?
      sha256 = data.chomp
      return sha256
    end

    def self.verify_file(c_sha256, sha256)
      return c_sha256 == sha256
    end
  end

  def self.listen
    @thread = Thread.new do
      while Receive::Worker.get_num < @maxnum do
        Receive::Worker.create
        #puts "#{@maxnum} #{Receive::Worker.get_num} "
        #puts "# 一个Worker"
      end
      loop do
        Receive::Worker.update_clients(@server.accept)
      end
    end
  end
end

module Control
  def self.get_file_list
    list = Receive::Archive.scan_data
    is_archive = []
    form_archlive = []
    list.each do |name|
      hash = JSON.load_file("#{name}").transform_keys!(&:to_sym)
      if hash[:type] != ".vpk"
        is_archive << hash[:type]
      else is_archive << nil
      end
      if ! hash[:include].nil? && hash[:type] == ".vpk"
        form_archlive << hash[:include].flatten[0].values.map(&:to_s)
      else
        form_archlive << nil
      end
    end
    return [is_archive, list, form_archlive]
  end

  def self.rcon(client, data)
    Log.sv("[C/Rcon]", "#{data.to_s}")
    data = data.split(' ', 2)
    msg = `./shell/rcon/rcon -c shell/rcon/rcon.yaml -e #{data[0]} "#{data[1]}"`
    space = `df -h . |awk 'NR==2 {print $4}`
    msg += "\n服务器磁盘剩余可用空间: #{space[0..-2].to_int * 1024} Mib(#{space.chomp})\n" 
  end

  def self.shell(client, data, socket=nil)
    Log.sv("[C/S]", "#{data.to_s}")
    data = data.split(' ', 2)
    case data[0]
    when "list_file"
      msg = ''
      path = Config.server_save_path
      dir = Dir.new(path)
      dir.each_child do |obj|
        next if ::File.directory?(obj)
        file = ::File.new("#{path}/#{obj}")
        msg << "#{file.mtime.strftime('%Y-%m-%d %H:%M:%S')}    大小:#{Kernel.format('%.2f', file.size / 1048576.0)} Mib    名称:  #{obj} \n"
      end
      return msg
    when "move"
      `bash shell/linkvpk.sh`
    when "sync_data"
      msg = "下列的数据文件未能找到匹配的实际文件:\n" 
      data = Receive::Archive.sync
      msg += data[0].join("\n")
      Log.sv("[C/S]", "sync_data 执行成功")
      msg += "\n来自压缩包的文件校验码重生成完毕\n没有相关联数据文件的实际文件已删除:\n"
      msg += data[1].join("\n")
    when "download_data"
      msg = "数据压缩包已经更新，请在在浏览器器中访问:\n"
      `tar -czvf data.tar.gz`
      `mv data.tar.gz ~/r4s2/www`
      `rm ~/r4s2/www/*.md`
      `touch ~/r4s2/www/$(date +\"最后更新于(%Y-%m-%d_%H-%M-%S)\")`
      msg += "http://101.34.89.211/r4s2"
    when "delete_data"
      if data[1].empty?
        msg = []
        msg << "(列出的为文件所关联的数据文件，删除压缩包也删除来自它的所有文件)"
        msg << " "
        data = Control.get_file_list
        is_archive = data[0]
        name = data[1]
        form_archlive = data[2]
        counter = 0
        name.each do |file|
          type_nil = is_archive[counter].nil?
          archive = type_nil ? "[.vpk 文件]" : "[#{is_archive[counter]}压缩包]"
          if ! form_archlive[counter].nil? && type_nil
            form = "[来自 #{form_archlive[counter].to_s.delete('[]')}]"
          else
            form = "[单个文件]"
          end
          msg << "#{form} #{archive} #{type_nil ? ::File.basename(file, '.json') : ::File.basename(file, '.json')[1..-1]}"
          counter += 1
        end
        msg[2..-1].sort_by! do |str|
          str.split(']')[0].size
        end
        msg << "_END_"
        return msg.join("\n")
      else
        # 预期一个文件名称，服务器查询名称对应的数据文件
        return Receive::Archive.delete(data[1].chomp)
      end
    end

  end

  def self.listen
    @thread = Thread.new do
      @s_address = Config.c_server_address
      @s_port = Config.c_server_port
      @server = TCPServer.new("#{@s_address}", @s_port)
      @maxnum = Config.c_server_thread_maxnum
      @key = Config.server_verify_ckey
      @num = 0
      @timeout = Config.c_server_thread_timeout
      loop do
        #if @num > @maxnum
        #  Log.sv("[C/TNM]", "服务器线程数量已达限制", 1)
        #  Verify::Alive.thread_limit(@server, "_TNM_")
        #end
        Thread.start(@server.accept) do |client|
          begin
            @num = @num+1
            address = client.peeraddr(:numeric).to_s
            Log.sv("[C/#{@num}]", "接受连接(#{address})")

            if ! IO.select([client], nil, nil, @timeout)
              Log.sv("[C/#{@num}]", "等待数据超时(#{address})", 1)
              next
            end

            client_key = client.gets
            next if client_key.nil?

            data = client_key.chomp
            if data != @key
              Log.sv("[C/#{@num}]", "未通过验证(#{address})", 1)
              client.close
              next
            end
            client.puts "_READY_"
            if ! Config.c_enable
              client.close
              next
            end
            data = client.gets
            data = data.split("|")
            if data[0] == "_R_"
              client.puts "#{Control.rcon(client, data[1])}"
              client.close
            end

            if data[0] == "_S_"
              client.puts "#{Control.shell(client, data[1])}"
              client.close
            end
          rescue => e
            Log.sv("[C/#{@num}]", "处理(#{address})时出现异常: #{e.class}|#{e.message}", 0)
            e.backtrace.each do |line|
              puts line
            end
          ensure
            if ! client.closed?
              client.close
              msg_print("强制断开连接(#{address})", :light_red)
            end
          end
        end
      end
    end 
  end
end
