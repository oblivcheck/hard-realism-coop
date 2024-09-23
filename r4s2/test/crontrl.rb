require 'socket'
require 'digest'

socket = TCPSocket.new("tx.sayuri.city", 27244)
socket.puts "::sctest_greenflu/"
data = "_R_|r14 sm plugins list"
socket.puts(data)
lines = []
while (line = socket.gets)
  lines << line  
end
puts lines
socket.close

