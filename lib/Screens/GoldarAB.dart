import 'dart:convert';

import 'package:diet_blood_app/api/api_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class GoldarAB extends StatefulWidget {
  @override
  _GoldarABState createState() => _GoldarABState();
}

class _GoldarABState extends State<GoldarAB> {
  var judul, text;
  @override
  void initState() {
    getGOlDarO();
    super.initState();
  }

  void getGOlDarO() async {
    var res = await Network().getDataGol('api/apps/goldar/31');
    var body = json.decode(res.body);
    setState(() {
      judul = body['golongan'];
      text = body['text'];
    });
    print(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul ?? 'Golongan Darah AB'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Html(
            data: text ?? '',
          ),
        ),
      ),
    );
  }
}
