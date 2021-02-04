import 'package:diet_blood_app/Screens/posts/DetailPost.dart';
import 'package:diet_blood_app/api/getPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPost extends StatefulWidget {
  @override
  _ListPostState createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  GetPost getHome;
  @override
  void initState() {
    getHome = GetPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetPost().getProfiles().then((value) => print("value: $value"));
    return Container(
      color: Colors.redAccent,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tips'),
          backgroundColor: Colors.redAccent,
        ),
        body: FutureBuilder(
          future: getHome.getProfiles(),
          builder:
              (BuildContext context, AsyncSnapshot<List<DataPost>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<DataPost> profiles = snapshot.data;
              return _buildListView(profiles);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView(List<DataPost> profiles) {
    return profiles.length != 0
        ? RefreshIndicator(
            child: ListView.builder(
              itemBuilder: (context, index) {
                DataPost profile = profiles[index];
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
                                                    DetailPost(
                                                        text: profile.golongan,
                                                        text2: profile.text),
                                              ));
                                        },
                                        child: new Padding(
                                          padding: new EdgeInsets.all(10.0),
                                          child: new Text(
                                            profile.golongan ?? '',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: profiles.length,
            ),
            onRefresh: () => getHome.getProfiles(),
          )
        : Center(child: CircularProgressIndicator());
  }
}
