import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;

class DataPost {
  int id;
  String golongan;
  String text;

  DataPost({this.id, this.golongan, this.text});

  factory DataPost.fromJson(Map<String, dynamic> json) {
    return DataPost(
        id: json['id'], golongan: json['golongan'], text: json['text']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "golongan": golongan,
      "text": text,
    };
  }

  @override
  String toString() {
    return 'Data{id: $id, name: $golongan, email: $text}';
  }
}

List<DataPost> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<DataPost>.from(data.map((item) => DataPost.fromJson(item)));
}

String profileToJson(DataPost data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class GetPost {
  Client client = Client();

  Future<List<DataPost>> getProfiles() async {
    final response =
        await client.get("https://diet-app-api.herokuapp.com/api/apps/getPost");
    if (response.statusCode == 200) {
      print(response.body);
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }
}
