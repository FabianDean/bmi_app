import 'package:easy_bmi/models/UserInputModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/globals.dart' as globals;

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

Widget _resultsSection(BuildContext context) {
  return Consumer<UserInputModel>(
    builder: (context, userInputModel, child) {
      return userInputModel.input != null
          ? ListView.builder(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              shrinkWrap: true,
              itemExtent: 60,
              itemCount: userInputModel.input.length,
              itemBuilder: (context, index) {
                return Text(
                  userInputModel.input.elementAt(index),
                  style: Theme.of(context).textTheme.headline6,
                );
              },
            )
          : Text(
              "User input not detected",
              style: Theme.of(context).textTheme.headline6,
            );
    },
  );
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.mainColor,
        title: Text(
          "Results",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return _resultsSection(context);
          },
        ),
      ),
    );
  }
}
