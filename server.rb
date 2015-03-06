require 'pry'
require 'socket'

class Server
  def initialize(port)
    # Create socket and bind to address
    @port   = port
    @client = UDPSocket.new
  end

  def perform
    @client.bind('0.0.0.0', @port)
    while true do
      data, addr = @client.recvfrom(1024) # if this number is too low it will drop the larger packets and never give them to you
      args = data.split(',')
      ack(args) if args.include? 'PING'
    end
  end

  def ping(port)
    data = ['I sent this', @port, 'PING']
    puts "Ping sent msg: '%s' from: '%s' to: '%s'" % [data[0], @port, port]
    @client.send(data.join(','), 0, '127.0.0.1', port)
  end

  def ack(data)
    port = data[1]
    data = ['I respond this', @port, 'ACK']
    puts "Ack sent msg: '%s' from: '%s' to: '%s'" % [data[0], @port, port]
    @client.send(data.join(','), 0, '127.0.0.1', port)
  end
end
