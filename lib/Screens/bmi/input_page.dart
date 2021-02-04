import 'package:diet_blood_app/Screens/bmi/bottom_button.dart';
import 'package:diet_blood_app/Screens/bmi/calculator_BMI.dart';
import 'package:diet_blood_app/Screens/bmi/results_page.dart';
import 'package:diet_blood_app/components/icon_content.dart';
import 'package:diet_blood_app/components/reusable_card.dart';
import 'package:diet_blood_app/components/round_icon_button.dart';
import 'package:diet_blood_app/constants.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 180, weight = 70, age = 20;
  List<String> _status = ["O", "A", "B", "AB"];
  int _stackIndex = 0;

  String _singleValue = "Text alignment right";
  String _verticalGroupValue = "O";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      color: (selectedGender == Gender.male)
                          ? Colors.red
                          : kInactiveCardColor,
                      onPressed: () {
                        setState(() {
                          selectedGender = Gender.male;
                        });
                      },
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.mars,
                        label: 'PRIA',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      color: (selectedGender == Gender.female)
                          ? Colors.red
                          : kInactiveCardColor,
                      onPressed: () {
                        setState(() {
                          selectedGender = Gender.female;
                        });
                      },
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.venus,
                        label: 'PEREMPUAN',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                color: Colors.red,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'TINGGI',
                      style: kLabelStyle,
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
                          style: kLabelStyle,
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
                          thumbColor: Color(0xffeb1555),
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
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      color: Colors.red,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'BERAT',
                            style: kLabelStyle,
                          ),
                          Text(
                            '$weight',
                            style: kNumberStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RoundIconButton(
                                icon: Icons.remove,
                                onPressed: () {
                                  setState(() {
                                    if (weight > 1) weight--;
                                  });
                                },
                              ),
                              RoundIconButton(
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
                  Expanded(
                    child: ReusableCard(
                      color: Colors.red,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'UMUR',
                            style: kLabelStyle,
                          ),
                          Text(
                            '$age',
                            style: kNumberStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RoundIconButton(
                                icon: Icons.remove,
                                onPressed: () {
                                  setState(() {
                                    if (age > 1) age--;
                                  });
                                },
                              ),
                              RoundIconButton(
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
            RadioGroup<String>.builder(
              direction: Axis.horizontal,
              groupValue: _verticalGroupValue,
              onChanged: (value) => setState(() {
                _verticalGroupValue = value;
              }),
              items: _status,
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            ),
            BottomButton(
              buttonTitle: 'HITUNG',
              onTap: () {
                print(_verticalGroupValue);
                CalculatorBMI calc =
                    CalculatorBMI(height: height, weight: weight);
                print(calc.getMenu(_verticalGroupValue, selectedGender.index));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultsPage(
                            // data: navigasi,
                            bmiResult: calc.getBMI(),
                            menu: calc.getMenu(
                                _verticalGroupValue, selectedGender.index),
                            blood: _verticalGroupValue,
                            resultText: calc.getResult(),
                            interpretation: calc.getInterpretation(),
                            tinggi: height,
                            gender: selectedGender.index,
                            berat: weight,
                            umur: age)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
