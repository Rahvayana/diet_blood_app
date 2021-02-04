import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pengingat extends StatefulWidget {
  @override
  _PengingatState createState() => _PengingatState();
}

class _PengingatState extends State<Pengingat> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    getPengingat();
    // showNotification();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    super.initState();
  }

  SharedPreferences localStorage;
  String jam;
  int hour, minute, second;
  void getPengingat() async {
    localStorage = await SharedPreferences.getInstance();
    setState(() {
      jam = localStorage.getString('jam');
      hour = localStorage.getInt('hour');
      minute = localStorage.getInt('minute');
      second = localStorage.getInt('second');
    });
    showDailyAtTime(hour ?? 6, minute ?? 0, second ?? 0);
    print('hour $hour');
  }

  Future<void> saveColor(String _jam, int hour, int minute, int second) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("jam", _jam);
    prefs.setInt("hour", hour);
    prefs.setInt("minute", minute);
    prefs.setInt("second", second);
  }

  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return NewScreen(
        payload: payload,
      );
    }));
  }

  Future<void> showDailyAtTime(int hour, int minute, int second) async {
    print('Jamku: $hour');
    var time = Time(hour, minute, second);
    print('HAHAHA: ${time.hour}:${time.minute}.${time.second}');
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 4',
      'CHANNEL_NAME 4',
      "CHANNEL_DESCRIPTION 4",
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Hitung BMI Sekarang!!!',
      'Hitung Pakai BMI Sekarang yuk!',
      time,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text('Pengingat'),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Pengingat: $jam',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            FlatButton(
                onPressed: () {
                  DatePicker.showTimePicker(context, showTitleActions: true,
                      onChanged: (date) {
                    // print('change $date in time zone ' +
                    //     date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    setState(() {
                      jam = date.hour.toString() +
                          ":" +
                          date.minute.toString() +
                          ":" +
                          date.second.toString();
                      hour = date.hour;
                      minute = date.minute;
                      second = date.second;
                      saveColor(jam, date.hour, date.minute, date.second);
                    });
                  }, currentTime: DateTime.now());
                  showDailyAtTime(hour, minute, second);
                },
                child: Text(
                  'Pilih Jam Pengingat ',
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  // showNotification() async {
  //   var time = Time(hour, minute, second);
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'repeatDailyAtTime channel id',
  //     'repeatDailyAtTime channel name',
  //     'repeatDailyAtTime description',
  //     icon: '@mipmap/ic_launcher',
  //     largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
  //   );
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.showDailyAtTime(
  //       0,
  //       'Hitung BMI Sekarang!!!',
  //       'Hitung Pakai BMI Sekarang yuk!',
  //       time,
  //       platformChannelSpecifics);
  // }
}

class NewScreen extends StatelessWidget {
  String payload;

  NewScreen({
    @required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload),
      ),
    );
  }
}
