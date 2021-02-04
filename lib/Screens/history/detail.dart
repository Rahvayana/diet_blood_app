import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';

class DetailHIstory extends StatefulWidget {
  final String tanggal, usia, berat, indeks, hasil, blood, type, gender;
  // tanggal: profile.created_at,
  // usia: profile.usia,
  // berat: profile.berat,
  // indeks: profile.indeks,
  // hasil: profile.hasil,
  // blood: profile.blood,
  // type: profile.type,
  DetailHIstory(
      {Key key,
      @required this.tanggal,
      @required this.usia,
      @required this.berat,
      @required this.indeks,
      @required this.hasil,
      @required this.gender,
      @required this.blood,
      @required this.type})
      : super(key: key);
  @override
  _DetailHIstory createState() => _DetailHIstory();
}

class _DetailHIstory extends State<DetailHIstory> {
  String keterangan;
  @override
  Widget build(BuildContext context) {
    print('gender ${widget.gender}');
    if (widget.blood == 'O' && widget.gender == '0') {
      keterangan =
          '<ol style="list-style-type: decimal;margin-left:29.299999999999997px;"> <li>Bacon, daging angsa</li> <li>Ikan barakuda, ikan salmon asap, dan gurita</li> <li>Kembang kol, terong, jagung, dan kentang.</li> <li>Kacang tanah dan minyak safflower</li> <li>Beri hitam, pisang raja, alpukat, dan jeruk</li> </ol>';
    } else if (widget.blood == 'O' && widget.gender == '1') {
      keterangan =
          '<ol style="list-style-type: decimal;margin-left:29.299999999999997px;"> <li>Bacon, ham, dan daging angsa</li> <li>Ikan lele, telur ikan, dan cumi-cumi</li> <li>Kubis, kecambah, jamur shiitake</li> <li>Kacang merah dan kacang dari buncis</li> <li>Stroberi, kelapa, blewah</li> </ol>';
    }
    if (widget.blood == 'A' && widget.gender == '0') {
      keterangan =
          '<p style="margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:21.3pt;line-height:107%;font-size:13px;font-family:"Times New Roman",serif;">Beberapa jenis makanan yang sebaiknya dihindari :</p> <ol style="list-style-type: decimal;margin-left:29.299999999999997px;"> <li>Jenis daging, unggas, dan makanan laut yang sebaiknya dihindari adalah lobster, gurita, ayam, daging kambing.</li> <li>Menghindari semua produk susu dan telur daoat menggantinya dengan susu kedelai.</li> <li>Sayuran seperti terong, jamur, ubi jalar.</li> <li>Buah-buahan seperti manga dan melon.</li> <li>Kacang-kacangan seperti kacang merah dan kacang pistasio.</li> <li>Minyak seperti minyak jagung, dan minyak kacang.</li> <li>Bumbu seperti mayonais dan cuka.</li> </ol>';
    } else if (widget.blood == 'A' && widget.gender == '1') {
      keterangan =
          '<p style="margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:21.3pt;line-height:107%;font-size:13px;font-family:"Times New Roman",serif;"><span style="font-size: 14px;">Beberapa jenis makanan yang sebaiknya dihindari :</span></p> <ol style="list-style-type: decimal;margin-left:29.299999999999997px;"> <li><span style="font-size: 14px;">Daging, unggas, dan makanan laut seperti tiram, belut, lobster, ayam, daging sapi.</span></li> <li><span style="font-size: 14px;">Semua produk telur dan susu bisa diganti dengan susu kedelai. Dan boleh sesekali makan yogurt dan keju.</span></li> <li><span style="font-size: 14px;">Sayuran seperti kentang, kubis, tomat.</span></li> <li><span style="font-size: 14px;">Buah-buahan seperti pisang dan jeruk.</span></li> <li><span style="font-size: 14px;">Kacang-kacangan seperti kacang mete dan kacang merah.</span></li> <li><span style="font-size: 14px;">Minyak seperti minyak wijen dan minyak safflower.</span></li> <li><span style="font-size: 14px;">Bumbu seperti saus tomat, dan merica.</span></li> </ol>';
    }
    if (widget.blood == 'B' && widget.gender == '0') {
      keterangan =
          '<p style="margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:21.3pt;line-height:107%;font-size:13px;font-family:"Times New Roman",serif;"><span style="font-size: 14px;">Beberapa jenis makanan yang sebaiknya dihindari :</span></p> <ol style="list-style-type: decimal;margin-left:29.299999999999997px;"> <li><span style="font-size: 14px;">Membatasi makanan berbahan terigu agar mengindari resiko serangan jantung juga stroke</span></li> <li><span style="font-size: 14px;">Gandum seperti tepung gandum, gandum durum, dan produk krim yang terbuat dari gandum. Karena dapat meningkatkan resiko diabetes dan kenaikan berat badan.</span></li> <li><span style="font-size: 14px;">Hndari buckwheat dan jagung.</span></li> <li><span style="font-size: 14px;">Daging ayam, daging bebek tidak direkomendasikan karena dapat menyebabkan penyakit kekebalan tubuh dan stroke.</span></li> <li><span style="font-size: 14px;">Ikan seperti ikan teri, gurita, kerrang, dan ikan salmon asap.</span></li> <li><span style="font-size: 14px;">Produk susu dan tekur boleh dikonsumsi secukupnya seperti susu sapi, keju swiss dan mentega.</span></li> <li><span style="font-size: 14px;">Biji wijen dan lentin sebaiknya dihindari karena dapat mencegah penyerapan nutrisi pada tubuh.</span></li> <li><span style="font-size: 14px;">Kacang dan biji-bijian seperti kacang mete, biji labu, kacang polong hitam</span></li> <li><span style="font-size: 14px;">Buah dan sayuran seperti buah zaitun, delima, alpukat, labu kuning, lobak/</span></li> <li><span style="font-size: 14px;">Diarang mengonsumsi minuman berkarbonasi.</span></li> </ol>';
    } else if (widget.blood == 'B' && widget.gender == '1') {
      keterangan =
          '<ol style="list-style-type: decimal;margin-left:29.299999999999997px;"> <li><span style="font-size: 14px;">Membatasi makanan yang berbahan terigu agar tidak tejadi penggumalan darah</span></li> <li><span style="font-size: 14px;">Gandum seperti tepung gandum, biji gandum roti gandum dan produk krim yang terbuat dari gandum. Karena dapat meningkatkan resiko diabetes dan kenaikan berat badan.</span></li> <li><span style="font-size: 14px;">Hndari buckwheat dan jagung.</span></li> <li><span style="font-size: 14px;">Daging ayam, daging angsa dan daging burung tidak direkomendasikan karena dapat menyebabkan penyakit kekebalan tubuh dan stroke.</span></li> <li><span style="font-size: 14px;">Ikan seperti tiram, kerang, udang dan lobster.</span></li> <li><span style="font-size: 14px;">Produk susu dan tekur boleh dikonsumsi secukupnya seperti keju cheddar, keju bire dan mentega.</span></li> <li><span style="font-size: 14px;">Biji wijen dan lentin sebaiknya dihindari karena dapat mencegah penyerapan nutrisi pada tubuh.</span></li> <li><span style="font-size: 14px;">Kacang dan biji-bijian seperti kacang pistachio, biji bunga matahari.</span></li> <li><span style="font-size: 14px;">Buah dan sayuran seperti buah delima, kelapa, ara, sawu, tomat, kecambah.</span></li> <li><span style="font-size: 14px;">Diarang mengonsumsi minuman berkarbonasi</span></li> </ol>';
    }
    if (widget.blood == 'AB' && widget.gender == '0') {
      keterangan =
          '<p style="margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:21.3pt;line-height:107%;font-size:13px;font-family:"Times New Roman",serif;"><span style="font-size: 14px;">Beberapa jenis makanan yang sebaiknya dihindari :</span></p> <ol style="list-style-type: decimal;margin-left:29.299999999999997px;"> <li><span style="font-size: 14px;">Daging ayam sebaiknya dihindari karena menyebabkan autoimun</span></li> <li><span style="font-size: 14px;">Produk susu yang sebaiknya dihindari seperti mentega, keju amerika, es krim, dan blue cheese</span></li> <li><span style="font-size: 14px;">Kacang dan biji-bijian yang sebaiknya dihindari seperti biji labu, kacang hitam, hazelnut.</span></li> <li><span style="font-size: 14px;">Buah-buahan yang sebaiknya dihindari adalah alpukat, belmbing dan jambu.</span></li> <li><span style="font-size: 14px;">Sayuran yang sebaiknya dihindari karena dapat meningkatkan asam lambung seperti jagung, jamur, paprika.</span></li> <li><span style="font-size: 14px;">Jenis minyak yang sebaiknya dihindari adalah minyak kelapa.</span></li> </ol>';
    } else if (widget.blood == 'AB' && widget.gender == '1') {
      keterangan =
          '<p style="margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:21.3pt;line-height:107%;font-size:13px;font-family:"Times New Roman",serif;"><span style="font-size: 14px;">Beberapa jenis makanan yang sebaiknya dihindari :</span></p> <ol style="list-style-type: decimal;margin-left:29.299999999999997px;"> <li><span style="font-size: 14px;">Jenis daging yang sebaiknya dihindari antara lain dagi sapi, daging ayam daging asap, daging bebek, lobster, dan kepiting.</span></li> <li><span style="font-size: 14px;">Produk susu yang sebaiknya dihindari seperti susu murni, es krim, dan butter.</span></li> <li><span style="font-size: 14px;">Jenis kacang dan biji-bijian yang sebaiknya dihindari adalah biji wijen dan kacang hitam.</span></li> <li><span style="font-size: 14px;">Buah-buahan yang sebaiknya dihindari adalah jeruk karena dapat menyebabkan iritasi pada lambung.</span></li> <li><span style="font-size: 14px;">Jenis sayuran yang sebaiknya dihindari karena dapat meningkat kadar asam pada lambung seperti paprika, acar, dan lobak.</span></li> <li><span style="font-size: 14px;">Jenis minyak yang sebaiknya dihindari seperti minyak bunga matahari dan minyak wijen.</span></li> </ol>';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tanggal ?? ''),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(
                      color: Colors.black26, width: 1, style: BorderStyle.none),
                  children: [
                    TableRow(children: [
                      TableCell(child: Center(child: Text('Tanggal'))),
                      TableCell(
                        child: Center(child: Text(':')),
                      ),
                      TableCell(
                          child: Center(
                        child: Text(widget.tanggal),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(child: Center(child: Text('Usia'))),
                      TableCell(
                        child: Center(child: Text(':')),
                      ),
                      TableCell(
                          child: Center(child: Text(widget.berat ?? '-'))),
                    ]),
                    TableRow(children: [
                      TableCell(child: Center(child: Text('Berat'))),
                      TableCell(
                        child: Center(child: Text(':')),
                      ),
                      TableCell(child: Center(child: Text(widget.usia ?? '-'))),
                    ]),
                    TableRow(children: [
                      TableCell(child: Center(child: Text('Indeks'))),
                      TableCell(
                        child: Center(child: Text(':')),
                      ),
                      TableCell(
                          child: Center(child: Text(widget.indeks ?? '-'))),
                    ]),
                    TableRow(children: [
                      TableCell(child: Center(child: Text('Gol Dar'))),
                      TableCell(
                        child: Center(child: Text(':')),
                      ),
                      TableCell(
                          child: Center(child: Text(widget.blood ?? '-'))),
                    ]),
                    TableRow(children: [
                      TableCell(child: Center(child: Text('Hasil'))),
                      TableCell(
                        child: Center(child: Text(':')),
                      ),
                      TableCell(child: Center(child: Text(widget.hasil ?? ''))),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Center(),
                      ),
                      TableCell(child: Center(child: Text('Keterangan'))),
                      TableCell(
                        child: Center(),
                      ),
                    ]),
                  ],
                ),
                Html(data: keterangan ?? 'Perhitungan BMR')
              ],
            ),
          ),
          elevation: 5.0,
        ),
      ),
    );
  }
}
