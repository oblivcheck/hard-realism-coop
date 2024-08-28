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
