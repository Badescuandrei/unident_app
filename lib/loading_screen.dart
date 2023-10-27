// TODO
// The main idea is the following: Loading the doctors everytime HomeScreen is initialized is not a good idea because it takes
// of time to process and the doctors dont really change, so we can load them once and then use them in the HomeScreen, and only
// the doctors populated using the getListaMediciFiltrati function which change and the user needs to see the changes as fast an often
// as possible, maybe even using a Stream in order to constantly update it every 10 seconds or so would be a better approach, but for now
// this is the closest to that without investing time to change the architecture
import 'package:flutter/material.dart';
import 'package:unident_app/home.dart';
import 'package:unident_app/utils/api_call_functions.dart';
import 'package:unident_app/utils/classes.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  @override
  void initState() {
    // (setPage);
    super.initState();
    loadData();
  }

  loadData() async {
    List<Medic>? meds = await apiCallFunctions.getListaMedici();
    // List<MedicSlotLiber>? medsFiltrati = await apiCallFunctions.getListaMediciSlotLiber();
    if (meds != null) {
      Shared.medici.addAll(meds);
    }
    navigateToHome(); // if (medsFiltrati != null) {
    //   Shared.mediciFiltrati.addAll(medsFiltrati);
    // }
  }

  navigateToHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Home();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            Color(0xFFC4A462),
            // Color(0xFFC53C5D),
            Color(0xFF22226C),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            Center(
              child: Image.asset(
                './assets/images/unident-alb.png',
                width: MediaQuery.of(context).size.width * 0.9,
                isAntiAlias: true,
              ),
            ),
            const SizedBox(height: 60),
            const Text(
              'Innovative treatment solutions for you',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
