#!/usr/bin/ruby

require 'socket'      # Sockets are in standard library

module Memopri
  class Printer

    DEFAULT_PORT = 16402

    def initialize(host, port = DEFAULT_PORT)
      @hostname = host
      @port     = port
      @socket   = TCPSocket.open(@hostname, @port)
    end

    def close
      @socket.close
    end

    def print(data)
      send_command([0x1b, 0x5a])
      send_command([0x05], 6)
      send_command([0x06])
      send_command([0x1b, 0x49])
      send_command([0x05], 8)
      send_command([0x06])
      send_command([0x1b, 0x50])

      length = data.size

      cmd = [
        0x02, 0x80, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x02,
        0x80, 0x00,
        (length / 16) & 0x00FF, ((length / 16) >> 8) & 0x00FF,
        (length)       & 0x00FF, ((length)       >> 8) & 0x00FF,
        0x00, 0x00,
      ]
      send_command(cmd)

      send_command([0x1b, 0x56])

      data.each_slice(64) do |x|
        send_command(x)
      end

      send_command([0x1b, 0x42])
    end

    private

    def send_command(cmd, resp_len = 1)
      raw_send(cmd)
      raw_recv(resp_len)
    end

    def raw_send(cmd)
      @socket.write(cmd.pack('C*'))
      @socket.flush
    end

    def raw_recv(len)
      @socket.read(len)
    end
  end
end


if $0 == __FILE__
  memo=Memopri::Printer.new("192.168.0.74")
  buf=[]
  data=[]
  (128*128).times{
    buf.push(1)
  }
  buf.each_slice(8){|x|
    data.push([x.join()].pack("B*"))
  }
  data = data.map{|x| x.unpack("C*")[0]}
  memo.print(data)
end
