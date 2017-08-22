// Ricardo Nieto Fuentes
// nifr91@gmail.com
// 21 Agosto 2017

#include <iostream>
#include <deque>
#define loop while(true)

int main(int argc, char const *argv[]) {

  int    months         = 0;
  double down_payment   = 0;
  double loan           = 0;
  int    records_number = 0;
  int    record_month   = 0;
  double drop           = 0;
  double car_value      = 0;


  loop {

    // Obtener datos, terminar cuando se recibe la bandera.
    std::cin >> months >> down_payment >> loan >> records_number;
    if(months < 0 ){break;}

    // Calcular el pago por mes y el valor del coche.
    double payment = loan/months;
    car_value = loan + down_payment;

    // Obtener los records.
    std::deque<std::pair<int,double>> records;
    while (records_number > 0){
      std::cin >> record_month >> drop;
      records.push_back(std::make_pair(record_month,drop));
      records_number -= 1;
    }

    // Sacar el coche lo deavalua
    drop = records.front().second;
    records.pop_front();
    car_value *=(1.0-drop);

    // Caso base en el que desde siempre se gana.
    if(loan < car_value){ std::cout << 0 << " " << "months" << std::endl; }
    else{

      // Para cada mes
      int cnt= 1;
      while(cnt <= months){

        // Verificamos cambia la devaluación
        if (cnt == records.front().first){
          drop = records.front().second;
          records.pop_front();
        }

        // Pagar y devaluar.
        car_value *= (1.0 - drop);
        loan -= payment;

        // Si se cumple la condición terminamos y mostramos el resultado
        if(loan < car_value){
          std::cout << cnt << " " << ((cnt==1)? "month" : "months") << std::endl;
          break;
        }

        cnt+=1;
      }
    }
  }
  return 0;
}


// Problema : El precio de un objeto se deprecia cada mes, calcular la primer vez,
// medida en emeses que el comprador tiene menos dinero de lo que vale el objeto.
//
// Entrada: Consiste en varios prestamos, para cada prestamo :
//   * Una línea que contiene :
//     * La duración del prestamo
//     * El pago
//     * La cantidad del prestamo
//     * La cantidad de cambios de depreciación.
//
//   La entrada de datos termina con una duración de prestamo negativa.
//
// eg.
//
// 30 500.0 15000.0 3
// 0 .10
// 1 .03
// 3 .002
// 12 500.0 9999.99 2
// 0 .05
// 2 .1
// 60 2400.0 30000.0 3
// 0 .2
// 1 .05
// 12 .025
// -99 0 17000 1
//
// Salida
//
// Para cada prestamo la salida es el número de meses antes de que se deba más de
// lo que vale el coche.
//
//
// eg.
// 4 months
// 1 month
// 49 months
