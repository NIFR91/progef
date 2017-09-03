#!/usr/bin/env ruby

# Ricardo Nieto Fuentes
# nifr91@gmail.com
#
#
# lines = STDIN.readlines.map{|e| e.strip}.to_a

input = ""


# Límites
n = 100_000 #rand(1..100_000)
m = 5_000 #rand(1..5_000)

input << "#{n} #{m}\n"

ary = n.times.to_a.shuffle!

input << "#{ary.join(" ")}\n"

m.times do |k|
  i = rand(1..n)
  j = rand(i..n)
  k = rand(1..(j-i+1))

  input << "#{i} #{j} #{k} \n"
end

file = File.new "input.txt", "w+"
file << input
file.close

output = ""
lines = input.each_line.to_a
lines.shift(2)
lines.each do |line|
  i,j,k = line.strip.split(" ").map{|e| e.to_i}
  i -= 1
  j -= 1
  output <<  "#{ary[i..j].sort![k-1]}\n"
end

file = File.new "output.txt", "w+"
file << output
file.close
