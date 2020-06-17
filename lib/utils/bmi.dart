import 'dart:math' as Math;
import 'Result.dart';

/*
 * Calculates BMI using the system of measurement provided.
 * Units of BMI are in kg/m^2 regardless of the system chosen.
 * Formulas from https://www.calculator.net/bmi-calculator.html 
 * @returns BMI
 */
double _calculateBMI(double height, double weight, String system) {
  double bmi;
  if (system == "Imperial") {
    bmi = 703 * (weight / Math.pow(height, 2));
  } else {
    bmi = weight / Math.pow(height, 2);
  }
  bmi = double.parse(bmi.toStringAsPrecision(2));
  return bmi;
}

Result getResult(
    String gender, int age, double height, double weight, String system) {
  double bmi = _calculateBMI(height, weight, system);
  String summary;
  Category category;

  if (bmi < 18.5) {
    category = Category.underweight;
    summary = "You are considered underweight and possibly malnourished.";
  } else if (bmi >= 18.5 && bmi <= 24.9) {
    category = Category.healthy;
    summary = "You are within a healthy weight range.";
  } else if (bmi >= 25 && bmi <= 29.9) {
    category = Category.overweight;
    summary = "You are considered overweight.";
  } else {
    category = Category.obese;
    summary = "You are considered obese.";
  }
  return Result(bmi, summary, category);
}
