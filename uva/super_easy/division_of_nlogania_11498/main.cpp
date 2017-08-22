// Ricardo Nieto Fuentes
// nifr91@gmail.com
// 21 Agosto 2017


#include <iostream>
using namespace std;

int main(int argc, char const *argv[]) {

  int points_number = 0;
  int cx= 0,cy=0;
  int x=0, y=0;

  cin >> points_number;
  while( points_number != 0){
    cin >> cx >> cy;

    while(points_number > 0){
      cin >> x >> y ;
      if (x == cx || y == cy) { cout << "divisa" << endl;}
      else if( x < cx)        { cout << ((y > cy)? "NO" : "SO") << endl;}
      else                    { cout << ((y > cy)? "NE" : "SE") << endl;}
      points_number -= 1;
    }

    cin >> points_number;
  }
  return 0;
}

// Problema: Se debe especificar a que cuadrante pertenecen los puntos
// Entrada: Consiste en varios casos, el final de los casos consiste en una línea
// con el número 0. Cada caso consiste:
// * La primer linea contiene un entero (0 < K <= 1_000) que indica la cantidad de
//   puntos.
// * La segunda línea contiene dos enteros (-10_000 < N, M < 10_000) que representan
//   las coordenadas del centro del sistema de coordenadas.
// * Las K siguientes lineas contienen dos enteros (-10_000 <= x, y <= 10_000) que son
//   las coordenadas de los puntos.
//
// eg.
//
// 3
// 2 1
// 10 10
// -10 1
// 0 33
// 4
// -1000 -1000
// -1000 -1000
// 0 0
// -2000 -10000
// -999 -1001
// 0
//
// Salida : Para cada caso se imprime una línea :
// * 'divisa' : si el punto esta en una de las líneas
// * 'NO'     : si el punto esta al noroeste
// * 'NE'     : si el punto esta al noreste
// * 'SE'     : si el punto esta al sureste
// * 'SO'     : si el punto esta al suroeste
//
// eg.
//
// NE
// divisa
// NO
// divisa
// NE
// SO
// SE
