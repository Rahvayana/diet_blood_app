import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TentangAplikasi extends StatefulWidget {
  @override
  _TentangAplikasiState createState() => _TentangAplikasiState();
}

class _TentangAplikasiState extends State<TentangAplikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Aplikasi Panduan Diet Sehat Berdasarkan Golongan Darah',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            Image.asset('assets/images/maker.JPG'),
            Text('Nama: Nur Izza Maulidatur Rahmah'),
            Text('NRP: 2103197078'),
            Text('Email: nur.izzamr@gmail.com'),
            Text('Politeknik Elektronika Negeri Surabaya'),
          ],
        ),
      ),
    );
  }
}
