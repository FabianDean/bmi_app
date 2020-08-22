import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/globals.dart' as Globals;

class DisclaimerPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Globals.mainColor,
        title: Text(
          "Disclaimer",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              disclaimerText,
              style: Theme.of(context).textTheme.caption,
              textScaleFactor: 1.2,
            ),
            SizedBox(height: 20),
            RichText(
              textScaleFactor: 1.2,
              text: TextSpan(
                text: "Details about BMI can be found ",
                style: TextStyle(
                  color: Theme.of(context).textTheme.caption.color,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: "here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await _launchInBrowser(
                              "https://www.cdc.gov/healthyweight/assessing/bmi/index.html");
                        }),
                  TextSpan(text: "."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
