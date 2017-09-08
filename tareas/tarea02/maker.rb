#!/usr/bin/env ruby

# Ricardo Nieto Fuentes
# nifr91@gmail.com

nt = 1

file = File.new("input.in", "w+")
file.puts(nt)

nt.times do
  rand(1..100_000).times do
      file.print "#{rand(0..1_000_000_000_000)} "
  end
  file.puts
end
file.puts
file.close
