import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 50),
        Center(
            child: Container(
          height: 400,
          width: 350,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 230, 227, 196),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
          child: Column(
            children: [
              Text(
                'PRIORITY ADVANCED',
                style: TextStyle(fontSize: 30),
              ),
              Divider(
                color: Colors.black,
              ),
              Text(
                'Indicatie: pentru pacienti adulti cu afectiuni complexe',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Image.asset(
                    './assets/images/bifa.png',
                    scale: 5,
                  ),
                  Text('  Tomografie maxilară cu evidențierea sinusurilor'),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    './assets/images/bifa.png',
                    scale: 5,
                  ),
                  SizedBox(width: 5),
                  Expanded(child: Text(' Tomografie mandibulară cu evidențierea canalului mandibular')),
                ],
              ),
            ],
          ),
        )),
      ],
    ));
  }
}
