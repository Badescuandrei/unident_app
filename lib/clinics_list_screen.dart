import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'classes.dart';

// Uri url = Uri.parse('http://idava.ro/Obiecte/sms_gateway.apk');
String url = 'http://idava.ro/Obiecte/sms_gateway.apk';
List<Clinic> clinics = [
  Clinic(
      clinicName: 'Unident Tulcea',
      imagePath: './assets/images/clinics/clinica_tulcea_50.jpg',
      nume: 'Strada Toamnei nr. 7A',
      location: 'Unident Clinica Dentara Premium, Tulcea'),
  Clinic(
      nume: 'Strada Brailei nr. 171A',
      clinicName: 'Unident Galati',
      imagePath: './assets/images/clinics/clinica_buzau_50.jpg',
      location: 'Unident Clinica Dentara Premium, Galati '),
  Clinic(
      nume: 'Bulevardul Unirii nr. P7',
      clinicName: 'Unident Buzau',
      imagePath: './assets/images/clinics/clinica_galati_50.jpg',
      location: 'Unident Clinica Dentara Premium, Buzau'),
  Clinic(
      nume: 'Strada Ștefan Baciu nr. 2',
      clinicName: 'Unident Brasov',
      imagePath: './assets/images/clinics/clinica_brasov_50.jpg',
      location: 'Unident Clinica Dentara Premium, Brasov'),
];

class ClinicsScreen extends StatelessWidget {
  const ClinicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
            icon: const Icon(Icons.menu),
          ),
          title: const Text('Clinicile Unident', style: TextStyle(fontSize: 32)),
          backgroundColor: Colors.purple[900],
          centerTitle: true),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 50),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 35);
              },
              physics: const ScrollPhysics(),
              itemCount: clinics.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => {
                    MapsLauncher.launchQuery(clinics[index].location),
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.fromLTRB(60, 0, 60, 10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            clinics[index].imagePath,
                            height: 210,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          clinics[index].clinicName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22,
                          ),
                        ),
                        Text(clinics[index].nume!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }

  Future<void> openUrl(String url) async {
    final _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      // <--
      throw Exception('Could not launch $_url');
    }
  }
}
