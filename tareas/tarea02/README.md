# Tarea 2

## Descripción del problema

* 9 puntos:  Resolver el problema de encontrar el máximo XOR entre cualesquiera
dos números de un arreglo, utilizando el algoritmo visto en clase que hace uso
de tries. Se probará con arreglos de hasta `100_000` números en el rango `0..10⁹`
y deberá dar respuesta en menos de 1 segundo.

* 1 punto: Extender el algoritmo anterior para que dado un arreglo de hasta
`100_000` elementos en el rango `0..10⁹` se pueda encontrar el sub-arreglo
(continuo y puede ser de un único elemento) con máximo XOR e imprimir dicho valor.
Se deberá dar respuesta en menos de 1 segundo. Por ejemplo si el arreglo es
`[3 7 7 7 0]` se deberá imprimir `7`, mientras que para `[3 8 2 6 4]` se deberá
responder `5`.

### Entrada

La primer línea contiene un entero `N` que indica la cantidad de casos de prueba,
las `N` siguientes líneas contienen el arreglo que contiene `1..100_000`
elementos separados por un espacio.

~~~
2
3 7 7 7 0
3 7 2 6 4
~~~

### Salida

En cada línea se coloca la solución del problema

~~~
7
5
~~~

--------------------------------------------------------------------------------

## Trie

Estructura de datos tipo árbol muy utilizada para guardar palabras, pues esta
dedicada a la recuperación de esta de manera eficiente. Una palabra es una
secuencia de símbolos de un alfabeto.

Recuperar la información del **trie**
cuesta `O(W)` donde `W` es el tamaño máximo de la palabra almacenada. Y el
espacio requerido es `O(A W N)`, en donde `A` es el tamaño del alfabeto y `N`
el número de palabras almacenadas en el árbol.

Por ejemplo si el alfabeto es `a..z` y queremos representar en un **trie** las
siguientes palabras :

* casa
* cama
* camaleón
* camarón
* camarero

~~~ruby
                        /
                       'c'
                       'a'
                's' --------- 'm'
                'a'*          'a'*
                          'l' ---- 'r'
                          'e'   'o' --- 'e'
                          'o'   'n'*    'r'
                          'n'*          'o'*
~~~

En donde `*` representa el fin de una palabra, de esta manera obtener o colocar
en el árbol tomará O(W).


## Construcción del Trie

En el problema las palabras son la representación binaria de un entero sin signo
de manera que la profundidad `W` del árbol es : `ceil( lg(10⁹) )` y el alfabeto
es `{0,1}`.

De esta manera se puede representar el árbol mediante una lista ligada simple
de arreglos de dimensión dos.

De manera que para representar el árbol

~~~ruby
           /
      0 -------- 1
   0------1   0------+

   .      .   .
   0      1   2
~~~

tenemos :

~~~ruby
@root    = [ nil,nil ]                  #=> Raíz del arbol
@root[0] = [ [ nil,nil ],[ nil,nil ] ]  #=> Rama 0
@root[1] = [ [ nil,nil ],nil ]          #=> Rama 1

@root #=> [[[nil,nil],[nil,nil]],[[nil,nil],nil]]
~~~


Representamos el árbol mediante una clase **XorTrie**

~~~ruby
class XorTrie
  def initialize(bits=30)
    @root = [nil,nil]
    @bits = bits
  end
end
~~~

la cual contiene dos variables `@root` que contiene el árbol y la variable
`@bits` que contiene la cantidad de bits representados (la profundidad del árbol).


Para agregar un elemento al árbol se emplea:

~~~ruby
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
~~~

en donde para obtener el bit del nivel se emplea `((value >> (level-1)) & 1)`
que desplaza a la izquierda el bit de interés y lo extrae mediante `& 1`. Se
comienza desde el bit más significativo al menos significativo

~~~ruby
a = 0b100_000_000_000_000_000_000_000_000_100

a >> 30 & 1 #=> 0
a >> 29 & 1 #=> 1
a >> 28 & 1 #=> 0
~
a >> 3  & 1 #=> 0
a >> 2  & 1 #=> 1
a >> 1  & 1 #=> 0
~~~

## Obtener el máximo XOR

Para obtener el máximo XOR (`^`) posible con todas las palabras del árbol:

~~~ruby
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
~~~

en donde en caso de estar vacío se regresa el valor. En caso contrario,
a partir del bit más significativo hasta el menos significativo, se realiza
bit a bit el XOR. Siguiendo la rama del árbol que permita generar el XOR más
grande.


## XOR máximo entre cualquier par de números

Para resolverlo se agregan los números al **trie** y en cada etapa se va
obteniendo el máximo XOR. Al incluir el último elemento se han comprobado todos
los XOR más grandes que se pueden generar.

~~~ruby
trie = Trie.new

xor = 0
input.each do |value|
  aux = trie ^ value
  xor = (xor > aux)? xor : aux
  trie << value
end

xor #=> Máximo XOR entre las posibles combinaciones de dos elementos del arreglo
~~~

## XOR máximo de todos los posibles sub-arreglos

Lo primero es mostrar que el `XOR([L..R]) = XOR([0..R]) ^ XOR([0...L])` en donde
`XOR([1,2,3]) = 1^2^3`.

Para mostrar lo anterior se observa que  `XOR([1,2,3]) == XOR([3,2,1])` y
`a ^ a = 0`. De esta manera si tenemos el arreglo `[1,2,3,4,5]` y queremos
el `XOR([2..4])` tenemos

~~~ruby
a = [1,2,3,4,5]

b = a[2..4]                  #=> [3,4,5]
XOR(b)                       #=> 2

XOR(a[0..5])                 #=> 1
XOR(a[0...2])                #=> 3
1^3                          #=> 2

XOR(a[0...2]) ^ XOR(a[0..5]) #=> 2^1 ^ 1^2^3^4^5
                             #=> 2   ^   2^3^4^5
                             #=> 3^4^5
                             #=> 2
~~~

Con lo anterior podemos ver que requerimos almacenar en el **trie** los XOR de
los arreglos `[0..0], [0..1], [0..2], ... , [0..k-1]` y si se realiza el XOR con
el arreglo `[0..k]`, se realiza el XOR de todos los posibles sub-arreglos. De
esta forma el algoritmo es

~~~ruby
trie = XorTrie.new
xor = 0
sub_ary_xor = 0
trie << 0
input.each do |value|
  xor ^= value
  trie << xor
  aux = trie ^ xor
  sub_ary_xor = (sub_ary_xor > aux)? sub_ary_xor : aux
end

sub_ary_xor #=> máximo XOR de los sub-arreglos de `input`
~~~
