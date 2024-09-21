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

    print " #{str} \n"
  end
end

module Log
  def self.prefix
    Time.now.strftime('%Y-%m-%d %H:%M:%S')
  end
  def self.sv(info, level = -1)
    print "#{Log.prefix} ".colorize(:light_black)
    print "[服务器] ".colorize(:green)
    case level
    when -1
      print "#{info}\n"
    when 0
      print "#{info}\n".colorize(:red)
    when 1
      print "#{info}\n".colorize(:yellow)
    end
  end
end
