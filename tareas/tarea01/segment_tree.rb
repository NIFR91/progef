
# Ricardo Nieto Fuentes
# nifr91@gmail.com

#===============================================================================

# Implementación de la estructura de datos segment_tree para el problema MKTHNUM
#
class Segment_tree

  # Constructor ----------------------------------------------------------------

  # Constructor
  #
  def initialize(
    ary) # Arreglo a segmentar

    @ary = ary.dup

    # Crear vectores de mapeo
    @map = ary.uniq.sort!
    inv_map = @map.map.with_index{|e,i| [e,i]}.to_h
    @ary.map!{|e| inv_map[e]}

    # Reservar espacio para el árbol
    levels = Math.log2(ary.size).ceil
    @tree = Array.new((1 << levels) + 1,Node.new)

    # Construir el árbol
    build(1,0...@ary.size)
  end

  # Métodos públicos -----------------------------------------------------------


  # Obtener el k-esimo elemento en el intervalo especificado, Regresa el elemento
  # más pequeño que tiene mayor o igual elementos que `k`
  #
  def kth_element(
    search_range,     # Intervalo de búsqueda
    k)                # Elemento a obtener 1 <= k <= search_range.size

    kth = @map.size - 1

    # Obtenemos los segmentos que corresponden al intervalo de búsqueda
    segments = get_segments(search_range)

    # Búsqueda binaria
    lo = 0
    hi = kth

    until lo > hi

      mid = lo + (hi-lo)/2

      # Búsqueda binaria para encontrar los valores menores o iguales que mid
      leq_count = segments
        .each
        .reduce(0){ |memo,segment| memo + bsearch_leq(segment,mid) }

      if leq_count >= k
        kth = mid if mid <= kth
        hi  = mid - 1
      else
        lo  = mid + 1
      end
    end
    return @map[kth]
  end

  # Métodos privados -----------------------------------------------------------

  # Construcción del árbol de manera recursiva, se llama sobre le nodo padre
  # y se crece hacia las hojas.
  #           _______
  #          |       ▼
  # [dummy, root, left_child, right_child]
  #          |_____________________▲
  #
  # El caso base es cuando el intervalo a segmentar es un solo elemento, y el
  # caso recursivo corresponde a los nodos padre, en donde se realiza la
  # concantenación de los diferentes intervalos.
  #
  private def build(
    index,      #  Índice del nodo
    range)      #  Intervalo a segmentar

    if range.size == 1
      segment = @ary[range]
      @tree[index] = Node.new(range,segment)
      return segment
    else

      mid = range.begin + (range.end - range.begin)/2

      left_segment  = build(left_child(index) , range.begin..mid   )
      right_segment = build(right_child(index), (mid+1)..range.end )

      segment = merge(left_segment,right_segment)

      @tree[index] = Node.new(range, segment)

      return segment
    end
  end

  # Combinar manteniendo el orden de dos arreglos.
  #
  private def merge(
    left,   # Arreglo izquierda
    right)  # Arreglo derecha


    result = Array.new(left.size + right.size)

    l_cnt, r_cnt, cnt = 0,0,0

    while l_cnt < left.size && r_cnt < right.size

      if left[l_cnt] < right[r_cnt]
        result[cnt] =  left[l_cnt]
        l_cnt += 1
      else
        result[cnt] = right[r_cnt]
        r_cnt += 1
      end

      cnt += 1
    end

    aux,a_cnt = (l_cnt == left.size)? [right,r_cnt] : [left,l_cnt]

    (a_cnt...aux.size).each do |k|
      result[cnt] = aux[k]
      cnt += 1
    end

    return result
  end

  # Obtener el nodo hijo izquierdo
  #
  private def left_child(
    index) # Índice del nodo padre

    index << 1
  end

  # Obtener el nodo hijo derecho
  #
  private def right_child(
    index) # Índice del nodo padre

    return (index << 1 ) + 1
  end

  # Obtener los segmentos asociados al intervalo de búsqueda de manera recursiva
  #
  private def get_segments(
    search_range,     # Intervalo de búsqueda
    index = 1,        # Índice del nodo padre
    segments = [])    # Vector que contendrá los segmentos.

    node_range = @tree[index].range

    if node_range.begin > search_range.end  || node_range.end < search_range.begin
      return segments
    elsif node_range.begin >= search_range.begin && node_range.end <= search_range.end
      segments.push(@tree[index].segment)
      return segments
    else
      get_segments(search_range, left_child(index),  segments)
      get_segments(search_range, right_child(index), segments)
      return segments
    end
  end

  # Realiza una búsqueda binaria que encuentra la cantidad de valores menores o
  # iguales que `value`.
  #
  private def bsearch_leq(
    segment,       # Arreglo ordenado
    value)         # Valor a comparar

    # Casos extremos.
    return 0            if value < segment[0]
    return segment.size if value > segment[-1]

    # Búsqueda binaria
    lo = 0
    hi = segment.size - 1

    until  lo > hi
      mid = lo + (hi-lo)/2

      if segment[mid] <= value
        lo = mid + 1
      else
        hi = mid - 1
      end
    end

    # Para obtener la cantidad de objetos es el índice + 1
    return hi + 1
  end

  # Estructura auxiliar -------------------------------------------------------------

  class Node
    attr_accessor :range
    attr_accessor :segment
    def initialize(range = 0.0,segment = [])
      @range  = range
      @segment = segment
    end
  end
end
