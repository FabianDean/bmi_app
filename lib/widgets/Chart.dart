import 'package:flutter/material.dart';
import '../utils/globals.dart' as Globals;

class Chart extends StatelessWidget {
  Chart(this.input);

  final List<String> input;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Globals.mainColorDark,
      width: MediaQuery.of(context).size.width,
      height: 250,
    );
  }
}
