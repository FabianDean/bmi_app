import 'CalcBMI.dart' as CalcBMI;

enum Category { underweight, healthy, overweight, obese }

class Result {
  double bmi;
  int zPercentile;
  String summary;
  Category category;

  Result(b, z, s, c) {
    bmi = b;
    zPercentile = z;
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
  Map<String, dynamic> calculations;

  if (system == "Metric") {
    height =
        height / 100.0; // height needed in meters – 150.0 cm / 100.0 = 1.5 mc
    calculations = CalcBMI.calcBMIandPerc_Metr(
        weight, height, gender == "Male" ? "1" : "2", age);
  } else {
    calculations = CalcBMI.calcBMIandPerc_Eng(
        weight, height, gender == "Male" ? "1" : "2", age);
  }

  double bmi = calculations["bmi"];
  int zPercentile = calculations["z_perc"];
  String summary;
  Category category;

  Map<String, String> summaries = {
    "underweight":
        "This result is considered underweight. Further assessment by a healthcare provider is suggested to determine possible causes.",
    "healthy":
        "This result is within a healthy weight range. Proper diet and exercise is still encouraged to promote good health.",
    "overweight":
        "This result is considered overweight. Although not obese, improved diet and exercise is encouraged to promote good health.",
    "obese":
        "This result is considered obese and points to possible weight-related health problems. Further assessment by a healthcare provider is suggested to determine possible causes."
  };

  // if not a BMI-for-Age calculation
  if (age == null) {
    if (bmi < 18.5) {
      category = Category.underweight;
      summary = summaries["underweight"];
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      category = Category.healthy;
      summary = summaries["healthy"];
    } else if (bmi >= 25 && bmi <= 29.9) {
      category = Category.overweight;
      summary = summaries["overweight"];
    } else {
      category = Category.obese;
      summary = summaries["obese"];
    }
  } else {
    if (zPercentile < 5) {
      category = Category.underweight;
      summary = summaries["underweight"];
    } else if (zPercentile >= 5 && zPercentile < 85) {
      category = Category.healthy;
      summary = summaries["healthy"];
    } else if (zPercentile >= 85 && zPercentile < 95) {
      category = Category.overweight;
      summary = summaries["overweight"];
    } else {
      category = Category.obese;
      summary = summaries["obese"];
    }
  }
  return Result(bmi, zPercentile == -1 ? null : zPercentile, summary, category);
}
