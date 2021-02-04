import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  int id;
  String usia;
  String tinggi;
  String berat;
  String indeks;
  String hasil;
  String keterangan;
  String type;
  String gender;
  String blood;
  String created_at;

  Data(
      {this.id,
      this.usia,
      this.tinggi,
      this.berat,
      this.indeks,
      this.gender,
      this.hasil,
      this.blood,
      this.type,
      this.keterangan,
      this.created_at});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      usia: json['usia'],
      tinggi: json['tinggi'],
      berat: json['berat'],
      indeks: json['indeks'],
      hasil: json['hasil'],
      blood: json['blood'],
      gender: json['gender'],
      type: json['type'],
      keterangan: json['keterangan'],
      created_at: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "usia": usia,
      "tinggi": tinggi,
      "berat": berat,
      "indeks": indeks,
      "hasil": hasil,
      "gender": gender,
      "blood": blood,
      "type": type,
      "keterangan": keterangan,
      "created_at": created_at,
    };
  }

  @override
  String toString() {
    return 'Data{id: $id, name: $usia, email: $tinggi}';
  }
}

List<Data> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Data>.from(data.map((item) => Data.fromJson(item)));
}

String profileToJson(Data data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class GetHome {
  Client client = Client();

  Future<List<Data>> getProfiles(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('id');
    print("tokenku: $stringValue");
    String _token = stringValue.replaceAll(new RegExp('"'), '');

    final response = await client.post(
        "https://diet-app-api.herokuapp.com/api/apps/history",
        body: {'id_user': _token});
    if (response.statusCode == 200) {
      print(response.body);
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }
}
