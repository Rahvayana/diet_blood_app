import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kActiveCardColor = Color(0xff1D1F33);
const kInactiveCardColor = Colors.grey;
const kBottomContainerColor = Color(0xffEA1556);
const kBottomContainerHeight = 80.0;

const kLabelStyle = TextStyle(
  fontSize: 16,
  color: Color(0xff8d8e98),
);

const kNumberStyle = TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900);

const kLargeButtonStyle =
    TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold);

const kTitleStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

const kResultStyle = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xff24d876));

const kBMIStyle = TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold);

const kBodyStyle = TextStyle(
  fontSize: 16.0,
);

const Map<String, Color> weightColor = {
  "Underweight": Color(0xff33B1E4),
  "Normal": Color(0xff94C947),
  "Overweight": Color(0xffF99929),
  "Obesity": Color(0xffC92C33)
};
