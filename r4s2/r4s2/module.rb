require 'pathname'

# Note: 需要重新构造数据
# Todo: 重新更改结构或是使r4s2作为WS服务器
def http_post(api, data)
  filter_nested_json(data, [:action, :params])
  system("curl -X POST #{Config.onebot_address}:#{Config.onebot_port}/#{api} 
    -H \"Content-Type: application/json\" -d \"#{data}\"")
end

module Msg2qq
  PATH = Config.config_get("path", "msg2qq")
  if !Dir.exist?(PATH)
   Dir.mkdir(PATH)
  end
  class << self
    def clean(file)
      File.open("#{PATH}/#{file}", "w") 
    end
    def reflush
      self.clean("group")
      self.clean("target")
      self.clean("string")
      self.clean("target")
      self.clean("image")
      self.clean("file")
      self.clean("name")
      if File.exist?("#{PATH}/msg2qq.lock")
        self.delete("#{PATH}/msg2qq.lock")
      end
    end
    def lock?
       File.exist?("#{PATH}/msg2qq.lock")
    end
    def read
      @group = File.read("#{PATH}/group")
      @target = File.read("#{PATH}/target")
      @string = File.read("#{PATH}/string")
      @target = File.read("#{PATH}/target")
      @image = File.read("#{PATH}/image")
      @file = File.read("#{PATH}/file")
      @name = File.read("#{PATH}/name")
      File.delete("#{PATH}/msg2qq.lock")
      @rename = !File.empty?(@name)
    end
    def image?
      File.empty?(@image)
    end
    def file?
      File.empty?(@file)
    end
    def group?
      File.empty?(@group)
    end
    # Note: 特定方法没有群组或私聊的区别
    def send
      if self.group?
        if self.image?
          Onebot::Ws::Group.image(@group, @string)
          msg_print("IMAGE", :red)
        elsif self.file?
          Onebot::Ws::Group.file(@group, @rename ? @name : @string)
          msg_print("FILE", :red)
       else
          Onebot::Ws::Group.text(@group, @string)
          msg_print("TEXT", :red)
      end
      else
          msg_print("私人的", :red)
        if self.image?
          Onebot::Ws::Private.image(@target, @string)
          msg_print("IMAGE", :red)
       elsif self.file?
          Onebot::Ws::Private.file(@target, @rename ? @name : @string)
          msg_print("FILE", :red)
      else
          Onebot::Ws::Private.text(@target, @string)
          # msg_print("TEXT", :red)
     end
      end
    end
  end
  if Dir.empty?(PATH) 
    Msg2qq.reflush
  end
  module Acceptinput
    puts "ACC"
    @thread = Thread.new do
      loop do
        puts "ACC-T"
        if Msg2qq.lock?
          puts "lock!"
          Msg2qq.read
          json = Msg2qq.send
          puts "! #{json}"
          Msg2qq.reflush
        end
        sleep 0.5
      end
    end
  end 
end
# Todo: 处理事件上报
module Onebot
  module Ws
    @url = "ws://#{Config.onebot_address}/#{Config.onebot_port("wsv")}/api/"
    class << self
      def format
        @msg ||= { action: nil, params: nil } 
      end
      def path_valid?(path)
        if ( File.exist?(path) )
            puts "#{path}"          
            return true
        end
        msg_print("路径指向的目标无效: #{path} ", :red);
        return false
      end
      # 如果没有自定义名称就使用文件的名称
      def use_def_name(name, path)
        if name.nil?
          # Note: Ruby的这种方法很符合直觉:)
          name = "#{Pathname.new(path).basename.to_s}"
          puts "#{name}"
        end  
      end
    end
    # Note: 路径与文件名，都是相对于服务器来描述
    module Group
      class << self
        def text(group_id, text)
          msg = OneBot::Ws.format
          msg[:action] = "send_group_msg"
          msg[:params] = { group_id: group_id, message: { type: "text", data: { text: text } } }
          msg = JSON.pretty_generate(msg)
        end

        def image(group_id, path)
          return nil unless Onebot::Ws.path_valid?(path)
          msg = Onebot::Ws.format
          msg[:action] = "send_group_msg"
          msg[:params] = { group_id: group_id, message: { type: "image", data: { file: path } } }
          msg = JSON.pretty_generate(msg)
        end
      end
    end
    module Private
      class << self
        def text(target, text)
          msg = Onebot::Ws.format
            msg[:action] = "send_private_msg"
            msg[:params] = { group_id: target, message: { type: "text", data: { text: text } } }
            msg = JSON.pretty_generate(msg)
            # http_post("send_private_msg", msg)
        end
        def image(target, path)
          return nil unless Onebot::Ws.path_valid?(path)
          msg = Onebot::Ws.format
            msg[:action] = "send_private_msg"
            msg[:params] = { group_id: target, message: { type: "image", data: { file: path } } }
            msg = JSON.pretty_generate(msg)
        end
      end
    end
  end
end

module CQHTTP
  module Ws
    @url = "ws://#{Config.onebot_address}/#{Config.onebot_port("wsv")}/"
    class << self
      def format
        @msg ||= { action: nil, params: nil } 
      end
      def path_valid?(path)
        if ( File.exist?(path) )
            puts "#{path}"          
            return true
        end
        msg_print("路径指向的目标无效: #{path} ", :red);
        return false
      end
      def use_def_name(name, path)
        if name.nil?
          name = "#{Pathname.new(path).basename.to_s}"
          puts "#{name}"
        end  
      end
    end
    
    class << self
      def upload_group_file(group_id, path, name = nil, folder_id = nil)
        return nil unless path_valid?(path)      
        use_def_name(name, path)        
        msg = CQHTTP::Ws.format
        msg[:action] = "upload_group_file"
        msg[:params] = { group_id: group_id, file: path, name: name }
        msg = JSON.pretty_generate(msg)            
      end
      def create_group_file_folder(group_id, name)
        msg = CQHTTP::Ws.format
        msg[:action] = "create_group_file_folder"
        msg[:params] = { group_id: group_id, name: name, parent_id: "/" }
        msg = JSON.pretty_generate(msg)
      end
      def delete_group_folde(group_id, folder_id)
        msg = CQHTTP::Ws.format
        msg[:action] = "delete_group_folder"
        msg[:params] = { group_id: group_id, folder_id: folder_id }
        msg = JSON.pretty_generate(msg)
      end
      def get_group_root_files(group_id)
        msg = CQHTTP::Ws.format
        msg[:action] = "get_group_root_files"
        msg[:params] = { group_id: group_id }
        msg = JSON.pretty_generate(msg)
      end
      def get_group_files_by_folder(group_id, folder_id)
        msg = CQHTTP::Ws.format
        msg[:action] = "get_group_files_by_folder"
        msg[:params] = { group_id: group_id, folder_id: folder_id }
        msg = JSON.pretty_generate(msg)
      end
      def get_group_file_system_info(group_id)
        msg = CQHTTP::Ws.format
        msg[:action] = "get_group_file_system_info"
        msg[:params] = { group_id: group_id }
        msg = JSON.pretty_generate(msg)
      end
      def get_group_file_url(group_id, file_id, busid)
        msg = CQHTTP::Ws.format
        msg[:action] = "get_group_file_url"
        msg[:params] = { group_id: group_id, file_id: file_id, busid: busid }
        msg = JSON.pretty_generate(msg)
      end  
    end
  end
end
