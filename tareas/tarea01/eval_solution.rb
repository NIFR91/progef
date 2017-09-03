#!/usr/bin/env ruby

begin
raise "\
Este programa se encarga de comparar dos archivos, requiere como argumentos\n\
* El nombre del archivo 1
* El nombre del archivo 2
\t #{$PROGRAM_NAME} respuesta.txt solución.txt" if ARGV.size < 2

# Programa principal ===========================================================

# Leer los archivos
lines_a = (File.new ARGV[0]).each_line.map{|e| e.strip}.to_a
lines_b =  (File.new ARGV[1]).each_line.map{|e| e.strip}.to_a

# Si tienen la misma cantidad de lineas se comparan, si no no tiene sentido
unless  lines_a.size != lines_b.size

  diff = "\nArchivo    |  #{ARGV[0]}      #{ARGV[1]}\n"
  diff << "-"*80 << "\n"

  error_count = 0
  lines_a.size.times do |index|

    a_line = lines_a[index]
    b_line = lines_b[index]

    if a_line != b_line
      error_count += 1
      diff << "line #{index} #=> |  #{a_line}      #{b_line}\n"
    end
  end

  diff << "-"*80 << "\n"
  diff << "Se han encontrado #{error_count} errores\n"
  diff << "NOT OK"
  diff = "OK" if error_count == 0
else
 diff = "Los archivos no tienen la misma cantidad de lineas\n"
 diff << "NOT OK"
end

puts diff

rescue Exception => e
  puts e
  exit
end
