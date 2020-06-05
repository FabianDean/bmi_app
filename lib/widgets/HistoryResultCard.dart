import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../utils/bmi.dart' as BMI;
import '../utils/Result.dart';

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
    final Result result = BMI.getResult(height, weight, system);
    Color indicatorColor;
    if (result.category == Category.underweight ||
        result.category == Category.obese)
      indicatorColor = Colors.red;
    else if (result.category == Category.healthy)
      indicatorColor = Colors.green;
    else if (result.category == Category.overweight)
      indicatorColor = Colors.yellow;

    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 0,
        right: 20,
        top: 0,
        bottom: 0,
      ),
      leading: SizedBox(
        width: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(0),
              width: 10,
              decoration: BoxDecoration(
                color: indicatorColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
            Icon(
              gender == "Male" ? FontAwesome.male : FontAwesome.female,
              color: gender == "Male" ? Colors.lightBlue : Colors.pinkAccent,
              size: 50,
            ),
          ],
        ),
      ),
      title: Container(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: Column(
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
            result.bmi.toString(),
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
