def msg_print(str, color = "")
  if color == ""
    print "[I] #{str} \n".colorize(:light_black)
    return
  else
    case color
    when :light_red
      print "[W]".colorize(color)
      print " #{str} \n".colorize(color)
      return
    when :blue
      print "[N]".colorize(color)
    when :red
      print "[N]".colorize(color)
    else
      print "[I]".colorize(:light_black)
    end

    print "#{str} \n"
    Log.write(str)
  end
end

module Log
  @log_path = "#{Config.server_log_path}/#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.log"
  def self.prefix
    Time.now.strftime('%Y-%m-%d %H:%M:%S')
  end
  @thread_num = 0
  def self.sv(prefix, info, level = -1)
    print "#{Log.prefix} ".colorize(:light_black)
    print "Thread@Server"
    print "#{prefix}".colorize(:green)
    case level
    when -1
      print "#{info}\n"
    when 0
      print "#{info}\n".colorize(:red)
    when 1
      print "#{info}\n".colorize(:yellow)
    end
    log = "[L=#{level}*#{Log.prefix} Thread@Server##{prefix}#{info}"
    @thread_num +=1
    if @thread_num <= 16
      if @thread_num > 10
        log = "#Waring @thread_num > 10# #{log}"
      end
      Thread.new(log) do
        Log.write(log)
        @thread_num = @thread_num -1
      end
    end
  end
  def self.write(log)
    log = "#{log}\n"
    File.open(@log_path, "a+") do |file|
      file.write(log)
    end
  end
end
