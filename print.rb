#!/usr/bin/ruby

require 'memopri.rb'
require 'memopri/finder.rb'
require 'memopri/render.rb'

p Memopri::Finder.find

memopri = Memopri.new("192.168.0.74")
memopri.print(Memopri::Render.make_bitmap("REGZA Z1: 2011年頃購入"))
