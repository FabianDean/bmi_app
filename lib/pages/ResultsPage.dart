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
  UserInputModel _inputModel;

  @override
  void initState() {
    _inputModel = Provider.of<UserInputModel>(context, listen: false);
    if (_inputModel.input != null) {
      setState(() {
        // calculate BMI here
        _result = BMI.getResult(
          _inputModel.input.elementAt(0), // gender
          int.tryParse(_inputModel.input.elementAt(1)), // age
          double.parse(_inputModel.input.elementAt(2)), // height
          double.parse(_inputModel.input.elementAt(3)), // weight
          _inputModel.input.elementAt(4), // system of measurement
        );
      });
    }
    super.initState();
  }

  /* Body of the page. Contains actual content */
  Widget _resultsSection(BuildContext context) {
    Color indicatorColor;
    if (_result.category == Category.healthy)
      indicatorColor = Colors.green;
    else if (_result.category == Category.overweight)
      indicatorColor = Colors.yellow;
    else
      indicatorColor = Colors.red;

    return Consumer<UserInputModel>(
      builder: (context, userInputModel, child) {
        return userInputModel.input != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20), // add some padding to top
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
                              fontWeight: FontWeight.bold,
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
                        color: indicatorColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Chart(input: null),
                  ),
                  SizedBox(height: 10),
                  Divider(indent: 20, endIndent: 20),
                  _inputSection(),
                  Divider(indent: 20, endIndent: 20),
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

  /* Holds information used for calculation (gender, age, height, weight) */
  Widget _inputSection() {
    /* Quick helper widget to avoid code duplication in input section */
    Widget item(int i, String unit) {
      return RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: _inputModel.input.elementAt(i) == "null"
                  ? "N/A"
                  : _inputModel.input.elementAt(i),
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 18,
                  ),
            ),
            unit == null || _inputModel.input.elementAt(i) == "null"
                ? TextSpan()
                : TextSpan(
                    text: unit,
                    style: GoogleFonts.montserrat(
                      color: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.9),
                      fontSize: 18,
                    ),
                  ),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            item(0, null),
            SizedBox(height: 10),
            item(2, " in"),
          ],
        ),
        Column(
          children: <Widget>[
            item(1, " years"),
            SizedBox(height: 10),
            item(3, " lbs"),
          ],
        )
      ],
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
