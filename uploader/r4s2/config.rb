require 'toml-rb'
module Config
  @config_file = './config/config.toml'
  @config = TomlRB.load_file(@config_file)
  # path = [Config.server_log_path, Config.server_data_path]
  class << self
    def load_config
      @config = TomlRB.load_file(@config_file)
    end

    def config_reload
      load_config
      msg_print("[INFO]", :blue)
      puts "配置已重新加载\n"
    end

    def config_get(type, key)
      @config.dig(type, key)
    end

    def onebot_enable
      config_get("onebot", "enable")
    end

    def onebot_address
      config_get("onebot", "address")
    end

    def onebot_port(type)
      if type == "http"
        config_get("onebot", "port_http")
      else  config_get("onebot", "port_wsv")
      end
    end

    def onebot_qq
      config_get("onebot", "qq")
    end

    def group_id
      config_get("group", "id")
    end

    def path_all(isshell)
      isshell == "true" ? config_get("path", "all") : config_get("path", "all-tmpf")
    end

    def sync_folder
      config_get("sync", "folder_id")
    end

    def r_server_address
      config_get("server", "r_address")
    end

    def r_server_port
      config_get("server", "r_port")
    end

    def r_server_thread_maxnum
      config_get("server", "r_thread_maxnum")
    end
    
    def r_server_thread_timeout
      config_get("server", "r_thread_timeout")
    end

    def v_server_address
      config_get("server", "v_address")
    end
 
    def v_server_port
      config_get("server", "v_port")
    end

    def v_server_thread_maxnum
      config_get("server", "v_thread_maxnum")
    end
    
    def v_server_thread_timeout
      config_get("server", "v_thread_timeout")
    end

    def c_enable
      config_get("server", "c_enable")
    end

    def c_server_address
      config_get("server", "c_address")
    end
 
    def c_server_port
      config_get("server", "c_port")
    end

    def c_server_thread_maxnum
      config_get("server", "c_thread_maxnum")
    end
    
    def c_server_thread_timeout
      config_get("server", "c_thread_timeout")
    end
    # 测试用的临时密钥
    def server_verify_key
      config_get("server", "verify_key")
    end
    def server_verify_ckey
      config_get("server", "verify_ckey")
    end

    def server_save_path
      config_get("server", "save_path")
    end

    def server_data_path
      config_get("server", "data_path")
    end

    def server_log_path
      config_get("server", "log_path")
    end
  end
  # :)
  `mkdir -p data`
  Dir.mkdir(Config.server_log_path) unless Dir.exist?(Config.server_log_path)
  Dir.mkdir(Config.server_data_path) unless Dir.exist?(Config.server_data_path)
end
