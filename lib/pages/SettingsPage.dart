import 'package:flutter/material.dart';
import '../utils/globals.dart' as globals;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  int _counter = 0;

  @override
  bool get wantKeepAlive => true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text("Settings: " + _counter.toString()),
          MaterialButton(
            child: Icon(Icons.add),
            onPressed: _incrementCounter,
          )
        ],
      ),
    );
  }
}
