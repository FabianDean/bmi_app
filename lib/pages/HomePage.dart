import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  bool _validateAge() {
    return _age != null && _age > 0 && _age < 111;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      minimum: EdgeInsets.all(20),
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
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Calculate",
                              textScaleFactor: 2.5,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "BMI",
                              textScaleFactor: 2.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Text(
                      "Gender",
                      style: TextStyle(
                        color: globals.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      height: 10,
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
                        color: globals.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      height: 10,
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
                              style:
                                  GoogleFonts.montserrat(color: Colors.black38),
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
                                    color: Colors.black54,
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
                        color: globals.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            key: _heightKey,
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 2,
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
                                color: Colors.black38,
                                fontSize: 22,
                              ),
                            ),
                            cursorColor: globals.mainColor,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a number';
                              }
                              int height = int.parse(value);
                              if (height < 20 || height > 90) {
                                return 'Number must be between 20 and 90';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            " inches",
                            textScaleFactor: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      "Weight",
                      style: TextStyle(
                        color: globals.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
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
                                color: Colors.black38,
                                fontSize: 22,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a number';
                              }
                              int weight = int.parse(value);
                              if (weight < 1 || weight > 400) {
                                return 'Number must be between 1 and 400';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            " pounds",
                            textScaleFactor: 1.5,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Center(
                      child: MaterialButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text("CALCULATE"),
                        color: globals.mainColor,
                        textTheme: ButtonTextTheme.primary,
                        onPressed: () {
                          bool isAgeValid = _validateAge();
                          if (!isAgeValid) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Select valid age'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                          // Validate returns true if the form is valid, otherwise false.
                          if (isAgeValid &
                              _heightKey.currentState.validate() &
                              _weightKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            print(_age.toString());
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('It works!')));
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
