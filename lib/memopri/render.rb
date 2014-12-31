#!/usr/bin/ruby

require 'cairo'
require 'pango'

class Memopri::Render
  def self.make_bitmap(str)
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
    end while size[1] <= 100

    width = size[0] + 10

    surface = Cairo::ImageSurface.new(format, width, 128)
    context = Cairo::Context.new(surface)
    layout = context.create_pango_layout
    layout.text = str
    layout.font_description = font_description
    context.translate(0, 10)
    context.show_pango_layout(layout)
    context.show_page

    data = []

    surface.data.unpack("C*").each_slice(4) {|x|
      x = x[3] > 0 ? 1 : 0
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

if $0 == __FILE__
  p MemopriLabel.make_bitmap("ああ")
end
