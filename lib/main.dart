import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final biodata = <String, dynamic>{};

  MainApp({super.key}) {
    biodata['name'] = 'Rm. A2';
    biodata['email'] = 'pewe@gmail.com';
    biodata['phone'] = '088123456789';
    biodata['image'] = 'a2.jpg';
    biodata['hobby'] = 'Memasak';
    biodata['address'] = 'Jalan Pulang';
    biodata['desc'] =
        '''A bard that seems to have arrived on some unknown wind — sometimes sings songs as old as the hills, and other times sings poems fresh and new.''';
    biodata['menu'] = [
      'Bakso',
      'Soto',
      'Mie Ayam'
    ];
    biodata['openingHours'] = [
      'Senin - Jumat: 08:00 - 20:00',
      'Sabtu - Minggu: 10:00 - 22:00'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Apl Biodata",
      home: Scaffold(
        appBar: AppBar(title: const Text("Aplikasi Biodata")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              teksKotak(Colors.black, biodata['name'] ?? ''),
              Image(image: AssetImage('assets/${biodata["image"] ?? ''}')),
              SizedBox(height: 10),
              Row(
                children: [
                  btnContact(Icons.alternate_email, Colors.green[900],
                      "mailto:${biodata['email']}"),
                  btnContact(Icons.mark_email_read_rounded, Colors.blueAccent,
                      "https://wa.me/${biodata['phone']}"),
                  btnContact(Icons.phone, Colors.deepPurple,
                      "tel:${biodata['phone']}"),
                ],
              ),
              SizedBox(height: 10),
              textAttribute("Hobby", biodata['hobby'] ?? ''),
              textAttribute("Alamat", biodata['address'] ?? ''),
              SizedBox(height: 10),
              teksKotak(Colors.black38, 'Deskripsi'),
              SizedBox(height: 10),
              Text(
                biodata['desc'] ?? '',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              
              // List Menu
              teksKotak(Colors.black38, 'List Menu:'),
              ...biodata['menu']?.map<Widget>((item) => Text("• $item")) ?? [],
              SizedBox(height: 20),
              
              // Jam Buka
              teksKotak(Colors.black38, 'Jam Buka:'),
              ...biodata['openingHours']
                      ?.map<Widget>((hour) => Text(hour)) ??
                  [],
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat kotak teks dengan background tertentu
  Container teksKotak(Color bgColor, String teks) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(color: bgColor),
      child: Text(
        teks,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  // Fungsi untuk membuat atribut teks dengan label
  Row textAttribute(String judul, String teks) {
    return Row(
      children: [
        Container(
          width: 80,
          child: Text(
            " - $judul",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Text(":", style: TextStyle(fontSize: 18)),
        Text(teks, style: TextStyle(fontSize: 18)),
      ],
    );
  }

  // Fungsi untuk membuat tombol kontak
  Expanded btnContact(IconData icon, Color? color, String uri) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () async {
          if (!await launchUrl(Uri.parse(uri))) {
            throw Exception('Tidak Dapat Membuka: $uri');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        child: Icon(icon),
      ),
    );
  }
}
