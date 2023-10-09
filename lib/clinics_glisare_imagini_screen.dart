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
              itemCount: cliniciImagini.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => {
                    //MapsLauncher.launchQuery(clinics[index].location),
                    MapsLauncher.launchQuery(cliniciImagini[index].location),
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.fromLTRB(60, 0, 60, 10),
                    child:  Column(
                      children:[
                          CarouselSlider(
                            items: [
                              Column (
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      cliniciImagini[index].imagePath,
                                      height: 210,
                                      width: 250,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row (
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      Text(
                                        cliniciImagini[index].clinicName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row (
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      Text(cliniciImagini[index].nume!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),    
                                ],
                              ),
                              for(int x = 0; x < cliniciImagini[index].imagesList.length; x++)...[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    //cliniciImagini[index].imagesList[x],
                                    cliniciImagini[index].imagesList[x],
                                    //'./assets/images/clinics/int1tulcea.jpg',
                                    //'./assets/images/clinics/clinica_brasov_interior/int3_brasov.jpg',
                                    height: 210,
                                    width: 250,
                                    //fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ],
                            options: CarouselOptions(
                              height: 340.0,
                              enlargeCenterPage: true,
                              //autoPlay: true, //old
                              autoPlay: false,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                              //viewportFraction: 0.8,
                              viewportFraction: 1.0,
                            ),
                          ),
                        /*
                        const SizedBox(height: 25),  
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
                        */    
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


List<String> listaImaginiClinicaBrasov = [
  
  './assets/images/clinics/ext1brasov.jpg',
  './assets/images/clinics/ext2brasov.jpg',
  './assets/images/clinics/int1brasov.jpg',
  './assets/images/clinics/int2brasov.jpg',
  './assets/images/clinics/int3brasov.jpg',
  './assets/images/clinics/int4brasov.jpg',
  './assets/images/clinics/int5brasov.jpg',
  './assets/images/clinics/int6brasov.jpg',
  './assets/images/clinics/int7brasov.jpg',
  './assets/images/clinics/int8brasov.jpg',
  './assets/images/clinics/int9brasov.jpg',
  './assets/images/clinics/int10brasov.jpg',
  './assets/images/clinics/int11brasov.jpg',
  './assets/images/clinics/int12brasov.jpg',
  './assets/images/clinics/int13brasov.jpg',
  './assets/images/clinics/int14brasov.jpg',
  './assets/images/clinics/int15brasov.jpg',
  './assets/images/clinics/int16brasov.jpg',

];

List<String> listaImaginiClinicaBuzau = [
  
  './assets/images/clinics/ext1buzau.jpg',
  './assets/images/clinics/ext2buzau.jpg',
  './assets/images/clinics/int1buzau.jpg',
  './assets/images/clinics/int2buzau.jpg',
  './assets/images/clinics/int3buzau.jpg',
  './assets/images/clinics/int4buzau.jpg',
  './assets/images/clinics/int5buzau.jpg',
  './assets/images/clinics/int6buzau.jpg',

];


List<String> listaImaginiClinicaGalati = [

  './assets/images/clinics/ext1galati.jpg',
  './assets/images/clinics/ext2galati.jpg',
  './assets/images/clinics/int1galati.jpg',
  './assets/images/clinics/int2galati.jpg',
  './assets/images/clinics/int3galati.jpg',
  './assets/images/clinics/int4galati.jpg',
  './assets/images/clinics/int5galati.jpg',
  './assets/images/clinics/int6galati.jpg',
  './assets/images/clinics/int7galati.jpg',
  './assets/images/clinics/int8galati.jpg',
  './assets/images/clinics/int9galati.jpg',
  './assets/images/clinics/int10galati.jpg',
  './assets/images/clinics/int11galati.jpg',

];


List<String> listaImaginiClinicaTulcea = [

  './assets/images/clinics/ext1tulcea.jpg',
  './assets/images/clinics/ext2tulcea.jpg',
  './assets/images/clinics/int1tulcea.jpg',
  './assets/images/clinics/int2tulcea.jpg',
  './assets/images/clinics/int3tulcea.jpg',
  './assets/images/clinics/int4tulcea.jpg',
  './assets/images/clinics/int5tulcea.jpg',
  './assets/images/clinics/int6tulcea.jpg',
  './assets/images/clinics/int7tulcea.jpg',
  './assets/images/clinics/int8tulcea.jpg',
  './assets/images/clinics/int9tulcea.jpg',
  './assets/images/clinics/int10tulcea.jpg',
  './assets/images/clinics/int11tulcea.jpg',

];