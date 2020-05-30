import 'package:easy_bmi/models/UserInputModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_bmi/models/SystemModel.dart';
import '../utils/globals.dart' as globals;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<bool> _isSelected = [true, false];
  final _weightKey = GlobalKey<FormFieldState>();
  TextEditingController _weightController = TextEditingController();
  final _heightKey = GlobalKey<FormFieldState>();
  TextEditingController _heightController = TextEditingController();
  int _age;
  SharedPreferences _prefs;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getPrefs();
    super.initState();
  }

  Future<void> _getPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveData() async {
    await _prefs.setStringList(DateTime.now().toString() + "_bmi", [
      _isSelected[0] == true ? "Male" : "Female",
      _age.toString(),
      _heightKey.currentState.value.toString(),
      _weightKey.currentState.value.toString()
    ]);

    print([
      _isSelected[0] == true ? "Male" : "Female",
      _age.toString(),
      _heightKey.currentState.value.toString(),
      _weightKey.currentState.value.toString()
    ]);
  }

  void _updateInputModel() {
    final inputModel = Provider.of<UserInputModel>(context, listen: false);
    inputModel.changeInput([
      _isSelected[0] == true ? "Male" : "Female",
      _age.toString(),
      _heightKey.currentState.value.toString(),
      _weightKey.currentState.value.toString()
    ]);
  }

  bool _validateAge() {
    return _age != null && _age > 0 && _age < 111;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height < 700
                                  ? 0
                                  : 10,
                            ),
                            Text(
                              "Calculate",
                              textScaleFactor: 2.5,
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline5.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "BMI",
                              textScaleFactor: 2.0,
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          Theme.of(context).brightness == Brightness.light
                              ? 'assets/images/light_homeArt.svg'
                              : 'assets/images/dark_homeArt.svg',
                          height: MediaQuery.of(context).size.height < 700
                              ? 100
                              : null,
                        ),
                      ],
                    ),
                    Text(
                      "Gender",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height < 700 ? 5 : 10,
                    ),
                    ToggleButtons(
                      isSelected: _isSelected,
                      constraints: BoxConstraints(
                        minWidth: 100,
                        minHeight: 40,
                      ),
                      children: <Widget>[
                        Text(
                          "Male",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Female",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                      selectedColor: globals.mainColor,
                      disabledColor: Colors.black26,
                      fillColor: globals.mainColor.withOpacity(0.1),
                      borderColor: Theme.of(context).dividerColor,
                      selectedBorderColor: Theme.of(context).dividerColor,
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < _isSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              _isSelected[buttonIndex] = true;
                            } else {
                              _isSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                    ),
                    Spacer(),
                    Text(
                      "Age",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height < 700 ? 5 : 10,
                    ),
                    CupertinoPicker.builder(
                      backgroundColor: globals.mainColor.withOpacity(0.02),
                      itemExtent: 50,
                      childCount: 110,
                      itemBuilder: (context, index) {
                        if (index == 0)
                          return Center(
                            child: Text(
                              "–– Scroll to select age ––",
                              style: GoogleFonts.montserrat(
                                  color: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .color),
                            ),
                          );
                        return Center(
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: (index + 1).toString(),
                                  style: GoogleFonts.montserrat(
                                    color: globals.mainColor,
                                    fontSize: 22,
                                  ),
                                ),
                                TextSpan(
                                  text: (" years old"),
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
                        );
                      },
                      onSelectedItemChanged: (value) {
                        setState(() {
                          if (value == 0)
                            _age = null; // picker on placeholder
                          else
                            _age = value + 1;
                        });
                      },
                    ),
                    Spacer(),
                    Text(
                      "Height",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height < 700 ? 0 : 10,
                    ),
                    Consumer<SystemModel>(
                      builder: (context, systemModel, child) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                key: _heightKey,
                                controller: _heightController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: systemModel.system == System.imperial
                                    ? 2
                                    : 3,
                                buildCounter: (BuildContext context,
                                        {int currentLength,
                                        int maxLength,
                                        bool isFocused}) =>
                                    null,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: globals.mainColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Enter height",
                                  hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .color,
                                    fontSize: 20,
                                  ),
                                ),
                                cursorColor: globals.mainColor,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a number';
                                  }
                                  int height = int.parse(value);
                                  if (systemModel.system == System.imperial &&
                                          height < 20 ||
                                      height > 90) {
                                    return 'Number must be between 20 and 90';
                                  }
                                  if (systemModel.system == System.metric &&
                                          height < 50 ||
                                      height > 229) {
                                    return 'Number must be between 50 and 229';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                systemModel.system == System.imperial
                                    ? " inches (in)"
                                    : " centimeters (cm)",
                                textScaleFactor: 1.3,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .color),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Spacer(),
                    Text(
                      "Weight",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height < 700 ? 0 : 10,
                    ),
                    Consumer<SystemModel>(
                      builder: (context, systemModel, child) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                key: _weightKey,
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 3,
                                buildCounter: (BuildContext context,
                                        {int currentLength,
                                        int maxLength,
                                        bool isFocused}) =>
                                    null,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: globals.mainColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Enter weight",
                                  hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .color,
                                    fontSize: 20,
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a number';
                                  }
                                  int weight = int.parse(value);
                                  if (systemModel.system == System.imperial &&
                                          weight < 10 ||
                                      weight > 400) {
                                    return 'Number must be between 10 and 400';
                                  }
                                  if (systemModel.system == System.metric &&
                                          weight < 1 ||
                                      weight > 182) {
                                    return 'Number must be between 4 and 182';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                systemModel.system == System.imperial
                                    ? " pounds (lbs)"
                                    : " kilograms (kg)",
                                textScaleFactor: 1.3,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .color),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Spacer(),
                    Center(
                      child: MaterialButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text("CALCULATE"),
                        color: globals.mainColor,
                        textTheme: ButtonTextTheme.primary,
                        onPressed: () async {
                          bool isAgeValid = _validateAge();
                          if (!isAgeValid) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Select valid age',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                          // Validate returns true if the form is valid, otherwise false.
                          if (isAgeValid &
                              _heightKey.currentState.validate() &
                              _weightKey.currentState.validate()) {
                            await _saveData();
                            _updateInputModel();
                            Navigator.of(context).pushNamed("/results");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
