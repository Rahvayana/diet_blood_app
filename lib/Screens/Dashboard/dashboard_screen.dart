import 'dart:convert';

import 'package:diet_blood_app/Screens/Dashboard/components/dashboard_menu_row.dart';
import 'package:diet_blood_app/Screens/Dashboard/components/login_background.dart';
import 'package:diet_blood_app/Screens/Dashboard/components/profile_tile.dart';
import 'package:diet_blood_app/Screens/GoldarA.dart';
import 'package:diet_blood_app/Screens/GoldarAB.dart';
import 'package:diet_blood_app/Screens/GoldarB.dart';
import 'package:diet_blood_app/Screens/GoldarO.dart';
import 'package:diet_blood_app/Screens/Login/login_screen.dart';
import 'package:diet_blood_app/Screens/bmi/input_page.dart';
import 'package:diet_blood_app/Screens/bmr/input_page_BMR.dart';
import 'package:diet_blood_app/Screens/history/history.dart';
import 'package:diet_blood_app/Screens/pengingat.dart';
import 'package:diet_blood_app/Screens/posts/post.dart';
import 'package:diet_blood_app/api/api_login.dart';
import 'package:diet_blood_app/tentang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLoading = false;
  var token, nama, icon;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('id');
    if (token == null) {
      Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    } else {
      _getData(token);
    }
  }

  void _getData(String _token) async {
    var data = {'id': _token};
    print(data);
    var res = await Network().authData(data, 'api/apps/home');
    var body = json.decode(res.body);
    print(body['data']['name']);
    if (body['status'] == 200) {
      setState(() {
        nama = body['data']['name'];
        // icon = body['data']['icon'];
      });
    } else {
      // Navigator.pop(context);
    }
  }

  Size deviceSize;
  @override
  Widget appBarColumn(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(
                      defaultTargetPlatform == TargetPlatform.android
                          ? Icons.arrow_back
                          : Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.canPop(context)
                        ? Navigator.pop(context)
                        : null,
                  ),
                  new ProfileTile(
                    title: "Hi, $nama",
                    subtitle: "Selamat Datang di Aplikasi Diet Sehat",
                    textColor: Colors.white,
                  ),
                  new IconButton(
                    icon: new Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _showMyDialog();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      );
  Widget actionMenuCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.hospital,
                    firstLabel: "A",
                    firstIconCircleColor: Colors.redAccent,
                    firstNavigator: GoldarA(),
                    secondIcon: FontAwesomeIcons.hospital,
                    secondLabel: "B",
                    secondIconCircleColor: Colors.redAccent,
                    secondNavigator: GoldarB(),
                    thirdIcon: FontAwesomeIcons.hospital,
                    thirdLabel: "AB",
                    thirdIconCircleColor: Colors.redAccent,
                    thirdNavigator: GoldarAB(),
                    fourthIcon: FontAwesomeIcons.hospital,
                    fourthLabel: "O",
                    fourthIconCircleColor: Colors.redAccent,
                    fourthNavigator: GolDarO(),
                  ),
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.book,
                    firstLabel: "Tips",
                    firstIconCircleColor: Colors.red,
                    firstNavigator: ListPost(),
                    secondIcon: FontAwesomeIcons.calculator,
                    secondLabel: "BMI",
                    secondIconCircleColor: Colors.cyan,
                    secondNavigator: InputPage(),
                    thirdIcon: FontAwesomeIcons.calculator,
                    thirdLabel: "BMR",
                    thirdIconCircleColor: Colors.yellow,
                    thirdNavigator: BMRScreen(),
                    fourthIcon: FontAwesomeIcons.history,
                    fourthLabel: "History",
                    fourthIconCircleColor: Colors.brown,
                    fourthNavigator: History(),
                  ),
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.clock,
                    firstLabel: "Pengingat",
                    firstIconCircleColor: Colors.cyan,
                    firstNavigator: Pengingat(),
                    secondLabel: "Tentang",
                    secondNavigator: TentangAplikasi(),
                    secondIcon: FontAwesomeIcons.addressBook,
                    secondIconCircleColor: Colors.green,
                    thirdLabel: "",
                    thirdIconCircleColor: Colors.white,
                    // fourthIcon: FontAwesomeIcons.history,
                    fourthLabel: "",
                    fourthIconCircleColor: Colors.white,
                    // fourthNavigator: History(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget allCards(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            appBarColumn(context),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            actionMenuCard(),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoginBackground(
            showIcon: false,
          ),
          allCards(context),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Apakah Anda Yakin?"),
          content:
              new Text("Setelah Log Out Anda Akan diarahkan Ke Form Login"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Log Out"),
              onPressed: () {
                Navigator.of(context).pop();
                logout();
              },
            ),
          ],
        );
      },
    );
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('id');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
