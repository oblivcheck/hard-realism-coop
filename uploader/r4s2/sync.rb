module GroupFileSync
  # Todo: 包括2个方法，拉取整个文件夹并同步与事件触发同步
  class << self
    def sync(ws)
      @thread = Thread.new do
        puts "开始了"
        @msg = CQHTTP::Ws.get_group_file_list("300129041", 0, 5, "#{Config.sync_folder}")
        # @msg = CQHTTP::Ws.get_group_file_count(300129041)
        ws.send(@msg)
      end
    end
    def get_sync_folder_info
      Config.sync_folder
    end
  end
end
