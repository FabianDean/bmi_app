import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../widgets/SectionTitle.dart';
import '../utils/globals.dart' as Globals;

class BugReportPage extends StatefulWidget {
  @override
  _BugReportPageState createState() => _BugReportPageState();
}

class _BugReportPageState extends State<BugReportPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _messageController = TextEditingController();

  final String disclaimerText =
      "This mobile app is intended for informational, educational, and research purposes only. It is not, and is not intended, for use in the diagnosis of disease or other conditions, or in the cure, mitigation, treatment, or prevention of disease. Health care providers should exercise their own independent clinical judgement when using the mobile app in conjunction with patient care.";

  Future<void> send() async {
    final Email email = Email(
      body: _messageController.text,
      subject: "Easy BMI Bug Report",
      recipients: ["fabian@fabiandean.dev"],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Bug report submitted.';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    // leave out for now
    // _scaffoldKey.currentState.showSnackBar(
    //   SnackBar(
    //     content: Text(platformResponse),
    //   ),
    // );
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
        key: _scaffoldKey,
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
                    SectionTitle("Message"),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _messageController,
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
                      cursorColor: Globals.mainColor,
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
                      onPressed: () async {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, begin submission
                          await send();
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
