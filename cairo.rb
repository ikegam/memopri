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
context.translate(20, 10)
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
data = data2.transpose

ret = ""
data.each_slice(8) {|x|
  #ret += x.join().unpack("C")
  ret += [x.join()].pack("B*")
}

p ret.size

