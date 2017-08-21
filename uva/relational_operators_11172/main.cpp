// Ricardo Nieto Fuentes
// nifr91@gmail.com
// 21 Agosto 2017

#include <iostream>
using namespace std;

// Problema : Determinar la relación entre dos numeros
// Entrada  : Un entero determinando el número de pares a seguir, y después en
// cada linea dos enteros separados por un espacio.
//
// eg,
// 3
// 10 20
// 20 10
// 10 10
//
// Salida  : En cada línea se coloca el simbolo de la relación <=> entre los dos
// números.
//
// eg.
// <
// >
// =
//
int main(int argc, char const *argv[]) {
  string line;

  int sets_number = 0;
  int a_num = 0, b_num = 0;

  cin >> sets_number;

  while(sets_number > 0) {
    cin >> a_num >> b_num;
    cout << ((a_num > b_num)? ">" : ((a_num == b_num)? "=" : "<")) << endl;
    sets_number -= 1;
  }

  return 0;
}
