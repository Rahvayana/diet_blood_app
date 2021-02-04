import 'dart:convert';

import 'package:diet_blood_app/api/api_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class GolDarO extends StatefulWidget {
  @override
  _GolDarOState createState() => _GolDarOState();
}

class _GolDarOState extends State<GolDarO> {
  var judul, text;
  @override
  void initState() {
    getGOlDarO();
    super.initState();
  }

  void getGOlDarO() async {
    var res = await Network().getDataGol('api/apps/goldar/1');
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
        title: Text(judul ?? 'Golongan Darah O'),
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
