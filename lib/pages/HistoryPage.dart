import 'package:easy_bmi/models/UserInputModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/HistoryResultCard.dart';
import '../utils/globals.dart' as Globals;

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  SharedPreferences _prefs;
  List<String> _keys;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future<void> _getData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _keys = _prefs.getKeys().toList().reversed.toList();
    });
  }

  Future<void> _clearData() async {
    setState(() {
      _prefs.clear();
      _keys = null;
    });
  }

  void _viewResults(BuildContext context, int index) {
    final inputModel = Provider.of<UserInputModel>(context, listen: false);
    inputModel.changeInput(_prefs.getStringList(_keys.elementAt(index)));
    Navigator.of(context).pushNamed("/results");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Globals.mainColor,
        title: Text(
          "History",
          style: GoogleFonts.montserrat(),
        ),
        actions: <Widget>[
          _keys != null && _keys.length > 0
              ? MaterialButton(
                  child: Icon(
                    Icons.clear_all,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await _clearData();
                  },
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
        ],
      ),
      body: SafeArea(
        child: _keys != null && _keys.length > 0
            ? ListView.builder(
                itemCount: _keys.length,
                itemBuilder: (context, index) {
                  return MaterialButton(
                    child: HistoryResultCard(
                        _prefs.getStringList(_keys.elementAt(index))),
                    onPressed: () {
                      _viewResults(context, index);
                    },
                  );
                },
              )
            : SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    "No history",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
      ),
    );
  }
}
