require 'toml-rb'
module Config
  @config_file = './config/config.toml'
  @config = TomlRB.load_file(@config_file)
  # path = [Config.server_log_path, Config.server_data_path]
  Dir.mkdir(Config.server_log_path) unless Dir.exist?(Config.server_log_path)
  Dir.mkdir(Config.server_data_path) unless Dir.exist?(Config.server_data_path)

  class << self
    def load_config
      @config = TomlRB.load_file(@config_file)
    end
    def config_get(type, key)
      @config.dig(type, key)
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
end
