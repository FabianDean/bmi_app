import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/SectionTitle.dart';
import '../utils/globals.dart' as Globals;

class BugReportPage extends StatefulWidget {
  @override
  _BugReportPageState createState() => _BugReportPageState();
}

class _BugReportPageState extends State<BugReportPage> {
  final _formKey = GlobalKey<FormState>();

  final String disclaimerText =
      "This mobile app is intended for informational, educational, and research purposes only. It is not, and is not intended, for use in the diagnosis of disease or other conditions, or in the cure, mitigation, treatment, or prevention of disease. Health care providers should exercise their own independent clinical judgement when using the mobile app in conjunction with patient care.";

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  bool _validateEmail(String email) {
    RegExp regExp = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Globals.mainColor,
          title: Text(
            "Report a bug",
            style: GoogleFonts.montserrat(),
          ),
        ),
        body: SafeArea(
          minimum: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                "Please fill out the form below explaining your bug/issue.",
                style: Theme.of(context).textTheme.caption,
                textScaleFactor: 1.4,
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SectionTitle("Email"),
                    SizedBox(height: 5),
                    TextFormField(
                      style: TextStyle(
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                      decoration: InputDecoration(
                        hintText: "Your email",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty || !(_validateEmail(value))) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    SectionTitle("Message"),
                    SizedBox(height: 5),
                    TextFormField(
                      maxLines: 6,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                      decoration: InputDecoration(
                        hintText: "Explain the bug here",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      color: Globals.mainColor,
                      textColor: Colors.white,
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a snackbar
                          // TODO: handle report

                          Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Bug report submitted. Thank you!')));
                        }
                      },
                      child: Text('Submit'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        // allows tap outside of TextField to remove focus
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
    );
  }
}
