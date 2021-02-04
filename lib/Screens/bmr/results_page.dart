import 'dart:convert';

import 'package:diet_blood_app/Screens/Login/login_screen.dart';
import 'package:diet_blood_app/Screens/bmi/bottom_button.dart';
import 'package:diet_blood_app/api/api_login.dart';
import 'package:diet_blood_app/components/reusable_card.dart';
import 'package:diet_blood_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMRResult extends StatefulWidget {
  BMRResult({
    this.tinggi,
    this.level,
    this.bmr,
    this.kalori,
    this.berat,
    this.umur,
  });
  final String level;
  final int tinggi, berat, umur;
  double bmr, kalori;
  @override
  _BMRResultState createState() => _BMRResultState();
}

class _BMRResultState extends State<BMRResult> {
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
        title: Text('BMR CALCULATOR'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Hasil Perhitungan',
                style: kTitleStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              color: Colors.greenAccent,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'BMR Anda Adalah',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.bmr.toString(),
                    style: kBMIStyle,
                  ),
                  Text(
                    'Kebutuhan Kalori Anda Adalah',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.kalori.toString(),
                    style: kBMIStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButtonBmr(
            buttonTitle: 'SIMPAN',
            onTap: () {
              _hitung(token);
            },
          ),
          BottomButtonBmr(
            buttonTitle: 'HITUNG LAGI',
            onTap: () {
              Navigator.of(context).pop();
            },
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
      "indeks": widget.bmr.toStringAsFixed(1),
      "hasil": widget.kalori.toStringAsFixed(1),
      "type": 2,
      "keterangan": '-'
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
