import 'package:easy_bmi/models/UserInputModel.dart';
import 'package:easy_bmi/utils/Result.dart';
import 'package:easy_bmi/widgets/SectionTitle.dart';
import '../widgets/Chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/globals.dart' as Globals;
import '../utils/bmi.dart' as BMI;

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  Result _result;

  @override
  void initState() {
    final inputModel = Provider.of<UserInputModel>(context, listen: false);
    if (inputModel.input != null) {
      setState(() {
        _result = BMI.getResult(
          double.parse(inputModel.input.elementAt(2)), // height
          double.parse(inputModel.input.elementAt(3)), // weight
          inputModel.input.elementAt(4),
        ); // system of measurement
      });
    }
    super.initState();
  }

  Widget _resultsSection(BuildContext context) {
    return Consumer<UserInputModel>(
      builder: (context, userInputModel, child) {
        return userInputModel.input != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "A BMI of ",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .color
                                  .withOpacity(0.9),
                              fontSize: 22,
                            ),
                          ),
                          TextSpan(
                            text: _result.bmi.toString(),
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context).accentColor,
                              fontSize: 22,
                            ),
                          ),
                          TextSpan(
                            text: (" is considered "),
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .color
                                  .withOpacity(0.9),
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _result.category
                          .toString()
                          .substring(9)
                          .toUpperCase(), // removes "Category." in string
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context).accentColor,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Chart(null),
                  SizedBox(height: 20),
                  SectionTitle("Input"),
                  SizedBox(height: 10),
                  SectionTitle("Summary"),
                  SizedBox(height: 10),
                  Text(
                    _result.summary,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                    textScaleFactor: 1.2,
                  ),
                ],
              )
            : Text(
                "User input not detected",
                style: Theme.of(context).textTheme.headline6,
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Globals.mainColor,
        title: Text(
          "Results",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraint.maxWidth,
                  minHeight: constraint.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: _result != null
                      ? _resultsSection(context)
                      : CircularProgressIndicator(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
