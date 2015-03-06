require 'socket'
require './server.rb'

BasicSocket.do_not_reverse_lookup = true

members = Array.new
(1..4).each do |member|
  server = Server.new(member.to_s * 5 )
  members << server
  Process.fork { server.perform }
end

members.first.ping(22222)


