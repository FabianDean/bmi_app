import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../utils/bmi.dart' as BMI;

class HistoryResultCard extends StatelessWidget {
  HistoryResultCard(this.input);

  final List<String> input;

  @override
  Widget build(BuildContext context) {
    final String gender = input.elementAt(0);
    final int age = int.parse(input.elementAt(1));
    final double height = double.parse(input.elementAt(2));
    final double weight = double.parse(input.elementAt(3));
    final String system = input.elementAt(4);
    final double bmi = BMI.calculateBMI(height, weight, system);
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 0,
        top: 10,
        bottom: 10,
      ),
      leading: Icon(
        gender == "Male" ? FontAwesome.male : FontAwesome.female,
        size: 50,
        color: gender == "Male" ? Colors.lightBlue : Colors.pinkAccent,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(
            TextSpan(
              text: 'Age: ',
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 18,
                  ),
              children: <InlineSpan>[
                TextSpan(
                  text: "$age years old",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'Height: ',
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 18,
                  ),
              children: <InlineSpan>[
                TextSpan(
                  text: system == "Imperial" ? "$height in" : "$height cm",
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'Weight: ',
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 18,
                  ),
              children: <InlineSpan>[
                TextSpan(
                  text: system == "Imperial" ? "$weight lbs" : "$weight kg",
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "BMI",
            style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 16,
                ),
          ),
          Text(
            bmi.toString(),
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
