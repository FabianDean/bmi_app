import 'dart:math' as Math;

enum Category { underweight, healthy, overweight, obese }

/*
 * Calculates BMI using the system of measurement provided.
 * Units of BMI are in kg/m^2 regardless of the system chosen.
 * Formulas from https://www.calculator.net/bmi-calculator.html 
 * @returns BMI
 */
double calculateBMI(double height, double weight, String system) {
  double bmi;
  if (system == "Imperial") {
    bmi = 703 * (weight / Math.pow(height, 2));
  } else {
    bmi = weight / Math.pow(height, 2);
  }
  bmi = double.parse(bmi.toStringAsPrecision(2));
  return bmi;
}

class Result {
  double bmi;
  String summary;
  Category category;
}
