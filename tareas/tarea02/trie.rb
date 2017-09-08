#!/usr/bin/env ruby

# Ricardo Nieto Fuentes
# nifr91@gmail.com

# Trie que permite calcular el máximo XOR de un valor con los elementos del
# árbol.
#
class XorTrie

  # Constructor
  #
  def initialize(bits = 30)
    @root = [nil,nil]
    @bits = bits
  end

  # Agregar un elemento al trie
  #
  def <<(value)
    parent = @root
    level  = @bits

    until level == 0
      bit = ((value >> (level-1)) & 1)
      parent[bit] = [nil,nil] if parent[bit].nil?
      parent = parent[bit]
      level -= 1
    end
  end

  # Operación XOR con el trie
  #
  def ^(value)

    return value if empty?

    xor    = 0
    parent = @root
    level  = @bits

    until level == 0

      bit = ((value >> (level-1)) & 1)

      parent = if bit == 0
        if (parent[1].nil?)
          parent[0]
        else
          xor |= (1 << level-1)
          parent[1]
        end
      else
        if (parent[0].nil?)
          parent[1]
        else
          xor |= (1 << level-1)
          parent[0]
        end
      end

      level -= 1
    end

    return (xor > value)? xor : value
  end

  # El árbol esta vacio si no tiene ramas
  #
  def empty?
    @root[0].nil? && @root[1].nil?
  end
end
