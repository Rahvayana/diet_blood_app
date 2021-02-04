import 'package:diet_blood_app/Screens/history/detail.dart';
import 'package:diet_blood_app/Screens/posts/DetailPost.dart';
import 'package:diet_blood_app/api/getHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String name, token;
  double lat, lng;
  var imgUrl =
      'https://media.tabloidbintang.com/files/thumb/92bc280c3b0a6e1f22a2ba3cccdc82d7.jpg';
  var title = 'Pedagang Bakso';
  var desc =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur a erat nam at.';
  GetHome getHome;
  @override
  void initState() {
    getTokenLogin();
    getHome = GetHome();
    super.initState();
  }

  getTokenLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('id');
    token = stringValue;
  }

  DateTime tempDate;

  @override
  Widget build(BuildContext context) {
    GetHome().getProfiles(token).then((value) => print("value: $value"));
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: getHome.getProfiles(token),
        builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Data> profiles = snapshot.data;
            return _buildListView(profiles);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Data> profiles) {
    return profiles.length != 0
        ? RefreshIndicator(
            child: ListView.builder(
              itemBuilder: (context, index) {
                Data profile = profiles[index];
                tempDate =
                    new DateFormat("yyyy-MM-dd").parse(profile.created_at);
                return Container(
                  child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(6),
                                          bottomLeft: Radius.circular(6))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 4,
                                      ),
                                      new InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailHIstory(
                                                  tanggal: tempDate.day
                                                          .toString() +
                                                      "-" +
                                                      tempDate.month
                                                          .toString() +
                                                      "-" +
                                                      tempDate.year.toString(),
                                                  usia: profile.usia,
                                                  gender: profile.gender,
                                                  berat: profile.berat,
                                                  indeks: profile.indeks,
                                                  hasil: profile.hasil,
                                                  blood: profile.blood,
                                                  type: profile.type,
                                                ),
                                              ));
                                        },
                                        child: new Padding(
                                          padding: new EdgeInsets.all(10.0),
                                          child: new Text(
                                            tempDate.day.toString() +
                                                    "-" +
                                                    tempDate.month.toString() +
                                                    "-" +
                                                    tempDate.year.toString() ??
                                                '',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                );
              },
              itemCount: profiles.length,
            ),
            onRefresh: () => getHome.getProfiles(token),
          )
        : Center(child: CircularProgressIndicator());
  }
}
