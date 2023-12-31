import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:unident_app/solicita_programare_doctor.dart';
import 'package:unident_app/utils/classes.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final String numeDoctor;
  final String judet;
  final DetaliiDoctor detaliiDoctor;
  final String miniCV;
  final List<String> jobs;
  final Uint8List poza;
  final String nume;
  final String id;
  const DoctorDetailsScreen(
      {super.key,
      required this.judet,
      required this.detaliiDoctor,
      required this.poza,
      required this.nume,
      required this.id,
      required this.jobs,
      required this.miniCV,
      required this.numeDoctor});

  @override
  Widget build(BuildContext context) {
    var realHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        kToolbarHeight;
    var sizedboxHeight = realHeight * 0.025;
    // var sizedboxDoctorRowHeight = realHeight * 0.5;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(numeDoctor, style: const TextStyle(fontSize: 20)),
          backgroundColor: const Color.fromRGBO(57, 52, 118, 1),
          centerTitle: true),
      backgroundColor: const Color.fromRGBO(57, 52, 118, 1),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: sizedboxHeight),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(child: Image.memory(poza, height: 190, width: 175, fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(judet,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis)),
                          const SizedBox(height: 5),
                          Text(nume,
                              maxLines: 3,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis)),
                          const SizedBox(height: 15),
                          for (var job in jobs)
                            Text(job.trim(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text('Despre doctor',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)),
                          ]),
                          SizedBox(height: sizedboxHeight / 2),
                          SizedBox(
                            height: 110,
                            child: miniCV.isEmpty
                                ? Text(
                                    "Lorem voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est  upidatat non proident, sunt in culpa qui officia deserunt mollit anim id estlaborum.",
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black45))
                                : Text(miniCV,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black45)),
                          ),
                          SizedBox(height: sizedboxHeight),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.25,
                      //   padding: EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                      //   child: Column(
                      //     children: [
                      //       const Text('Pacienti', style: TextStyle(color: Colors.black)),
                      //       const SizedBox(height: 5),
                      //       Text(detaliiDoctor.nrPacienti,
                      //           style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))
                      //     ],
                      //   ),
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            const Text('Experienta', style: TextStyle(color: Colors.black)),
                            const SizedBox(height: 5),
                            Text(detaliiDoctor.experienta,
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            const Text('Reviews', style: TextStyle(color: Colors.black)),
                            const SizedBox(height: 5),
                            Text(detaliiDoctor.nrReviewuri,
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromRGBO(57, 52, 118, 1),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SolicitaProgramareDoctorScreen(
                                        judet: judet,
                                        nume: nume,
                                        poza: poza,
                                        id: id,
                                      )));
                        },
                        child: const Text('VREAU O PROGRAMARE', style: TextStyle(color: Colors.white, fontSize: 14)),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
