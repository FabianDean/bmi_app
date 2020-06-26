import 'CalcBMI.dart' as CalcBMI;

enum Category { underweight, healthy, overweight, obese }

class Result {
  double bmi;
  String summary;
  Category category;

  Result(b, s, c) {
    bmi = b;
    summary = s;
    category = c;
  }
}

/*
 * Calculates BMI using the system of measurement provided.
 * @returns BMI
 */
Result getResult(
    String gender, int age, double height, double weight, String system) {
  int ageInMonths;
  if (age != null) {
    ageInMonths = age * 12; // floor for now; impl. months future update
  }

  Map<String, dynamic> calculations;

  if (system == "Metric") {
    calculations = CalcBMI.calcBMIandPerc_Metr(
        weight, height, gender == "Male" ? "1" : "2", ageInMonths);
  } else {
    calculations = CalcBMI.calcBMIandPerc_Eng(
        weight, height, gender == "Male" ? "1" : "2", ageInMonths);
  }

  double bmi = calculations["bmi"];
  String summary;
  Category category;

  if (bmi < 18.5) {
    category = Category.underweight;
    summary =
        "This result is considered underweight. Further assessment by a healthcare provider is suggested to determine possible causes.";
  } else if (bmi >= 18.5 && bmi <= 24.9) {
    category = Category.healthy;
    summary = "This result is within a healthy weight range.";
  } else if (bmi >= 25 && bmi <= 29.9) {
    category = Category.overweight;
    summary = "This result is considered overweight.";
  } else {
    category = Category.obese;
    summary =
        "This result is considered obese and points to possible weight-related health problems. Further assessment by a healthcare provider is suggested to determine possible causes.";
  }
  return Result(bmi, summary, category);
}
