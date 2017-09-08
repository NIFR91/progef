#!/usr/bin/env ruby

require "./trie"

nt = gets.to_i

nt.times do
  input = gets.split(" ").map{|e| e.strip.to_i}
  trie = XorTrie.new 40
  xor = 0
  input.each do |value|
    aux = trie ^ value
    xor = (xor > aux)? xor : aux
    trie << value
  end
  puts "#{xor}"
end
