#!/usr/bin/ruby

require 'memopri'
require 'memopri/finder.rb'
require 'memopri/printer.rb'
require 'memopri/renderer.rb'
require 'memopri/version.rb'

require 'optparse'

devices = Memopri::Finder.find
device = nil

if devices == nil
  exit -1
end

opt = OptionParser.new

opt.on('-n VAL'){|v|
  device = devices[v.to_i]
}
opt.parse!(ARGV)

if device == nil
  device = devices[0]
end

str_data = Memopri::Renderer.new("REGZA Z1: 2011年頃購入", 3)
memopri = Memopri::Printer.new(device[1][-1])
memopri.print(str_data.conv)
