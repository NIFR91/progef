#!/usr/bin/env ruby

# Ricardo Nieto Fuentes
# nifr91@gmail.com

nt = gets.to_i

file = File.new("output.out","w+")

nt.times do
  ary = gets.split(" ").map{|s| s.strip.to_i}
  bits = 30
  max  = (1<<30)-1

  xormx = 0

  ary.combination(2) do |a,b|
    xor = a ^ b
    xormx = xor if xor > xormx
  end

  file.puts xormx
end
file.close 
