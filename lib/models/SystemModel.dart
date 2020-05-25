import 'package:flutter/material.dart';

enum System { imperial, metric }

class SystemModel with ChangeNotifier {
  System system = System.imperial;

  void changeSystem() {
    if (system == System.imperial)
      system = System.metric;
    else
      system = System.imperial;
    notifyListeners();
  }

  void changeToSystem(System sys) {
    system = sys;
    notifyListeners();
  }
}
