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
  def self.listen
    @thread = Thread.new do
      @s_address = Config.r_server_address
      @s_port = Config.r_server_port
      @server = TCPServer.new("#{@s_address}", @s_port)
      @maxnum = Config.r_server_thread_maxnum
      @key = Config.server_verify_key
      @num = 0
      @timeout = Config.r_server_thread_timeout
      loop do
        # Note: 还没有必要使用线程池
        if @num > @maxnum
          Log.sv("服务器线程数量已达限制", 1)
          Verify::Alive.thread_limit(@server, "_TNM_")
        end
        Thread.start(@server.accept) do |client|
          begin
            @num = @num+1
            address = client.peeraddr(:numeric).to_s
            Log.sv("接受连接(#{address})")

            if ! IO.select([client], nil, nil, @timeout)
              Log.sv("等待数据超时(#{address})", 1)
              next
            end
            
            data = client.gets.chomp
            if data != @key
              Log.sv("未通过验证(#{address})", 1)
              client.close
              next
            end
            # Note: 在此处超时？
            data = client.gets.chomp
            data = data.split(",")
            c_fname = data[0]
            c_fsize = data[1].to_i
            # c_sha256 = data[2]
            save_path = "#{Config.server_save_path}/#{c_fname}"
            Log.sv("准备接收 #{c_fname}( #{c_fsize / 1048576.0} MB|#{c_fsize} bytes)")
            sha256 = Digest::SHA256.new 
            revd_data = 0
            File.open("#{save_path}", 'wb') do |file|
              while revd_data < c_fsize
                chunk = client.read([1024, c_fsize - revd_data].min)
                if chunk.nil?
                  Log.sv("传输中断 #{c_fname}(#{address})")
                  File.delete(save_path)
                  client.close
                end
                file.write(chunk)
                revd_data += chunk.length
                sha256.update(chunk)
              end
            end
            sha256 = sha256.hexdigest 
            if ! IO.select([client], nil, nil, @timeout)
              Log.sv("等待哈希超时(#{address})", 1)
              client.close
              next
            end
            c_sha256 = client.gets.chomp
            verify = true
            unless sha256 == c_sha256
              Log.sv("校验失败([S]#{sha256} != [C]#{c_sha256})", 1)
              verify = false
            end
            unless revd_data == c_fsize
              Log.sv("接收的文件大小不一致", 1)
              verify = false
            end
            if verify
              Log.sv("接收完成(#{c_fname}) : #{save_path}")
              client.close
            else
              File.delete(save_path)
              client.puts "_VF_"
              client.close
              next
            end
          rescue => e
            Log.sv("处理(#{address})时出现异常: #{e.class}|#{e.message}", 0)
          ensure
            @num = @num -1
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

module Control
  def self.rcon(client, data)
    data = data.split(' ', 2)
    msg = `./shell/rcon/rcon -c shell/rcon/rcon.yaml -e #{data[0]} #{data[1]}`
    msg += "==注意剩余可用空间=="
    msg += `du -h .` 
  end
  def self.shell(client, data)
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
          Log.sv("服务器线程数量已达限制", 1)
          Verify::Alive.thread_limit(@server, "_TNM_")
        end
        Thread.start(@server.accept) do |client|
          begin
            @num = @num+1
            address = client.peeraddr(:numeric).to_s
            Log.sv("接受连接(#{address})")

            if ! IO.select([client], nil, nil, @timeout)
              Log.sv("等待数据超时(#{address})", 1)
              next
            end
            
            data = client.gets.chomp
            if data != @key
              Log.sv("未通过验证(#{address})", 1)
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
            Log.sv("处理(#{address})时出现异常: #{e.class}|#{e.message}", 0)
          ensure
            @num = @num -1
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
