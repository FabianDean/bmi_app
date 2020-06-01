import 'package:flutter/material.dart';

class UserInputModel with ChangeNotifier {
  // [gender, age, height, weight, system]
  List<String> input;

  void changeInput(List<String> newInput) {
    input = newInput;
    notifyListeners();
  }

  void clearInput() {
    input = null;
    notifyListeners();
  }
}
