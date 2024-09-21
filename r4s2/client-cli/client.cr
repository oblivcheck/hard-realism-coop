require "socket"

def main
  if ARGV.size < 2
    puts "缺少参数:"
    puts "命令 类型 \"参数1 参数2 ...\""
    abort
  end

  socket = TCPSocket.new("tx.sayuri.city", 27244)
  socket.puts "::sctest_greenflu/"

  type = "R"
  type = "S" unless ARGV[0] == "R"
  args = ARGV[1]
  data = "_#{type}_|#{args}"
  socket.puts(data)
  lines = [] of String
  while (line = socket.gets)
    lines << line
  end
  lines.each do |line|
    puts line
  end
  socket.close
end

main
