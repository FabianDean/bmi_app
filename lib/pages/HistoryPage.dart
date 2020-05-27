import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/globals.dart' as globals;

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
      _keys = _prefs.getKeys().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.mainColor,
        title: Text(
          "History",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          child: _keys != null && _keys.length > 0
              ? ListView.builder(
                  itemCount: _keys.length,
                  itemExtent: 60,
                  itemBuilder: (context, index) {
                    return MaterialButton(
                      child: ListTile(
                        title: Text(
                          _prefs
                              .getStringList(_keys.elementAt(index))
                              .toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      onPressed: () {},
                    );
                  },
                )
              : Text("No history"),
          onRefresh: _getData,
        ),
      ),
    );
  }
}
