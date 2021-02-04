import 'package:diet_blood_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:diet_blood_app/Screens/Login/login_screen.dart';
import 'package:diet_blood_app/Screens/Welcome/welcome_screen.dart';
import 'package:diet_blood_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

void main() async {
  runApp(Check());
}

class Check extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nayaku',
      debugShowCheckedModeBanner: false,
      home: CheckAuth(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('id');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = DashboardScreen();
    } else {
      child = LoginScreen();
    }
    return Scaffold(
      body: child,
    );
  }
}
