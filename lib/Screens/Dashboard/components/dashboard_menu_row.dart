import 'package:diet_blood_app/Screens/Dashboard/components/label_below_icon.dart';
import 'package:diet_blood_app/Screens/bmi/input_page.dart';
import 'package:flutter/material.dart';

class DashboardMenuRow extends StatelessWidget {
  final firstLabel;
  final IconData firstIcon;
  final firstIconCircleColor;
  final firstNavigator;
  final secondLabel;
  final IconData secondIcon;
  final secondIconCircleColor;
  final secondNavigator;
  final thirdLabel;
  final IconData thirdIcon;
  final thirdIconCircleColor;
  final thirdNavigator;
  final fourthLabel;
  final IconData fourthIcon;
  final fourthIconCircleColor;
  final fourthNavigator;

  const DashboardMenuRow(
      {Key key,
      this.firstLabel,
      this.firstIcon,
      this.firstIconCircleColor,
      this.firstNavigator,
      this.secondLabel,
      this.secondIcon,
      this.secondIconCircleColor,
      this.secondNavigator,
      this.thirdLabel,
      this.thirdIcon,
      this.thirdIconCircleColor,
      this.thirdNavigator,
      this.fourthLabel,
      this.fourthIcon,
      this.fourthIconCircleColor,
      this.fourthNavigator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          LabelBelowIcon(
              icon: firstIcon,
              label: firstLabel,
              circleColor: firstIconCircleColor,
              onPressed: firstNavigator),
          LabelBelowIcon(
            icon: secondIcon,
            label: secondLabel,
            circleColor: secondIconCircleColor,
            onPressed: secondNavigator,
          ),
          LabelBelowIcon(
            icon: thirdIcon,
            label: thirdLabel,
            circleColor: thirdIconCircleColor,
            onPressed: thirdNavigator,
          ),
          LabelBelowIcon(
            icon: fourthIcon,
            label: fourthLabel,
            circleColor: fourthIconCircleColor,
            onPressed: fourthNavigator,
          ),
        ],
      ),
    );
  }
}
