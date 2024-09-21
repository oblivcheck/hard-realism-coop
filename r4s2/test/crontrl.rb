require 'socket'
require 'digest'

socket = TCPSocket.new("10.10.10.90", 27244)
socket.puts "::sctest_greenflu/"
data = "_S_|move"
socket.puts(data)
lines = []
while (line = socket.gets)
  lines << line  
end
puts lines
socket.close

