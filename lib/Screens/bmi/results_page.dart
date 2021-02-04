import 'dart:convert';

import 'package:diet_blood_app/Screens/Login/login_screen.dart';
import 'package:diet_blood_app/Screens/bmi/bottom_button.dart';
import 'package:diet_blood_app/api/api_login.dart';
import 'package:diet_blood_app/components/reusable_card.dart';
import 'package:diet_blood_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsPage extends StatefulWidget {
  ResultsPage({
    this.bmiResult,
    this.resultText,
    this.interpretation,
    this.tinggi,
    this.gender,
    this.blood,
    this.berat,
    this.menu,
    this.umur,
  });
  final String bmiResult;
  final String menu, blood;
  final String resultText;
  final String interpretation;
  final int tinggi, berat, umur, gender;
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  String token;
  bool _isLoading = false;

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('id');
    if (token == null) {
      Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Hasil Perhitungan',
                  style: kTitleStyle,
                  textAlign: TextAlign.center,
                ),
                ReusableCard(
                  color: Colors.redAccent,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.resultText.toUpperCase(),
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.bmiResult,
                        style: kBMIStyle,
                      ),
                      Text(
                        widget.interpretation,
                        style: kBodyStyle,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Menu Makanan:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Html(
                        data: widget.menu,
                      ),
                    ],
                  ),
                ),
                BottomButton(
                  buttonTitle: 'SIMPAN',
                  onTap: () {
                    _hitung(token);
                  },
                ),
                BottomButton(
                  buttonTitle: 'HITUNG LAGI',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _hitung(String _token) async {
    showAlertDialog(context);
    setState(() {
      _isLoading = true;
    });
    var data = {
      "id_user": _token,
      "berat": widget.berat,
      "tinggi": widget.tinggi,
      "usia": widget.umur,
      "indeks": widget.resultText,
      "type": 1,
      "blood": widget.blood,
      "gender": widget.gender,
      "hasil": widget.bmiResult,
      "keterangan": widget.interpretation
    };
    print(data);
    var res = await Network().authData(data, 'api/apps/hitung');
    var body = json.decode(res.body);
    print(body['status']);
    if (body['status'] == 200) {
      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('id', json.encode(body['data']));
      Navigator.pop(context);
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
