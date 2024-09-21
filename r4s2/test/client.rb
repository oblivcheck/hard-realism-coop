require 'socket'
require 'digest'

socket = TCPSocket.new("10.10.10.90", 27243)
name = "test.vpk"
file_path = name
#sleep 60
socket.puts "::sctest_greenflu/"

file_size = File.size(file_path)
data = "#{name},#{file_size.to_s}"
socket.puts(data)
puts "发送文件大小: #{file_size} 字节"

sha256 = Digest::SHA256.new
File.open(file_path, 'rb') do |file|
  while chunk = file.read(1024)
    socket.write(chunk)
    sha256.update(chunk)
  end
end

sha256 = sha256.hexdigest
puts "#{sha256}"
socket.puts "#{sha256}1"
loop do 
  msg = socket.gets
  puts "##{msg}"
  break
end
socket.close

