import 'dart:convert';

import 'package:diet_blood_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:diet_blood_app/api/api_login.dart';
import 'package:flutter/material.dart';
import 'package:diet_blood_app/Screens/Login/login_screen.dart';
import 'package:diet_blood_app/Screens/Signup/components/background.dart';
import 'package:diet_blood_app/Screens/Signup/components/or_divider.dart';
import 'package:diet_blood_app/Screens/Signup/components/social_icon.dart';
import 'package:diet_blood_app/components/already_have_an_account_acheck.dart';
import 'package:diet_blood_app/components/rounded_button.dart';
import 'package:diet_blood_app/components/rounded_input_field.dart';
import 'package:diet_blood_app/components/rounded_password_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String name, email, password, gender, usia;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            WebsafeSvg.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) {
                name = value;
              },
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedInputField(
              hintText: "Jenis Kelamin",
              onChanged: (value) {
                gender = value;
              },
            ),
            RoundedInputField(
              hintText: "Usia",
              onChanged: (value) {
                usia = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                _register();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return DashboardScreen();
                //     },
                //   ),
                // );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    showAlertDialog(context);
    setState(() {
      _isLoading = true;
    });
    var data = {
      "name": name,
      "email": email,
      "password": password,
      "gender": gender,
      "usia": usia
    };
    print(data);
    var res = await Network().authData(data, 'api/apps/register');
    var body = json.decode(res.body);
    print(body['message']);
    if (body['status'] == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('id', json.encode(body['data']));
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(builder: (context) => DashboardScreen()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.pop(context);
      // _showMsg(body['message']);
      // print();
      Fluttertoast.showToast(
          msg: body['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    setState(() {
      _isLoading = false;
    });
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
