import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:unident_app/solicita_programare_doctor.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Uint8List poza;
  final String nume;
  final String id;
  const DoctorDetailsScreen({super.key, required this.poza, required this.nume, required this.id});

  @override
  Widget build(BuildContext context) {
    var realHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
    var sizedboxHeight = realHeight * 0.025;
    var sizedboxDoctorRowHeight = realHeight * 0.5;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text('Doctor', style: TextStyle(fontSize: 20)),
          backgroundColor: const Color.fromARGB(255, 46, 31, 112),
          centerTitle: true),
      backgroundColor: const Color.fromARGB(255, 46, 31, 112),
      body: Column(
        children: [
          SizedBox(height: sizedboxHeight),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                      child: Image.memory(
                    poza,
                    height: 200,
                    width: 175,
                    fit: BoxFit.cover,
                  )),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Galati',
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis)),
                    SizedBox(height: 5),
                    Text(nume,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis)),
                    SizedBox(height: 5),
                    Row(children: [
                      Text('Endodontie microscopica',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    ]),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            height: MediaQuery.of(context).size.height - 2 * sizedboxHeight - sizedboxDoctorRowHeight + 56,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('Despre doctor',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)),
                        ]),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 100,
                          child: Text(
                              "Lorem voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est  upidatat non proident, sunt in culpa qui officia deserunt mollit anim id estlaborum.",
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black45)),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Text('Pacienti', style: TextStyle(color: Colors.black)),
                          const SizedBox(height: 5),
                          const Text('1.6K',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Text('Experienta', style: TextStyle(color: Colors.black)),
                          const SizedBox(height: 5),
                          const Text('5 ani',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Text('Review', style: TextStyle(color: Colors.black)),
                          const SizedBox(height: 5),
                          const Text('800',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromARGB(255, 108, 93, 176),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SolicitaProgramareDoctorScreen(
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
    );
  }
}
