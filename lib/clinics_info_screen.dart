import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'classes.dart';

// Uri url = Uri.parse('http://idava.ro/Obiecte/sms_gateway.apk');
String url = 'http://idava.ro/Obiecte/sms_gateway.apk';

// class PictureSelection {
//  List<int> selectedPictures = [0, 0, 0, 0];
// }

List<ClinicWithImages> cliniciImagini = [
  ClinicWithImages(
    clinicName: 'Unident Tulcea',
    nume: 'Strada Toamnei nr. 7A',
    imagePath: './assets/images/clinics/clinica_tulcea_50.jpg',
    location: 'Unident Clinica Dentara Premium, Tulcea',
    imagesList: listaImaginiClinicaTulcea,
  ),
  ClinicWithImages(
    clinicName: 'Unident Galați',
    nume: 'Strada Brăilei nr. 171A',
    imagePath: './assets/images/clinics/clinica_galati_50.jpg',
    location: 'Unident Clinica Dentara Premium, Galati ',
    imagesList: listaImaginiClinicaGalati,
  ),
  ClinicWithImages(
    clinicName: 'Unident Buzau',
    nume: 'Bulevardul Unirii nr. P7',
    imagePath: './assets/images/clinics/clinica_buzau_50.jpg',
    location: 'Unident Clinica Dentara Premium, Buzau',
    imagesList: listaImaginiClinicaBuzau,
  ),
  ClinicWithImages(
    clinicName: 'Unident Brașov',
    nume: 'Strada Ștefan Baciu nr. 2',
    imagePath: './assets/images/clinics/clinica_brasov_50.jpg',
    location: 'Unident Clinica Dentara Premium, Brasov',
    imagesList: listaImaginiClinicaBrasov,
  ),
];

class ClinicsGlisareImaginiScreen extends StatefulWidget {
  const ClinicsGlisareImaginiScreen({super.key});

  @override
  State<ClinicsGlisareImaginiScreen> createState() => _ClinicsGlisareImaginiScreenState();
}

class _ClinicsGlisareImaginiScreenState extends State<ClinicsGlisareImaginiScreen> {
  // PictureSelection pictureSelection = PictureSelection();
  int currentIndex1 = 0;
  int currentIndex2 = 0;
  int currentIndex3 = 0;
  int currentIndex4 = 0;
  // List<int> listOfIndexes = [0, 0, 0, 0];
  // Map<int, String> mapOfClinics = {
  //   0: 'Unident Tulcea',
  //   1: 'Unident Galati',
  //   2: 'Unident Buzau',
  //   3: 'Unident Brasov',
  // };
  // int currentIndex = 0;
  // List<int> listofIndexes = [];
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
              // ListView.separated(
              //   shrinkWrap: true,
              //   separatorBuilder: (context, index) {
              //     return const SizedBox(height: 35);
              //   },
              //   physics: const ScrollPhysics(),
              //   itemCount: cliniciImagini.length,
              //   itemBuilder: (context, index) {
              //     return Container(
              //       padding: const EdgeInsets.all(20),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.white,
              //       ),
              //       margin: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              //       child: Column(
              //         children: [
              //           CarouselSlider(
              //             items: [
              //               for (int x = 0; x < cliniciImagini[index].imagesList.length; x++) ...[
              //                 Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     ClipRRect(
              //                       borderRadius: BorderRadius.circular(10),
              //                       child: Image.asset(
              //                         cliniciImagini[index].imagesList[x],
              //                         height: 210,
              //                         width: 250,
              //                         fit: BoxFit.cover,
              //                       ),
              //                     ),
              //                     const SizedBox(height: 10),
              //                   ],
              //                 ),
              //               ],
              //             ],
              //             // Problema e aici
              //             options: CarouselOptions(
              //               onPageChanged: (index, reason) {
              //                 setState(() {
              //                   listOfIndexes[index] = index;
              //                 });
              //               },
              //               height: 255.0,
              //               enlargeCenterPage: true,
              //               //autoPlay: true, //old
              //               autoPlay: false,
              //               aspectRatio: 16 / 9,
              //               autoPlayCurve: Curves.fastOutSlowIn,
              //               enableInfiniteScroll: true,
              //               autoPlayAnimationDuration: const Duration(milliseconds: 800),
              //               //viewportFraction: 0.8,
              //               viewportFraction: 1.0,
              //             ),
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 cliniciImagini[index].clinicName,
              //                 style: const TextStyle(
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 22,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 cliniciImagini[index].nume!,
              //                 style: const TextStyle(
              //                   fontWeight: FontWeight.w300,
              //                   fontSize: 20,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 15),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               for (int i = 0; i < cliniciImagini[index].imagesList.length; i++)
              //                 Container(
              //                   height: 13,
              //                   width: 13,
              //                   margin: EdgeInsets.all(5),
              //                   decoration: BoxDecoration(
              //                       color: listOfIndexes[index] == i ? Color.fromRGBO(57, 52, 118, 1) : Colors.white,
              //                       shape: BoxShape.circle,
              //                       boxShadow: [
              //                         BoxShadow(
              //                             color: Colors.grey, spreadRadius: 1, blurRadius: 3, offset: Offset(2, 2))
              //                       ]),
              //                 )
              //             ],
              //           )
              //         ],
              //       ),
              //     );
              //   },
              // ),
              carouselTulcea(),
              SizedBox(height: 15),
              carouselGalati(),
              SizedBox(height: 15),
              carouselBuzau(),
              SizedBox(height: 15),
              carouselBrasov(),
              SizedBox(height: 15),
            ],
          ),
        )),
      ),
    );
  }

  Container carouselTulcea() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 10),
      child: Column(
        children: [
          CarouselSlider(
            items: [
              for (int x = 0; x < cliniciImagini[0].imagesList.length; x++) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            cliniciImagini[0].imagesList[x],
                            height: 210,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < cliniciImagini[0].imagesList.length; i++)
                                Container(
                                  height: 13,
                                  width: 13,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: currentIndex1 == i ? Color.fromRGBO(57, 52, 118, 1) : Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey, spreadRadius: 1, blurRadius: 3, offset: Offset(2, 2))
                                      ]),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ],
            // Problema e aici
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex1 = index;
                });
              },
              height: 255.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cliniciImagini[0].clinicName,
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
                cliniciImagini[0].nume!,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Container carouselGalati() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 10),
      child: Column(
        children: [
          CarouselSlider(
            items: [
              for (int x = 0; x < cliniciImagini[1].imagesList.length; x++) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            cliniciImagini[1].imagesList[x],
                            height: 210,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < cliniciImagini[1].imagesList.length; i++)
                                Container(
                                  height: 13,
                                  width: 13,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: currentIndex2 == i ? Color.fromRGBO(57, 52, 118, 1) : Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey, spreadRadius: 1, blurRadius: 3, offset: Offset(2, 2))
                                      ]),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ],
            // Problema e aici
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex2 = index;
                });
              },
              height: 255.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cliniciImagini[1].clinicName,
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
                cliniciImagini[1].nume!,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Container carouselBuzau() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 10),
      child: Column(
        children: [
          CarouselSlider(
            items: [
              for (int x = 0; x < cliniciImagini[2].imagesList.length; x++) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            cliniciImagini[2].imagesList[x],
                            height: 210,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < cliniciImagini[2].imagesList.length; i++)
                                Container(
                                  height: 13,
                                  width: 13,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: currentIndex3 == i ? Color.fromRGBO(57, 52, 118, 1) : Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey, spreadRadius: 1, blurRadius: 3, offset: Offset(2, 2))
                                      ]),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ],
            // Problema e aici
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex3 = index;
                });
              },
              height: 255.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cliniciImagini[2].clinicName,
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
                cliniciImagini[2].nume!,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Container carouselBrasov() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 10),
      child: Column(
        children: [
          CarouselSlider(
            items: [
              for (int x = 0; x < cliniciImagini[3].imagesList.length; x++) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            cliniciImagini[3].imagesList[x],
                            height: 210,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                            bottom: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < cliniciImagini[3].imagesList.length; i++)
                                  Container(
                                    height: 13,
                                    width: 13,
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: currentIndex4 == i ? Color.fromRGBO(57, 52, 118, 1) : Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey, spreadRadius: 1, blurRadius: 3, offset: Offset(2, 2))
                                        ]),
                                  )
                              ],
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ],
            // Problema e aici
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex4 = index;
                });
              },
              height: 255.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cliniciImagini[3].clinicName,
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
                cliniciImagini[3].nume!,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
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
  './assets/images/clinics/int5brasov_mica.jpg',
  './assets/images/clinics/int6brasov_mica.jpg',
  './assets/images/clinics/int8brasov_mica.jpg',
  './assets/images/clinics/int13brasov_mica.jpg',
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
  './assets/images/clinics/int6tulcea_mica.jpg',
  './assets/images/clinics/int8tulcea_mica.jpg',
  './assets/images/clinics/int9tulcea_mica.jpg',
  './assets/images/clinics/int10tulcea_mica.jpg',
  './assets/images/clinics/int11tulcea_mica.jpg',
];
