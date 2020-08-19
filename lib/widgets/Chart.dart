import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/Result.dart';

class Chart extends StatefulWidget {
  final Category category;

  Chart({Key key, this.category}) : super(key: key);
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    String imagePath = '';

    if (widget.category == Category.healthy) {
      imagePath = 'assets/images/BMI_chart_normal.svg';
    } else if (widget.category == Category.underweight) {
      imagePath = 'assets/images/BMI_chart_underweight.svg';
    } else if (widget.category == Category.overweight) {
      imagePath = 'assets/images/BMI_chart_overweight.svg';
    } else if (widget.category == Category.obese) {
      imagePath = 'assets/images/BMI_chart_obese.svg';
    }

    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          imagePath,
        ),
      ),
    );
  }
}
