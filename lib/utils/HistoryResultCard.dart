import 'package:flutter/material.dart';

class HistoryResultCard extends StatelessWidget {
  HistoryResultCard(this.input);

  final List<String> input;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(20),
      title: Text(
        input.elementAt(0),
      ),
    );
  }
}
