import 'package:flutter/material.dart';
import 'package:easy_bmi/models/SystemModel.dart';
import 'package:provider/provider.dart';
import '../utils/globals.dart' as globals;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final systemModel = Provider.of<SystemModel>(context, listen: false);

    return SafeArea(
      minimum: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text("Settings"),
          MaterialButton(
            child: Icon(Icons.add),
            onPressed: systemModel.changeSystem,
          )
        ],
      ),
    );
  }
}
