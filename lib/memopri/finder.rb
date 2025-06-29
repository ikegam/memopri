require 'socket'

module Memopri
  class Finder
    def self.find
      sendsocket = UDPSocket.new()
      recvsocket = UDPSocket.new()
      recvsocket.bind("0.0.0.0", 49168)
      sendsocket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
      recvsocket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)

      sendsocket.connect("255.255.255.255", 49167)
      sendsocket.send("MEP r2", 0)
      return [recvsocket.recvfrom(47)]
    end
  end
end

if $0 == __FILE__
  p Memopri::Finder.find
end
