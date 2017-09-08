#!/usr/bin/env ruby

require "./trie"

nt = gets.to_i

nt.times do

  input = gets.split(" ").map{|e| e.strip.to_i}

  trie = XorTrie.new 40
  xor = 0
  sub_ary_xor = 0
  trie << 0

  input.each do |value|
    xor ^= value
    trie << xor
    aux = trie ^ xor
    sub_ary_xor = (sub_ary_xor > aux)? sub_ary_xor : aux
  end
  puts "#{sub_ary_xor}"
end
