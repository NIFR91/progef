// Ricardo Nieto Fuentes
// nifr91@gmail.com
// 21 Agosto 2017

#include <algorithm>
#include <iostream>
#include <vector>

int main(int argc, char const *argv[]) {

  int cases_number = 0;
  std::cin >> cases_number;
  std::vector<int> numbers(3);

  int cnt = 1;
  while(cnt <= cases_number){
    std::cin >> numbers[0] >> numbers[1] >> numbers[2];
    std::sort(numbers.begin(),numbers.end());
    std::cout << "Case " << cnt << ": " << numbers[1] << std::endl;
    cnt+=1;
  }

  return 0;
}


// Problema: Se dan tres números y se debe dar el que intermedio.
// Entrada: La primer línea contiene un entero (0 < T < 20) que indica los casos,
// seguida de las T líneas las cuales contienen tres enteros distintos, separados por un
// espacio.
//
// eg
//
// 3
// 1000 2000 3000
// 3000 2500 1500
// 1500 1200 1800
//
// Salida: Para cada caso se coloca el número del caso seguido del entero
// intermedio
//
// eg
//
// Case 1: 2000
// Case 2: 2500
// Case 3: 1500
