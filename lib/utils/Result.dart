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
