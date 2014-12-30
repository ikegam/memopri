#!/usr/bin/ruby

require 'socket'      # Sockets are in standard library

hostname = '192.168.0.74'
port = 16402

s = TCPSocket.open(hostname, port)
cmd = [0x1b, 0x5a].pack('C*')
s.write(cmd)
s.flush()
line = s.read(1)   # Read lines from the socket
p line

cmd = [0x05].pack('C*')
s.write(cmd)
s.flush()
line = s.read(6)   # Read lines from the socket
p line

cmd = [0x06].pack('C*')
s.write(cmd)
s.flush()
line = s.read(1)   # Read lines from the socket
p line

cmd = [0x1b, 0x49].pack('C*')
s.write(cmd)
s.flush()
line = s.read(1)   # Read lines from the socket
p line

cmd = [0x05].pack('C*')
s.write(cmd)
s.flush()
line = s.read(8)   # Read lines from the socket
p line

cmd = [0x06].pack('C*')
s.write(cmd)
s.flush()
line = s.read(1)   # Read lines from the socket
p line

cmd = [0x1b, 0x46].pack('C*')
s.write(cmd)
s.flush()
line = s.read(1)   # Read lines from the socket
p line

cmd = [0x05].pack('C*')
s.write(cmd)
s.flush()
line = s.read(8)   # Read lines from the socket
p line

cmd = [0x06].pack('C*')
s.write(cmd)
s.flush()
line = s.read(1)   # Read lines from the socket
p line

cmd = [0x1b, 0x50].pack('C*')
s.write(cmd)
s.flush()
line = s.read(1)   # Read lines from the socket
p line

cmd = [
  0x02, 0x80, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x02,
  # 0x80, 0x00, 0x2b, 0x00, 0xb0, 0x02, 0x00, 0x00,
  # 0x80, 0x00, 0x55, 0x00, 0x50, 0x05, 0x00, 0x00,
  # 0x80, 0x00, 0xa9, 0x00, 0x90, 0x0a, 0x00, 0x00,
  # 0x80, 0x00, 0xfd, 0x00, 0xd0, 0x0f, 0x00, 0x00,
  # 0x80, 0x00, rows(L:H), allbyte(L:H), 0x00, 0x00,
  #0x80, 0x00, 0x51, 0x01, 0x10, 0x15, 0x00, 0x00,
  0x80, 0x00, 0xF4, 0x01, 0x40, 0x1F, 0x00, 0x00,
].pack('C*')
s.write(cmd)
s.flush()
line = s.read(1)   # Read lines from the socket
p line

cmd = [0x1b, 0x56].pack('C*')
s.write(cmd)
s.flush()
line = s.read(1)   # Read lines from the socket
p line

require 'cairo'
require 'pango'

format = Cairo::FORMAT_ARGB32
width = 500
height = 128

surface = Cairo::ImageSurface.new(format, width, height)
context = Cairo::Context.new(surface)

font_description = Pango::FontDescription.new("Sans-serif 18")
5.times {
font_description.size *= 1.06
}
layout = context.create_pango_layout
layout.font_description = font_description
layout.text = "あああ"
context.translate(0, 10)
context.show_pango_layout(layout)
context.show_page

surface.write_to_png("hinomaru.png")
data = []

surface.data.unpack("C*").each_slice(4) {|x|
  x = x[3] > 0 ? 1 : 0
  data.push(x)
}

data2 = []
data.each_slice(500) {|x|
    data2.push(x)
}

data = data2.transpose.flatten

ret = []
data.each_slice(8) {|x|
  #ret += x.join().unpack("C")
  ret.push([x.join()].pack("B*"))
}

p ret.size

i=0
ret.each_slice(64){|x|
  cmd = x.join()
  p i+=1
  s.write(cmd)
  s.flush()
  line = s.read(1)   # Read lines from the socket
  p line
}

cmd = [0x1b, 0x42].pack('C*')
s.write(cmd)
s.flush()
line = s.read(1)   # Read lines from the socket
p line

s.close               # Close the socket when done
