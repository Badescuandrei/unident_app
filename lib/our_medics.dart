import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

List<ourMedics_doctorItem> doctorsBrasov = const [
  ourMedics_doctorItem(
      name: 'Dr. Amin Zahra',
      job: 'Specialist anestezie si terapie intensiva',
      imagePath: './assets/images/doctors/brasov/DR AMIN ZAHRA SPECIALIST ANESTEZIE SI TERAPIE INTENSIVA.jpg'),
  ourMedics_doctorItem(
      name: 'Dr. Mesaros Alexandra',
      job: 'Protetica digitala',
      imagePath: './assets/images/doctors/brasov/DR_MESAROS_ALECSANDRA_BRASOV.jpg'),
  ourMedics_doctorItem(
      name: 'Dr. Raluca Iconaru',
      job: 'Protetica digitala',
      imagePath: './assets/images/doctors/brasov/DR_RALUCA_ICONARU_BV.jpg'),
  ourMedics_doctorItem(
      name: 'Dr. Petronela Luca',
      job: 'Protetica digitala',
      imagePath: './assets/images/doctors/brasov/Dr-Petronela-Luca.jpg'),
];

List<ourMedics_doctorItem> doctorsGalati = const [
  ourMedics_doctorItem(
      name: 'Dr. Andreea Paraschiv',
      job: 'Specialist anestezie si terapie intensiva',
      imagePath: './assets/images/doctors/galati/ANDREEA-PARASCHIV.jpg'),
  ourMedics_doctorItem(
      name: 'Dr. Jugravu', job: 'Protetica digitala', imagePath: './assets/images/doctors/galati/DR_JUGRAVU.jpg'),
  ourMedics_doctorItem(
      name: 'Dr. Minzat Ion',
      job: 'Protetica digitala',
      imagePath: './assets/images/doctors/galati/DR MINZAT ION STOMATOLOGIE GENERALA ENDO MICROSCOPIC GALATI (1).jpg'),
  ourMedics_doctorItem(
      name: 'Dr. Victor Copacinschi',
      job: 'Protetica digitala',
      imagePath: './assets/images/doctors/galati/Dr._Victor_Copacinschi.jpg'),
];

class OurMedicsScreen extends StatelessWidget {
  const OurMedicsScreen({super.key});

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
          title: const Text('Medicii nostri', style: TextStyle(fontSize: 32)),
          backgroundColor: Colors.purple[900],
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Brasov", style: TextStyle(fontSize: 20)),
                  Text("Toti medicii din Brasov", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: 250,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 20);
                    },
                    itemCount: doctorsBrasov.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        // margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
                        height: 120,
                        width: 150,
                        child: ourMedics_doctorItem(
                          imagePath: doctorsBrasov[index].imagePath,
                          job: doctorsBrasov[index].job,
                          name: doctorsBrasov[index].name,
                        ),
                      );
                    },
                  )),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Galati", style: TextStyle(fontSize: 20)),
                  Text("Toti medicii din Galati", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: 250,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 20);
                    },
                    itemCount: doctorsGalati.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        // margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
                        width: 140,
                        child: ourMedics_doctorItem(
                          imagePath: doctorsGalati[index].imagePath,
                          job: doctorsGalati[index].job,
                          name: doctorsGalati[index].name,
                        ),
                      );
                    },
                  )),
            ),
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
    );
  }
}

class ourMedics_doctorItem extends StatelessWidget {
  final String imagePath;
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
              child: Image.asset(
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
