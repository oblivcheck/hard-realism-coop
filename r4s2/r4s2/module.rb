require 'pathname'

# Todo: 为外部脚本添加一些简单的接口
# /dev/shm/msg2qq ->
#                 group
#                 sting
#                 target
#                 image
#                 file
#                 name
#                 ...
#                 lock

#module Msg2QQ
#
#end

# Note: 改用HTTP更好
#       意料之外的时期，遵循返回nil

# Todo: 处理事件上报

module OneBot
  module WS
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
          msg = OneBot::WS.format
          msg[:action] = "send_group_msg"
          msg[:params] = { group_id: group_id, message: { type: "text", data: { text: text } } }
          msg = JSON.pretty_generate(msg)
        end

        def image(group_id, path)
          return nil unless path_valid?(path)
          msg = OneBot::WS.format
          msg[:action] = "send_group_msg"
          msg[:params] = { group_id: group_id, message: { type: "image", data: { file: path } } }
          msg = JSON.pretty_generate(msg)
        end
      end
    end
    module Private
      class << self
        def text(target, text)
            msg = OneBot::WS.format
            msg[:action] = "send_private_msg"
            msg[:params] = { group_id: group_id, message: { type: "text", data: { text: text } } }
            msg = JSON.pretty_generate(msg)
        end
        def image(target, path)
            return nil unless path_valid?(path)
            msg = OneBot::WS.format
            msg[:action] = "send_private_msg"
            msg[:params] = { group_id: group_id, message: { type: "image", data: { file: path } } }
            msg = JSON.pretty_generate(msg)
        end
      end
    end
  end
end

module CQHTTP
  module WS
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
        msg = CQHTTP::WS.format
        msg[:action] = "upload_group_file"
        msg[:params] = { group_id: group_id, file: path, name: name }
        msg = JSON.pretty_generate(msg)            
      end
      def create_group_file_folder(group_id, name)
        msg = CQHTTP::WS.format
        msg[:action] = "create_group_file_folder"
        msg[:params] = { group_id: group_id, name: name, parent_id: "/" }
        msg = JSON.pretty_generate(msg)
      end
      def delete_group_folde(group_id, folder_id)
        msg = CQHTTP::WS.format
        msg[:action] = "delete_group_folder"
        msg[:params] = { group_id: group_id, folder_id: folder_id }
        msg = JSON.pretty_generate(msg)
      end
      def get_group_root_files(group_id)
        msg = CQHTTP::WS.format
        msg[:action] = "get_group_root_files"
        msg[:params] = { group_id: group_id }
        msg = JSON.pretty_generate(msg)
      end
      def get_group_files_by_folder(group_id, folder_id)
        msg = CQHTTP::WS.format
        msg[:action] = "get_group_files_by_folder"
        msg[:params] = { group_id: group_id, folder_id: folder_id }
        msg = JSON.pretty_generate(msg)
      end
      def get_group_file_system_info(group_id)
        msg = CQHTTP::WS.format
        msg[:action] = "get_group_file_system_info"
        msg[:params] = { group_id: group_id }
        msg = JSON.pretty_generate(msg)
      end
      def get_group_file_url(group_id, file_id, busid)
        msg = CQHTTP::WS.format
        msg[:action] = "get_group_file_url"
        msg[:params] = { group_id: group_id, file_id: file_id, busid: busid }
        msg = JSON.pretty_generate(msg)
      end  
    end
  end
end

