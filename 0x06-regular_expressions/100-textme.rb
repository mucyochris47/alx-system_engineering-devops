#!/usr/bin/env ruby
#this project is done by chris

puts ARGV[0].scan(/(?<=from:|to:|flags:).+?(?=\])/).join(',')
