import 'package:flutter/material.dart';
import 'package:diet_blood_app/Screens/Signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Body(),
        ),
      ),
    );
  }
}
