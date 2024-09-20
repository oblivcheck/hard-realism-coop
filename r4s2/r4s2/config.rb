require 'toml-rb'
module Config
  @config_file = './config/config.toml'
  @config = TomlRB.load_file(@config_file)

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
  end
end
