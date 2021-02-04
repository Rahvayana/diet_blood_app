import 'package:diet_blood_app/Screens/bmi/bottom_button.dart';
import 'package:diet_blood_app/Screens/bmi/calculator_BMI.dart';
import 'package:diet_blood_app/Screens/bmi/results_page.dart';
import 'package:diet_blood_app/Screens/bmr/calculator_BMR.dart';
import 'package:diet_blood_app/Screens/bmr/results_page.dart';
import 'package:diet_blood_app/components/icon_content.dart';
import 'package:diet_blood_app/components/reusable_card.dart';
import 'package:diet_blood_app/components/round_icon_button.dart';
import 'package:diet_blood_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender { male, female }

class BMRScreen extends StatefulWidget {
  @override
  _BMRScreenState createState() => _BMRScreenState();
}

class _BMRScreenState extends State<BMRScreen> {
  Gender selectedGender;
  int height = 180, weight = 70, age = 20;
  double hasil, level, bmr;

  String dropdownValue = 'Sangat Jarang olahraga';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      child: ReusableCard(
                        color: (selectedGender == Gender.male)
                            ? Colors.green
                            : kInactiveCardColor,
                        onPressed: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.male,
                          label: 'PRIA',
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: ReusableCard(
                        color: (selectedGender == Gender.female)
                            ? Colors.green
                            : kInactiveCardColor,
                        onPressed: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.female,
                          label: 'PEREMPUAN',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: ReusableCard(
                  color: Colors.green,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'TINGGI',
                        style: TextStyle(color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            '$height',
                            style: kNumberStyle,
                          ),
                          Text(
                            'cm',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 15),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 30),
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Color(0xff8d8e98),
                            thumbColor: Colors.white,
                            overlayColor: Color(0x29eb1555)),
                        child: Slider(
                          value: height.toDouble(),
                          min: 50.0,
                          max: 220.0,
                          onChanged: (newValue) {
                            setState(() {
                              height = newValue.round();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        color: Colors.green,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'BERAT',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              '$weight',
                              style: kNumberStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                RoundIconButtonBMR(
                                  icon: Icons.remove,
                                  onPressed: () {
                                    setState(() {
                                      if (weight > 1) weight--;
                                    });
                                  },
                                ),
                                RoundIconButtonBMR(
                                  icon: Icons.add,
                                  onPressed: () {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: ReusableCard(
                        color: Colors.green,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'UMUR',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              '$age',
                              style: kNumberStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                RoundIconButtonBMR(
                                  icon: Icons.remove,
                                  onPressed: () {
                                    setState(() {
                                      if (age > 1) age--;
                                    });
                                  },
                                ),
                                RoundIconButtonBMR(
                                  icon: Icons.add,
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Text(
                              'Level Akitivitas Fisik',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                'Sangat Jarang olahraga',
                                'Jarang olahraga (1-3 hari/ minggu)',
                                'Normal olahraga (3-5 hari/ minggu)',
                                'Sering olahraga (6-7 hari/ minggu)',
                                'Sangat Sering Olahraga',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              BottomButtonBmr(
                buttonTitle: 'HITUNG',
                onTap: () {
                  //   BMR Pria = 66 + (13,7 x berat badan) + (5x tinggi badan) – (6,8 x usia)
                  // BMR Wanita = 655 + (9,6 x berat badan) + (1,8x tinggi badan) – (4,7 x usia)
                  if (dropdownValue == 'Sangat Jarang olahraga') {
                    level = 1.2;
                  } else if (dropdownValue ==
                      'Jarang olahraga (1-3 hari/ minggu)') {
                    level = 1.375;
                  } else if (dropdownValue ==
                      'Normal olahraga (3-5 hari/ minggu)') {
                    level = 1.55;
                  } else if (dropdownValue ==
                      'Sering olahraga (6-7 hari/ minggu)') {
                    level = 1.725;
                  } else {
                    level = 1.9;
                  }

                  if (selectedGender.index == 0) {
                    hasil =
                        (66 + (13.7 * weight) + (5 * height) - (6.6 * age)) *
                            level;
                    bmr = (66 + (13.7 * weight) + (5 * height) - (6.6 * age));
                  } else {
                    hasil =
                        (655 + (9.6 * weight) + (1.8 * height) - (4.7 * age)) *
                            level;
                  }
                  print(hasil);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BMRResult(
                              tinggi: height,
                              bmr: bmr,
                              kalori: hasil,
                              level: dropdownValue,
                              berat: weight,
                              umur: age)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
