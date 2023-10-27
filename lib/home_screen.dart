import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unident_app/doctor_details_screen.dart';
import 'package:unident_app/home.dart';
import 'package:unident_app/utils/api_call_functions.dart';
import 'package:unident_app/utils/classes.dart';
import 'package:unident_app/utils/functions.dart';

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isClicked = false;
  int selectedIndex = -1;
  bool isLoading = false;
  loadData() async {
    // List<Medic>? meds = await apiCallFunctions.getListaMedici();
    List<MedicSlotLiber>? medsFiltrati = await apiCallFunctions.getListaMediciSlotLiber();
    // Shared.medici.clear();
    Shared.mediciFiltrati.clear();
    // if (meds != null) {
    //   Shared.medici.addAll(meds);
    // }
    if (medsFiltrati != null) {
      Shared.mediciFiltrati.addAll(medsFiltrati);
    }
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
  }

  void loadData2() async {
    List<MembruFamilie> f = await apiCallFunctions.getListaFamilie();
    Shared.familie.addAll(f);
    print('Lista copii length este ${f.length}');
  }

  bool isClickedFunc(index) {
    isClicked = selectedIndex == index ? true : false;
    return isClicked;
  }

  @override
  void initState() {
    super.initState();
    loadData2();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // bottomNavigationBar: SalomonBottomBar(
        //   selectedItemColor: const Color.fromARGB(255, 13, 19, 130),
        //   currentIndex: _currentIndex,
        //   onTap: (i) => setState(() => _currentIndex = i),
        //   items: [
        //     /// Home
        //     SalomonBottomBarItem(
        //       icon: const ImageIcon(AssetImage('./assets/images/navbar/icons8-home-55.png')),
        //       title: const Text("Acasa"),
        //     ),

        //     /// Likes
        //     SalomonBottomBarItem(
        //       icon: const ImageIcon(AssetImage('./assets/images/navbar/calendar.png')),
        //       title: const Text("Programari"),
        //     ),

        //     /// Search
        //     SalomonBottomBarItem(
        //       icon: const ImageIcon(AssetImage('./assets/images/navbar/dinte.png')),
        //       title: const Text("Tratamente"),
        //     ),

        //     /// Profile
        //     SalomonBottomBarItem(
        //       icon: const ImageIcon(AssetImage('./assets/images/navbar/pagina perosnala.png')),
        //       title: const Text("Profil"),
        //     ),
        //   ],
        // ),
        backgroundColor: const Color.fromARGB(255, 240, 237, 237),
        body: newMethod(),
      ),
    );
  }

  SafeArea newMethod() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const DrawerWidget(),
                  const Text('Acasă', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Image.asset('./assets/images/logo sus dreapta.png', width: 40, height: 40)
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              child: Image.asset('./assets/images/moneyyy.png'),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child:
                  Row(children: [Text('Echipa noastră', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))]),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 250,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 20);
                    },
                    itemCount: Shared.medici.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          apiCallFunctions.getDetaliiDoctor(pIdMedic: Shared.medici[index].id).then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorDetailsScreen(
                                          numeDoctor: Shared.medici[index].nume,
                                          detaliiDoctor: value!,
                                          judet: Shared.medici[index].judet,
                                          miniCV: Shared.medici[index].miniCv,
                                          jobs: Shared.medici[index].profesii,
                                          id: Shared.medici[index].id,
                                          nume: Shared.medici[index].nume,
                                          poza: Shared.medici[index].poza,
                                        )));
                          });
                        },
                        child: homeScreen_echipaNoastraDoctorWidget(
                          poza: Shared.medici[index].poza,
                          name: Shared.medici[index].nume,
                          jobs: Shared.medici[index].profesii,
                        ),
                      );
                    },
                  )),
            ),
            const SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Container(
            //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            //     height: 100,
            //     child: ListView.separated(
            //       physics: const ScrollPhysics(),
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) {
            //         return GestureDetector(
            //           onTap: () {
            //             setState(() {
            //               selectedIndex = index;
            //               // isClickedFunc(index);
            //             });
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: index == selectedIndex ? const Color(0xFFC3A16E) : Colors.white,
            //             ),
            //             height: 100,
            //             width: 100,
            //             child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //               Image.asset(
            //                 './assets/images/homescreen/doctors.png',
            //                 color: index == selectedIndex ? Colors.white : const Color.fromARGB(255, 10, 10, 135),
            //               ),
            //               const SizedBox(
            //                 height: 10,
            //               ),
            //               Text(
            //                 'Toti medicii',
            //                 style: TextStyle(
            //                   fontSize: 14,
            //                   color: index == selectedIndex ? Colors.white : Colors.black,
            //                 ),
            //               ),
            //             ]),
            //           ),
            //         );
            //       },
            //       separatorBuilder: (context, index) {
            //         return const SizedBox(width: 15);
            //       },
            //       itemCount: 4,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(children: [
                Text(
                  'Medici disponibili',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ]),
            ),
            const SizedBox(height: 15),
            isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 140,
                      child: ListView.separated(
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                apiCallFunctions
                                    .getDetaliiDoctor(pIdMedic: Shared.mediciFiltrati[index].id)
                                    .then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DoctorDetailsScreen(
                                                numeDoctor: Shared.mediciFiltrati[index].nume,
                                                detaliiDoctor: value!,
                                                judet: Shared.mediciFiltrati[index].judet,
                                                miniCV: Shared.mediciFiltrati[index].miniCv,
                                                jobs: Shared.mediciFiltrati[index].profesii,
                                                id: Shared.mediciFiltrati[index].id,
                                                nume: Shared.mediciFiltrati[index].nume,
                                                poza: Shared.mediciFiltrati[index].poza,
                                              )));
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 70, 64, 138),
                                ),
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: Image.memory(errorBuilder: (context, error, stackTrace) {
                                              return Image.asset('./assets/images/defaultProfilePictureRectangular.png',
                                                  height: 120, width: 110, fit: BoxFit.cover);
                                            }, Shared.mediciFiltrati[index].poza,
                                                height: 120, width: 110, fit: BoxFit.cover),
                                          ),
                                        ],
                                      ),
                                      const Column(
                                        children: [SizedBox(width: 20)],
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              // TODO adauga sediu
                                              Shared.mediciFiltrati[index].judet,
                                              // Shared.mediciFiltrati[index].listaSedii[0],
                                              style: TextStyle(
                                                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 25),
                                            Flexible(
                                              child: Text(
                                                softWrap: true,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                // TODO adauga nume
                                                Shared.mediciFiltrati[index].nume == ""
                                                    ? "Locatie indisponibila"
                                                    : Shared.mediciFiltrati[index].nume,
                                                // "Maria Magdalena Mgdalanovici ",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              // TODO Adauga data aici, de luat in considerare ca este posibil sa nu existe
                                              DateFormat('EEEE, d.M.yyyy', 'ro')
                                                  .format(Shared.mediciFiltrati[index].dataPrimulSlotLiber)
                                                  .capitalizeFirst(),
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800,
                                                color: Color.fromRGBO(195, 161, 98, 1),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ]),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 15);
                          },
                          itemCount: Shared.mediciFiltrati.length),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 140,
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 20,
                            );
                          },
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return getShimmerLoading(context);
                          },
                          itemCount: 2,
                          shrinkWrap: true),
                    ),
                    // child: Row(children: [
                    //   getShimmerLoading(context),
                    //   SizedBox(width: 20),
                    //   getShimmerLoading(context),
                    // ]),
                  ),
          ],
        ),
      ),
    );
  }
}

Shimmer getShimmerLoading(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 125,
            width: 110,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                Container(width: double.infinity, height: 13.0, color: Colors.white),
                const SizedBox(height: 20),
                Container(width: double.infinity, height: 10.0, color: Colors.white),
                const SizedBox(height: 10),
                Container(width: double.infinity, height: 10.0, color: Colors.white),
                const SizedBox(height: 12),
                Container(width: double.infinity, height: 8.0, color: Colors.white),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

class homeScreen_echipaNoastraDoctorWidget extends StatelessWidget {
  final String name;
  final Uint8List? poza;
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
            child: poza == null
                ? Image.asset(
                    './assets/images/defaultProfilePicture.png',
                    height: 120,
                    width: 110,
                    fit: BoxFit.cover,
                  )
                : Image.memory(errorBuilder: (context, error, stackTrace) {
                    return Image.asset('./assets/images/defaultProfilePictureRectangular.png',
                        height: 120, width: 110, fit: BoxFit.cover);
                  }, poza!, height: 120, width: 110, fit: BoxFit.cover),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
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

// class DoctorItem extends StatelessWidget {
//   final String name;
//   final String job;
//   final String imagePath;
//   const DoctorItem({
//     super.key,
//     required this.name,
//     required this.job,
//     required this.imagePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.white,
//         ),
//         margin: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.all(10),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.asset(
//                   imagePath,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Text(name),
//             Text(job),
//           ],
//         ));
//   }
// }
