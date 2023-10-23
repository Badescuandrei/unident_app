import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'classes.dart';

// Uri url = Uri.parse('http://idava.ro/Obiecte/sms_gateway.apk');
String url = 'http://idava.ro/Obiecte/sms_gateway.apk';

List<ClinicWithImages> cliniciImagini = [
  ClinicWithImages(
    clinicName: 'Unident Tulcea',
    imagePath: './assets/images/clinics/clinica_tulcea_50.jpg',
    nume: 'Strada Toamnei nr. 7A',
    location: 'Unident Clinica Dentara Premium, Tulcea',
    imagesList: listaImaginiClinicaTulcea,
  ),
  ClinicWithImages(
    nume: 'Strada Brailei nr. 171A',
    clinicName: 'Unident Galati',
    imagePath: './assets/images/clinics/clinica_galati_50.jpg',
    location: 'Unident Clinica Dentara Premium, Galati ',
    imagesList: listaImaginiClinicaGalati,
  ),
  ClinicWithImages(
    nume: 'Bulevardul Unirii nr. P7',
    clinicName: 'Unident Buzau',
    imagePath: './assets/images/clinics/clinica_buzau_50.jpg',
    location: 'Unident Clinica Dentara Premium, Buzau',
    imagesList: listaImaginiClinicaBuzau,
  ),
  ClinicWithImages(
    nume: 'Strada Ștefan Baciu nr. 2',
    clinicName: 'Unident Brasov',
    imagePath: './assets/images/clinics/clinica_brasov_50.jpg',
    location: 'Unident Clinica Dentara Premium, Brasov',
    imagesList: listaImaginiClinicaBrasov,
  ),
];

class ClinicsGlisareImaginiScreen extends StatelessWidget {
  const ClinicsGlisareImaginiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: const Icon(Icons.menu),
            ),
            title: const Text('Clinicile Unident', style: TextStyle(fontSize: 32)),
            backgroundColor: Color.fromRGBO(57, 52, 118, 1),
            centerTitle: true),
        backgroundColor: Colors.grey[300],
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
                itemCount: cliniciImagini.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Icon(Icons.arrow_back_ios_new_rounded),
                            ),
                            Expanded(
                              child: CarouselSlider(
                                items: [
                                  for (int x = 0; x < cliniciImagini[index].imagesList.length; x++) ...[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            cliniciImagini[index].imagesList[x],
                                            height: 210,
                                            width: 250,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                ],
                                options: CarouselOptions(
                                  height: 255.0,
                                  enlargeCenterPage: true,
                                  //autoPlay: true, //old
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                  //viewportFraction: 0.8,
                                  viewportFraction: 1.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                              child: Icon(Icons.arrow_forward_ios_rounded),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cliniciImagini[index].clinicName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cliniciImagini[index].nume!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        )),
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

List<String> listaImaginiClinicaBrasov = [
  './assets/images/clinics/ext1brasov_mica.jpg',
  './assets/images/clinics/int1brasov_mica.jpg',
  './assets/images/clinics/int2brasov_mica.jpg',
  './assets/images/clinics/int3brasov_mica.jpg',
  './assets/images/clinics/int4brasov_mica.jpg',
  './assets/images/clinics/int5brasov_mica.jpg',
  './assets/images/clinics/int6brasov_mica.jpg',
  './assets/images/clinics/int7brasov_mica.jpg',
  './assets/images/clinics/int8brasov_mica.jpg',
  './assets/images/clinics/int9brasov_mica.jpg',
  './assets/images/clinics/int10brasov_mica.jpg',
  './assets/images/clinics/int11brasov_mica.jpg',
  './assets/images/clinics/int12brasov_mica.jpg',
  './assets/images/clinics/int13brasov_mica.jpg',
  './assets/images/clinics/int14brasov_mica.jpg',
  './assets/images/clinics/int15brasov_mica.jpg',
  './assets/images/clinics/int16brasov_mica.jpg',
];

List<String> listaImaginiClinicaBuzau = [
  './assets/images/clinics/ext2buzau_mica.jpg',
  './assets/images/clinics/int1buzau_mica.jpg',
  './assets/images/clinics/int2buzau_mica.jpg',
  './assets/images/clinics/int3buzau_mica.jpg',
  './assets/images/clinics/int4buzau_mica.jpg',
  './assets/images/clinics/int5buzau_mica.jpg',
  './assets/images/clinics/int6buzau_mica.jpg',
];

List<String> listaImaginiClinicaGalati = [
  './assets/images/clinics/ext1galati_mica.jpg',
  './assets/images/clinics/int1galati_mica.jpg',
  './assets/images/clinics/int2galati_mica.jpg',
  './assets/images/clinics/int3galati_mica.jpg',
  './assets/images/clinics/int4galati_mica.jpg',
  './assets/images/clinics/int5galati_mica.jpg',
  './assets/images/clinics/int6galati_mica.jpg',
  './assets/images/clinics/int7galati_mica.jpg',
  './assets/images/clinics/int8galati_mica.jpg',
  './assets/images/clinics/int9galati_mica.jpg',
  './assets/images/clinics/int10galati_mica.jpg',
  './assets/images/clinics/int11galati_mica.jpg',
];

List<String> listaImaginiClinicaTulcea = [
  './assets/images/clinics/ext1tulcea_mica.jpg',
  './assets/images/clinics/int1tulcea_mica.jpg',
  './assets/images/clinics/int2tulcea_mica.jpg',
  './assets/images/clinics/int3tulcea_mica.jpg',
  './assets/images/clinics/int4tulcea_mica.jpg',
  './assets/images/clinics/int5tulcea_mica.jpg',
  './assets/images/clinics/int6tulcea_mica.jpg',
  './assets/images/clinics/int7tulcea_mica.jpg',
  './assets/images/clinics/int8tulcea_mica.jpg',
  './assets/images/clinics/int9tulcea_mica.jpg',
  './assets/images/clinics/int10tulcea_mica.jpg',
  './assets/images/clinics/int11tulcea_mica.jpg',
];
