import 'dart:ffi';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:unident_app/doctor_details_screen.dart';
import 'package:unident_app/utils/api_call_functions.dart';
import '../utils/classes.dart';

// List<ourMedics_doctorItem> doctorsBrasov = const [
//   ourMedics_doctorItem(
//       name: 'Dr. Amin Zahra',
//       job: 'Specialist anestezie si terapie intensiva',
//       imagePath: './assets/images/doctors/brasov/DR AMIN ZAHRA SPECIALIST ANESTEZIE SI TERAPIE INTENSIVA.jpg'),
//   ourMedics_doctorItem(
//       name: 'Dr. Mesaros Alexandra',
//       job: 'Protetica digitala',
//       imagePath: './assets/images/doctors/brasov/DR_MESAROS_ALECSANDRA_BRASOV.jpg'),
//   ourMedics_doctorItem(
//       name: 'Dr. Raluca Iconaru',
//       job: 'Protetica digitala',
//       imagePath: './assets/images/doctors/brasov/DR_RALUCA_ICONARU_BV.jpg'),
//   ourMedics_doctorItem(
//       name: 'Dr. Petronela Luca',
//       job: 'Protetica digitala',
//       imagePath: './assets/images/doctors/brasov/Dr-Petronela-Luca.jpg'),
// ];

// List<ourMedics_doctorItem> doctorsGalati = const [
//   ourMedics_doctorItem(
//       name: 'Dr. Andreea Paraschiv',
//       job: 'Specialist anestezie si terapie intensiva',
//       imagePath: './assets/images/doctors/galati/ANDREEA-PARASCHIV.jpg'),
//   ourMedics_doctorItem(
//       name: 'Dr. Jugravu', job: 'Protetica digitala', imagePath: './assets/images/doctors/galati/DR_JUGRAVU.jpg'),
//   ourMedics_doctorItem(
//       name: 'Dr. Minzat Ion',
//       job: 'Protetica digitala',
//       imagePath: './assets/images/doctors/galati/DR MINZAT ION STOMATOLOGIE GENERALA ENDO MICROSCOPIC GALATI (1).jpg'),
//   ourMedics_doctorItem(
//       name: 'Dr. Victor Copacinschi',
//       job: 'Protetica digitala',
//       imagePath: './assets/images/doctors/galati/Dr._Victor_Copacinschi.jpg'),
// ];
ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class OurMedicsScreen extends StatefulWidget {
  const OurMedicsScreen({super.key});

  @override
  State<OurMedicsScreen> createState() => _OurMedicsScreenState();
}

class _OurMedicsScreenState extends State<OurMedicsScreen> {
  late Map<String, List<Medic>> groupedMedicsByCity;

  @override
  void initState() {
    // (setPage);
    super.initState();
    setState(() {
      groupedMedicsByCity = filterAndDestroy();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: const Icon(Icons.menu),
            ),
            title: const Text('Medicii nostri', style: TextStyle(fontSize: 32)),
            backgroundColor: const Color.fromRGBO(57, 52, 118, 1),
            centerTitle: true),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              // const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Container(
              //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              //       height: 250,
              //       child: ListView.separated(
              //         separatorBuilder: (context, index) {
              //           return const SizedBox(width: 20);
              //         },
              //         itemCount: 4,
              //         scrollDirection: Axis.horizontal,
              //         itemBuilder: (context, index) {
              //           return Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Colors.white,
              //             ),
              //             // margin: const EdgeInsets.all(10),
              //             padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
              //             height: 120,
              //             width: 150,
              //             child: ourMedics_doctorItem(
              //               imagePath: doctorsBrasov[index].imagePath,
              //               job: doctorsBrasov[index].job,
              //               name: doctorsBrasov[index].name,
              //             ),
              //           );
              //         },
              //       )),
              // ),
              for (var city in groupedMedicsByCity.keys)
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(city, style: TextStyle(fontSize: 20)),
                          Text("Toti medicii din ${city}", style: TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        height: 270,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 20);
                          },
                          itemCount: groupedMedicsByCity[city]!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                apiCallFunctions.getDetaliiDoctor(pIdMedic: Shared.medici[index].id).then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DoctorDetailsScreen(
                                                numeDoctor: groupedMedicsByCity[city]![index].nume,
                                                detaliiDoctor: value!,
                                                judet: groupedMedicsByCity[city]![index].judet,
                                                miniCV: groupedMedicsByCity[city]![index].miniCv,
                                                jobs: groupedMedicsByCity[city]![index].profesii,
                                                id: groupedMedicsByCity[city]![index].id,
                                                nume: groupedMedicsByCity[city]![index].nume,
                                                poza: groupedMedicsByCity[city]![index].poza,
                                              )));
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                // margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
                                height: 200,
                                width: 150,
                                child: homeScreen_echipaNoastraDoctorWidget(
                                  poza: groupedMedicsByCity[city]![index].poza,
                                  jobs: groupedMedicsByCity[city]![index].profesii,
                                  name: groupedMedicsByCity[city]![index].nume,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),

              // const SizedBox(height: 30),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("Galati", style: TextStyle(fontSize: 20)),
              //       Text("Toti medicii din Galati", style: TextStyle(fontSize: 20))
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Container(
              //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              //       height: 250,
              //       child: ListView.separated(
              //         separatorBuilder: (context, index) {
              //           return const SizedBox(width: 20);
              //         },
              //         itemCount: doctorsGalati.length,
              //         scrollDirection: Axis.horizontal,
              //         itemBuilder: (context, index) {
              //           return Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Colors.white,
              //             ),
              //             // margin: const EdgeInsets.all(10),
              //             padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
              //             width: 140,
              //             child: ourMedics_doctorItem(
              //               imagePath: doctorsGalati[index].imagePath,
              //               job: doctorsGalati[index].job,
              //               name: doctorsGalati[index].name,
              //             ),
              //           );
              //         },
              //       )),
              // ),
              // Container(
              //   height: 100,
              //   width: double.infinity,
              //   color: const Color.fromARGB(255, 93, 83, 172),
              //   child: const Center(
              //     child: Text(
              //       'Medicii nostri',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         fontSize: 30,
              //         color: Colors.white,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  filterAndDestroy() {
    // List<List<Medic>> asae = [];
    // List<String> locatii = [];
    // // Generare Lista cu locatiile posibile din sediu
    // for (int x = 0; x < Shared.medici.length; x++) {
    //   if (!locatii.contains(Shared.medici[x].judet)) {
    //     locatii.add(Shared.medici[x].judet);
    //   }
    // }
    var groupedMedics = groupBy(Shared.medici, (Medic medic) => medic.judet);
    // print(groupedMedics);
    return groupedMedics;
    // Generare de lista care contine listele cu doctori per fiecare sediu
    // for () {};
  }
}

class homeScreen_echipaNoastraDoctorWidget extends StatelessWidget {
  final String name;
  final Uint8List poza;
  // TODO adauga job title
  final List<String> jobs;

  homeScreen_echipaNoastraDoctorWidget({
    super.key,
    required this.jobs,
    required this.poza,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      // margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
      width: 130,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.memory(
              poza,
              height: 120,
              width: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 5),
          for (var job in jobs)
            Text(
              job,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            )
        ],
      ),
    );
  }
}

class ourMedics_doctorItem extends StatelessWidget {
  final Uint8List imagePath;
  final String name;
  final String job;
  const ourMedics_doctorItem({
    super.key,
    required this.imagePath,
    required this.name,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
              child: Image.memory(
            imagePath,
            height: 150,
            width: 115,
            fit: BoxFit.cover,
          )),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          job,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
