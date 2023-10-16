import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import './utils/classes.dart';

// Uri url = Uri.parse('http://idava.ro/Obiecte/sms_gateway.apk');
String url = 'http://idava.ro/Obiecte/sms_gateway.apk';
List<Clinic> clinics = [
  Clinic(
    clinicName: 'Unident Tulcea',
    imagePath: './assets/images/clinics/clinica_tulcea_50.jpg',
    nume: 'Strada Toamnei nr. 7A',
    location: 'Unident Clinica Dentara Premium, Tulcea',
    tel: "0744400705",
    mail: "receptie.tulcea@unident.ro",
  ),
  Clinic(
    nume: 'Strada Brailei nr. 171A',
    clinicName: 'Unident Galati',
    imagePath: './assets/images/clinics/clinica_buzau_50.jpg',
    location: 'Unident Clinica Dentara Premium, Galati ',
    tel: "0740705706",
    mail: "receptie.galati@unident.ro",
  ),
  Clinic(
    nume: 'Bulevardul Unirii nr. P6',
    clinicName: 'Unident Buzau',
    imagePath: './assets/images/clinics/clinica_galati_50.jpg',
    location: 'Unident Clinica Dentara Premium, Buzau',
    tel: "0745403403",
    mail: "receptie.buzău@unident.ro",
  ),
  Clinic(
    nume: 'Strada Ștefan Baciu nr. 2',
    clinicName: 'Unident Brasov',
    imagePath: './assets/images/clinics/clinica_brasov_50.jpg',
    location: 'Unident Clinica Dentara Premium, Brasov',
    tel: "0730006808",
    mail: "receptie.brasov@unident.ro",
  ),
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
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ListView.separated(
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
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        // margin: const EdgeInsets.fromLTRB(10, 0, 60, 10),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
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
                            const Divider(color: Colors.black26, thickness: 2, height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri(
                                      scheme: 'tel',
                                      path: clinics[index].tel,
                                    );
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      print("Cannot launch!");
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.call,
                                    color: Colors.green,
                                    size: 36,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      final Uri url = Uri(
                                        scheme: 'mailto',
                                        path: clinics[index].mail,
                                      );
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        print("Cannot launch!");
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.email_rounded,
                                      color: Colors.blue,
                                      size: 36,
                                    )),
                              ],
                            ),
                            // SizedBox(
                            //   height: 20,
                            //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                            //     Text('0752199299',
                            //         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20)),
                            //     Icon(Icons.call, color: Colors.green)
                            //   ]),
                            // ),
                            // SizedBox(
                            //   height: 20,
                            //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                            //     Text('receptie.tulcea@unident.ro',
                            //         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16)),
                            //     Icon(Icons.call, color: Colors.green)
                            //   ]),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
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
