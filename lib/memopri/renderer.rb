#!/usr/bin/ruby

require 'cairo'
require 'pango'

class Memopri
class Renderer

  attr_accessor :str, :nol

  def initialize(str="", nol=1)
    @str = str
    @nol = nol
  end

  def conv()
    format = Cairo::FORMAT_ARGB32
    width = nil
    height = 128
    surface = Cairo::ImageSurface.new(format, 0, 128)
    context = Cairo::Context.new(surface)
    layout = context.create_pango_layout
    layout.text = str
    font_description = Pango::FontDescription.new("Sans-serif 18")

    size = nil
    begin
      font_description.size *= 1.06
      layout.font_description = font_description
      size = layout.size.map{|x| x/Pango::SCALE}
    end while size[1] <= ((125/@nol.to_f) - 2)

    width = (size[0])/(@nol.to_f)

    surface = Cairo::ImageSurface.new(format, width, 128)
    context = Cairo::Context.new(surface)
    layout = context.create_pango_layout
    layout.text = str
    layout.width = width * Pango::SCALE
    layout.wrap = Pango::WRAP_CHAR
    layout.font_description = font_description
    context.translate(5, 5)
    context.show_pango_layout(layout)
    context.show_page

    surface.write_to_png("/tmp/hinomaru.png")

    data = []

    surface.data.unpack("C*").each_slice(4) {|x|
      x = x[3] > 10 ? 1 : 0
      data.push(x)
    }

    data2 = []
    data.each_slice(width) {|x|
      data2.push(x)
    }
    data = data2.transpose.flatten

    ret = []
    data.each_slice(8) {|x|
      ret.push([x.join()].pack("B*"))
    }
    ret = ret.map{|x| x.unpack("C*")[0]}
    return ret
  end
end
end

if $0 == __FILE__
  r = Memopri::Renderer.new("あああああ", 3)
  r.conv()
end
