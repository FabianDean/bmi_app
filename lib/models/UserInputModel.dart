import 'package:flutter/material.dart';

class UserInputModel with ChangeNotifier {
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
