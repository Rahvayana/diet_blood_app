import 'dart:math';

class CalculatorBMR {
  final int height;
  final int weight;
  final String level;
  double _bmi;

  CalculatorBMR({this.height, this.weight, this.level});

  String getBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi > 30)
      return 'Obesitas';
    else if (_bmi > 25)
      return 'Gemuk';
    else if (_bmi > 18.5)
      return 'Normal';
    else
      return 'Kurus Sekali';
  }

  String getInterpretation() {
    if (_bmi > 30)
      return 'Tidak!!! Kamu memiliki berat badan yang berlebihan untuk seoran yang normal, segera kosultasi ke dokter.';
    else if (_bmi > 25)
      return 'Warning!!! Berat badan yang kamu miliki lebih dari orang normal, cobalah hidup sehat dan berolahraga.';
    else if (_bmi > 18.5)
      return 'WOW! Kamu memiliki berat badan yang normal, Pertahankan!!!';
    else
      return 'Ohh! Berat badan Kamu sangat kurang dari normal, makanlah dan jaga kesehatan!!';
  }
}
