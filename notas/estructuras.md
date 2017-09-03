# Estructuras de datos y librerías.

Una estructura de datos es un objeto que permite almacenar y organizar la
información, son una parte fundamental de los algoritmos, pues permiten
operar sobre los datos de manera eficiente.


## Lineales

Son aquellas en las que los elementos se almacenan de manera secuencial:

### Arreglos:

Son las estructuras más utilizadas y las más naturales de utilizar.

~~~ruby
ary = [1,5,3,2,4]

ary[0] #=> 1
~~~

de las operaciones más comunes realizadas sobre los arreglos son :

* Ordenar los elementos del arreglo

~~~ruby
ary.sort!  #=> [1,2,3,4,5]
~~~

* Buscar elementos en el arreglo

~~~ruby
ary.bsearch{ |x| x > 2 } #=> 3
~~~

### Mascaras de bits:

En la computadora, los enteros son representados como secuencias de bits, de
manera que pueden usarse para representar pequeños conjuntos de valores
booleanos.

~~~ruby
0   #=> 00000000
10  #=> 00001010
255 #=> 11111111
~~~

Operaciones comunes :

* Revisar el elemento

~~~ruby
s = 34        #=> 100010

j = (1 << 2)  #=> 000100
(s & j) != 0  #=> false

j = (1 << 1)  #=> 000010
(s & j) != 0  #=> true
~~~

* Encender el bit

~~~ruby
s = 34       #=> 100010
j = (1 << 3) #=> 001000

s |= j       #=> 101010
~~~

* Apagar el bit

~~~ruby
s = 42       #=> 101010
j = (1 << 3) #=> 001000

s &= ~j      #=> 100010
~~~

* Cambiar de estado el bit

~~~ruby
s = 42       #=> 101010
j = (1 << 3) #=> 001000

s ^= j       #=> 100010
s ^= j       #=> 101010
~~~

### [Listas ligadas]():

Esta estructura en general se evita en los problemas de competencia, debido a
su in-eficiencia al acceder a los elementos (debe realizarse un barrido lineal
sobre sus elementos cada vez que se desea acceder a uno).
