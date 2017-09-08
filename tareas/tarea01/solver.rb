#!/usr/bin/env ruby

# Ricardo Nieto Fuentes
# nifr91@gmail.com

require "./segment_tree"

# Programa principal ===========================================================


n,m = gets.strip.split(" ").map{|e| e.to_i}
ary = gets.strip.split(" ").map{|e| e.to_i}
tree = Segment_tree.new ary

m.times do
  i,j,k = gets.strip.split(" ").map{|e| e.to_i}
  i -= 1
  j -= 1
  puts "#{tree.kth_element(i..j,k)}"
end

# Descripción ==================================================================

# ### MKTHNUM K-esimo número
#
# Dado un arreglo `a = [0...n]` de diferentes números enteros, escribir un programa
# que responde a una serie de preguntas del tipo `Q(i..j,k)` en la forma:
# ¿Cuál es el k-ésimo número en el segmento `s = [i..j]` si estuviera ordenado?.
#
# Ejemplo :
#
# ~~~ruby
#
# a = [1, 5, 2, 6, 3, 7, 4]
# Q(2..5,3) #=>  5
# ~~~
#
# debido a que :
#
# ~~~ruby
# s = a[2..5] #=> [5,2,6,3]
# s.sort!     #=> [2,3,5,6]
# s[2]        #=> [5]
# ~~~
#
#
# #### Entrada
#
# La primer línea contiene dos números `1 <= N <= 100_000` y `1 <= M <= 5_000`,
# donde `N` el tamaño del arreglo y `M` la cantidad de peticiones a responder.
#
# La segunda línea contiene los `N` números  del arreglo separados por un espacio.
#
# Las siguientes `M` líneas contienen la descripción de la pregunta, consiste de
# tres números `i`, `j` y `k`  con `1 <= i <= j <= n`  y ` 1 <= k <= j-i + 1 `, los
# cuales  representan la pregunta `Q(i..j,k)`.
#
# ~~~
# 7 3
# 1 5 2 6 3 7 4
# 2 5 3
# 4 4 1
# 1 7 3
# ~~~
#
# #### Salida
#
# En cada línea se coloca la solución a la pregunta.
#
# ~~~
# 5
# 6
# 3
# ~~~
