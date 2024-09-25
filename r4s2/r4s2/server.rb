require 'ffi-libarchive'

module Verify 
  module Alive
    def self.thread_limit(server, msg)
      client = server.accept
      client.puts msg
      client.close
    end 
  end
  
  #def self.key
  #end
end

module Receive
  @s_address = Config.r_server_address
  @s_port = Config.r_server_port
  @server = TCPServer.new("#{@s_address}", @s_port)
  @maxnum = Config.r_server_thread_maxnum
  @key = Config.server_verify_key
  @num = 0
  @timeout = Config.r_server_thread_timeout

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
    @data_path = "#{Config.server_data_path}/addons"
    Dir.mkdir(@data_path) unless Dir.exist?(@data_path)

    def self.unzip(file, path, e_path = nil)
      flags = ::Archive::EXTRACT_PERM
      reader = ::Archive::Reader.open_filename(path)
      # entry 看上去是压缩包内的实例
      hash = file.include
      reader.each_entry do |entry|
        reader.extract(entry, flags.to_i,  destination: e_path)
        name = entry.pathname
        if hash.nil?
          hash = [::File.basename(name) => name]
          file.include = hash if entry.size == 1
        else
          hash << {::File.basename(name) => name}
          file.include = hash
        end
      end
      reader.close
      return e_path.nil? ? ::File.basename(path) : e_path
    end
    def self.write(file)
      name = file.name
      type = file.type
      if Receive.valid_formats?(type) 
        # 创建一个以压缩包名为名称的目录（没有后缀）
        path = "#{@data_path}/#{::File.basename(name, type)}"
        Dir.mkdir(path) unless Dir.exist?(path)
        ::File.open("#{path}/_#{file.name}.json", "w") do |json|
          json.write(JSON.pretty_generate(file.hash))
        end
        hash = file.include
        hash.each do |vpk|
          vpk.each do |vpk_name, vpk_path|
            next unless ::File.extname(vpk_name) == ".vpk"
            ::File.open("#{path}/#{vpk_name}.json", "w") do |json|
              file.include = [:from => file.name.to_s]
              file.name = vpk_name
              file.type = ".vpk"
              file.size = ::File.size(vpk_path)
              file.sha256 = "Unknow"
              json.write(JSON.pretty_generate(file.hash))
            end
          end
        end
      elsif Receive.is_vpk?(type)
        ::File.open("#{@data_path}/#{file.name}.json", "w") do |json|
          json.write(JSON.pretty_generate(file.hash))
        end
      else
        msg_print("不支持的文件格式: #{file.type}", :red)
      end
    end
  end
  def self.listen
    @thread = Thread.new do
      sockets = [@server]
      clients =[]
      loop do
      # Note: 还没有必要使用线程池
      if @num > @maxnum
          Log.sv("[R/main]", "服务器线程数量已达限制", 1)
        Verify::Alive.thread_limit(@server, "_TNM_")
      end
      #readable, writable, error = IO.select(sockets, sockets, sockets)
      sockets.reject!(&:closed?)
      begin
      readable = IO.select(sockets)
      rescue => e
          Log.sv("[R/main]", "#{e.class}|#{e.message}", 0)
      end
      next if readable.nil?
        readable.flatten.each do |socket|
        #puts "#### #{readable}"
        if socket == @server
          client = @server.accept
          sockets << client
          clients << client
        elsif clients.include?(socket)
          clients.delete(socket)
          Thread.new do
            @num+=1
            client = socket
            address = client.peeraddr(:numeric)
            address = [address[2], address[1]].to_s
            prefix = "[R/#{@num}]"
            if ! IO.select([client], nil, nil, @timeout)
              Log.sv("#{prefix}", "#{address} 等待验证超时...", 0)
              break
            end
            if client.gets.chomp != @key
              Log.sv("#{prefix}", "#{address} 密钥验证失败...", 0)
              client.close
              sockets.delete(client)
              break
            end
            client.puts "_READY_"
            # 接收文件信息
            data = client.gets
            if data.nil?
              Log.sv("#{prefix}", "#{address} 文件信息为空...", 1)
              break
            end
            data = data.chomp.split(",")
            # 接收文件
            name = data[0]
            size = data[1]
            size = size.to_i
            type = data[2]
            uploader = data[3]
            file = Receive::File.new({name: name, size: size, type: type, uploader: uploader})
            path = "#{Config.server_save_path}/#{file.name}"
            Log.sv("#{prefix}", "#{address} 接收开始 #{name} (#{size / 1048576.0} Mbit) | #{size} byte")
            sha256 = Digest::SHA256.new
            revd_data = 0
            faild = false
            ::File.open(path, 'wb') do |obj|
              while revd_data < size
                chunk = client.read([1024, size - revd_data].min)
                if chunk.nil?
                  faild = true
                  Log.sv("#{prefix}", "#{address} 文件 #{name} 传输中断", 1)
                  ::File.delete(path)
                  client.close unless client.closed?
                  sockets.delete(client)
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
            next if (revd_data == -1)
            sha256 = sha256.hexdigest
            file.sha256 = sha256
            # Todo: 下一次重新验证而不是直接删除
            if ! IO.select([client], nil, nil, @timeout)
              Log.sv("#{prefix}", "#{address} 等待客户端sha256信息超时...", 0)
              verify = false
              client.close
              sockets.delete(client)
              break
            end
            # 读取发送的Hash
              c_sha256 = client.gets.chomp
            if c_sha256.nil?
              Log.sv("#{prefix}", "#{address} 客户端sha256信息nil...", 1)
              verify = false
              client.close
              sockets.delete(client)
              break
            end
            if sha256 != c_sha256
              Log.sv("#{prefix}", "#{address} 文件 #{name} 校验失败", 1)
              verify = false
              client.puts("_VF_")
              client.close
              sockets.delete(client)
              next
            end

            Log.sv("#{prefix}", "#{address} 文件 #{name} 接收完成")
            file.time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
            client.puts "_VS_"
            if Receive.valid_formats?(file.type)
              Log.sv("#{prefix}", "#{address} 文件 #{name} 开始解压...")
              client.puts "_SEF_"
              Receive::Archive.unzip(file, path, Config.server_save_path)
            else
              client.puts "_NONE_"
            end
            Log.sv("#{prefix}", "#{address} 文件 #{name} 写入信息...")
            client.puts "_SWI_"
            Receive::Archive.write(file)
            client.puts "_SUS_"
            Log.sv("#{prefix}", "#{address} 文件 #{name} 上传完成！")
            client.close
            sockets.delete(client)
            rescue => e
            Log.sv("#{prefix}", "#{address} 出现异常: #{e.class}|#{e.message}", 0)
            ensure
              @num = @num -1
              if ! client.closed?
                client.close
                sockets.delete(client) unless sockets.include?(client)
                msg_print("#{prefix} #{address} 强制断开连接", :red)
              end
            end
          end
        end
      end
    end
  end
end

module Control
  def self.rcon(client, data)
    Log.sv("R #{data.to_s}")
    data = data.split(' ', 2)
    msg = `./shell/rcon/rcon -c shell/rcon/rcon.yaml -e #{data[0]} "#{data[1]}"`
    msg += "==注意剩余可用空间==\n"
    msg += `df -h .` 
  end
  def self.shell(client, data)
    Log.sv("S #{data.to_s}")
    data = data.split(' ', 2)
    case data[0]
    when "list"
      `ls -lah #{Config.server_save_path}`
    when "move"
      `bash shell/linkvpk.sh`
   # Todo: 维护一份列表以供删除而不是直接使用命令
    #when "delete"
    #  system(`rm `)
    end
  end
  def self.listen
    @thread = Thread.new do
      @s_address = Config.c_server_address
      @s_port = Config.c_server_port
      @server = TCPServer.new("#{@s_address}", @s_port)
      @maxnum = Config.c_server_thread_maxnum
      @key = Config.server_verify_key
      @num = 0
      @timeout = Config.c_server_thread_timeout
      loop do
        if @num > @maxnum
          Log.sv("[C/TNM]", "服务器线程数量已达限制", 1)
          Verify::Alive.thread_limit(@server, "_TNM_")
        end
        Thread.start(@server.accept) do |client|
          begin
            @num = @num+1
            address = client.peeraddr(:numeric).to_s
            Log.sv("[C/#{@num}]", "接受连接(#{address})")

            if ! IO.select([client], nil, nil, @timeout)
              Log.sv("[C/#{@num}]", "等待数据超时(#{address})", 1)
              next
            end
            
            data = client.gets.chomp
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
          ensure
            @num = @num -1
            if ! client.closed?
              client.close
              # msg_print("强制断开连接(#{address})", :light_red)
            end
          end
        end
      end
    end 
  end
end
