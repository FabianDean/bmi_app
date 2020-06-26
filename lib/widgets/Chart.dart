import 'package:flutter/material.dart';
import '../utils/globals.dart' as Globals;

class Chart extends StatefulWidget {
  final List<String> input;

  Chart({Key key, this.input}) : super(key: key);
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.red,
      ),
    );
  }
}
