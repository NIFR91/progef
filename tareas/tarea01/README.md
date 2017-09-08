# Tarea 01

Resolver el problema [MKTHNUM][MKTHNUM] utilizando la estrategia 1 vista en
clase. Con esta estrategia no entra en tiempo en [SPOJG][]

## Descripción del problema

### MKTHNUM K-esimo número

Dado un arreglo `a = [0...n]` de diferentes números enteros, escribir un programa
que responde a una serie de preguntas del tipo `Q(i..j,k)` en la forma:
¿Cuál es el k-ésimo número en el segmento `s = [i..j]` si estuviera ordenado?.

Ejemplo :

~~~ruby

a = [1, 5, 2, 6, 3, 7, 4]
Q(2..5,3) #=>  5
~~~

debido a que :

~~~ruby
s = a[2..5] #=> [5,2,6,3]
s.sort!     #=> [2,3,5,6]
s[2]        #=> [5]
~~~


#### Entrada

La primer línea contiene dos números `1 <= N <= 100_000` y `1 <= M <= 5_000`,
donde `N` el tamaño del arreglo y `M` la cantidad de peticiones a responder.

La segunda línea contiene los `N` números  del arreglo separados por un espacio.

Las siguientes `M` líneas contienen la descripción de la pregunta, consiste de
tres números `i`, `j` y `k`  con `1 <= i <= j <= n`  y ` 1 <= k <= j-i + 1 `, los
cuales  representan la pregunta `Q(i..j,k)`.

~~~
7 3
1 5 2 6 3 7 4
2 5 3
4 4 1
1 7 3
~~~

#### Salida

En cada línea se coloca la solución a la pregunta.

~~~
5
6
3
~~~

--------------------------------------------------------------------------------

## Solución ingenua

Consiste en ordenar el segmento del arreglo y regresar el k-esimo valor.

~~~ruby
ary[i..j].sort![k] #=> K esimo valor del intervalo i.j
~~~

Al realizar el ordenamiento se tiene complejidad `O(N lg(N))`

## Solución lg³(N)

### Segment tree

Es una estructura estática que permite almacenar y procesar
intervalos o segmentos.

Por ejemplo si se quiere expresar la siguiente secuencia
`[3, 8, 2, 3, 5, 100, 36, 105]` su representación será

~~~ruby

                                       0..7
                                        +
                 0..3                                     4..7
                  +----------------------------------------+
       0..1                  2..3                4..5                 6..7
         +--------------------+                   +--------------------+
   0..0      1..1       2..2      3..3      4..4      5..5      6..6      7..7
    +---------+          +---------+         +---------+          +---------+
  [3]        [8]        [2]        [3]     [5]       [100]      [36]       [105]
~~~

en donde cada nodo representa un segmento del intervalo y nos permite almacenar
información relevante al segmento.

De esta forma cuando se pregunta por un segmento, se tiene que encontrar el
sub-conjunto de segmentos involucrados del cual como máximo existen `lg(N)`.


### Construcción del árbol

Para representar los nodos del árbol se emplea la siguiente estructura:

~~~ruby
class Node
  attr_accessor :range
  attr_accessor :segment
  def initialize(range = 0.0,segment = [])
    @range  = range
    @segment = segment
  end
end
~~~

En donde la variable `range` almacena el intervalo y la variable `segment`
los datos sobre el intervalo, en este problema el segmento ordenado.

Para representar el árbol se emplea un
vector de nodos:

~~~ruby
tree = [nil, root_node, child_left, child_right, ... ]
~~~

Para acceder a los nodos hijos se emplean las siguientes funciones :

~~~ruby
def left_child(index)
  return index << 1
end

def right_child(index)
  return (index << 1 ) + 1
end
~~~

La construcción del árbol se realiza de manera recursiva, mediante la función
`build(.)`

~~~ruby
def build(index, range)

  if range.size == 1
    segment = @ary[range]
    @tree[index] = Node.new(range,segment)
    return segment
  else

    mid = range.begin + (range.begin - range.end)/2

    left_segment  = build(left_child(index) , range.begin..mid   )
    right_segment = build(right_child(index), (mid+1)..range.end )

    segment = merge(left_segment,right_segment)

    @tree[index] = Node.new(range, segment)

    return segment
  end
end
~~~

en donde tenemos  dos variables privadas `@ary` que contiene el arreglo que se
desea procesar y `@tree` que contiene `⌈lg(N)⌉ + 1 	` nodos
y almacena el árbol.

El caso base de esta función recursiva es cuando se tiene un elemento que es
cuando el rango abarca solo 1 valor. El caso recursivo es cuando el rango es
mas grande, de esta manera se llama a la función sobre el nodo izquierdo que
va del inicio del rango a la mitad y después sobre el nodo derecho que va de
la mitad del rango mas uno al final del rango.

Finalmente se almacena en el nodo la concatenación de los segmentos de los nodos
hijo, los cuales se encuentran ordenados de menor a mayor. Para ello se emplea
la función `merge(.)` del algoritmo **MergeSort**.

~~~ruby
def merge(left,right)

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
~~~

### Obtener el k-ésimo valor

Para ello primero se deben obtener los segmentos que abarcan el rango que se
desea.

~~~ruby
def get_segments( search_range,index = 1,segments = [])

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
~~~

En donde el caso base es que el segmento del nodo esta completamente incluido
en el rango que se busca, de manera que se incluye en el arreglo auxiliar
`segments`. El caso recursivo  llama la función  sobre los nodos hijo, y se
corta la búsqueda de la rama si el segmento del nodo esta completamente fuera
del intervalo de búsqueda.


Finalmente para obtener el valor k esimo se debe notar que se esta buscando
el valor más pequeño que tenga al menos k elementos menores o iguales que el.
De manera que podemos encontrarlo empleando una búsqueda binaria en el rango
`0..MAX_VAL` para mejorar el rendimiento del algoritmo es importante destacar que
lo importante es el valor relativo entre los números por lo que los valores pueden
compactarse

~~~ruby
@map    = @ary.uniq.sort!
inv_map = @map.map.with_index{|e,i| [e,i]}.to_h
@ary.map!{|e| inv_map[e]}
~~~

de esta manera se trabaja en un rango `0..M` con `0 <= M <= N`. La respuesta
será entonces el valor mas pequeño en el rango `0..M` que tenga al menos `k`
elementos menores entre los segmentos obtenidos mediante la función
*get_segments(.)*

~~~ruby
def kth_element(search_range,k)
  kth = @map.size - 1
  segments = get_segments(search_range)

  lo = 0
  hi = kth

  until lo > hi
    mid = lo + (hi-lo)/2

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
~~~

Podemos ver que si la cantidad de elementos en los segmentos es mayor o igual que
`k` el valor que buscamos no es `mid` pero sabemos que se encuentra entre
`lo..mid-1`. En caso contrario la cuenta es menor entonces sabemos que el número
esta en el intervalo `mid+1..hi`. Como el problema permite números repetidos
debemos tener en cuenta que el valor puede tener más de `k` elementos menores
pues puede haber `s` repeticiones de si mismo, por ello la búsqueda esta sesgada
a la izquierda y se regresa el menor valor que tenga `leq_count >= k`

La función ***bsearch_leq(.)*** es una búsqueda binaria que regresa la cantidad
de elementos menores o iguales que `mid`, en el segmento `segment`.

~~~ruby
def bsearch_leq( segment,value)
  return 0            if value < segment[0]
  return segment.size if value > segment[-1]

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
  return hi + 1
end
~~~


[MKTHNUM]:http://www.spoj.com/problems/MKTHNUM
[SPOJG]:http://www.spoj.com
