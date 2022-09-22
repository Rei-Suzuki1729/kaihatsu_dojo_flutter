import 'package:first_app/EnterPages/atomosphere_enter_widget.dart';

enum Factors {
  atomosphere,
  temperature,
  calorie,
}

String toString(Factors factor) {
  switch (factor) {
    case Factors.atomosphere:
      return "atomosphere";
    case Factors.temperature:
      return "temperature";
    case Factors.calorie:
      return "calorie";
  }
}
