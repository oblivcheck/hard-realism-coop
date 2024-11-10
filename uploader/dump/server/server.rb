require 'json'
require 'colorize'
require './config.rb'
require './cli.rb'
require './module.rb'

begin

Receive.listen
Control.listen
Receive.thread.join
 
rescue Interrupt
  msg_print("停止", :light_red);
end
