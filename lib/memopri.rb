#!/usr/bin/ruby

require 'socket'      # Sockets are in standard library

class Memopri

  def initialize(host, port=16402)
    @hostname = host
    @port = port
    @socket = TCPSocket.open(@hostname, @port)
  end

  def _send(cmd)
    cmd = cmd.pack('C*')
    @socket.write(cmd)
    @socket.flush()
  end

  def _recv(len)
    return @socket.read(len)
  end

  def print(data)
    cmd = [0x1b, 0x5a]
    _send(cmd)
    _recv(1)

    cmd = [0x05]
    _send(cmd)
    _recv(6)

    cmd = [0x06]
    _send(cmd)
    _recv(1)

    cmd = [0x1b, 0x49]
    _send(cmd)
    _recv(1)

    cmd = [0x05]
    _send(cmd)
    _recv(8)

    cmd = [0x06]
    _send(cmd)
    _recv(1)

    cmd = [0x1b, 0x50]
    _send(cmd)
    _recv(1)

    length = data.size

    cmd = [
      0x02, 0x80, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x02,
      0x80, 0x00,
      (length/16) & 0x00FF, ((length/16) >> 8) & 0x00FF,
      (length)    & 0x00FF, ((length)    >> 8) & 0x00FF,
      0x00, 0x00,
    ]
    _send(cmd)
    _recv(1)

    cmd = [0x1b, 0x56]
    _send(cmd)
    _recv(1)

    data.each_slice(64){|x|
      _send(x)
      _recv(1)
    }

    cmd = [0x1b, 0x42]
    _send(cmd)
    _recv(1)
  end
end


if $0 == __FILE__
  memo=Memopri.new("192.168.0.74")
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
