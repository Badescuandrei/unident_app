// import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unident_app/apinio.dart';
import 'package:unident_app/utils/api_call.dart';
import 'package:unident_app/utils/api_call_functions.dart';
import 'package:unident_app/utils/classes.dart';
import 'package:unident_app/utils/functions.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;

class TratamentScreen extends StatefulWidget {
  const TratamentScreen({super.key});

  @override
  State<TratamentScreen> createState() => _TratamentScreenState();
}

class _TratamentScreenState extends State<TratamentScreen> {
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  Future<Programari?>? programari;
  List<Programare> viitoare = <Programare>[];
  List<Programare> trecute = <Programare>[];
  ApiCall apiCall = ApiCall();
  final Color kDarkBlueColor = const Color(0xFF053149);
  final BoxShadow kDefaultBoxshadow = const BoxShadow(
    color: Color(0xFFDFDFDF),
    spreadRadius: 1,
    blurRadius: 10,
    offset: Offset(2, 2),
  );
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    programari = getListaProgramari();
    print(trecute.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
            icon: const Icon(Icons.menu),
          ),
          title: const Text('Planul de tratament', style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.purple[900],
          centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Center(
                child: toggleTab(context),
              ),
              const SizedBox(height: 25),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return detaliiProgramareWidget(
                    programare: viitoare[index],
                  );
                },
                itemCount: viitoare.length,
              ),
              // currentIndex == 0
              //     ? butoaneDeApasat(context)
              //     : currentIndex == 1
              //         ? detaliiProgramareWidget()
              //         : Image.asset(
              //             './assets/images/unident-alb.png',
              //             height: 35,
              //             color: Colors.red,
              //           ),
            ],
          ),
        ),
      ),
    );
  }

  AppinioAnimatedToggleTab toggleTab(BuildContext context) {
    return AppinioAnimatedToggleTab(
      duration: const Duration(milliseconds: 150),
      offset: 0,
      callback: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      tabTexts: const [
        'Programarile dvs.',
        'Programarile copilului',
      ],
      height: 45,
      width: MediaQuery.of(context).size.width * 0.75,
      boxDecoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          kDefaultBoxshadow,
        ],
      ),
      animatedBoxDecoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 63, 119, 153).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      activeStyle: TextStyle(
        fontSize: 12,
        color: kDarkBlueColor,
        fontWeight: FontWeight.w600,
      ),
      inactiveStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Container butoaneDeApasat(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 57, 14, 143),
      ),
      height: 300,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Align(
        alignment: Alignment.center,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 50,
                child: const Center(
                  child: Text('Descarca planul de tratament', style: TextStyle(color: Colors.black, fontSize: 22)),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
            itemCount: 4),
      ),
    );
  }

  Future<Programari?> getListaProgramari() async {
    viitoare.clear();
    trecute.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String idUser = prefs.getString(pref_keys.userIdInregistrare)!;
    final Map<String, String> param = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pIdLimba': '0',
    };

    String? res = await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaProgramarileLui', pParametrii: param);

    List<Programare> programariViitoare = <Programare>[];
    List<Programare> programariTrecute = <Programare>[];

    if (res == null) {
      // errorInfo = l.universalEroare;
      // infoWidget = InfoWidget.error;
      print("Eroare null");
      return null;
    }
    if (res.startsWith('13\$#\$')) {
      print("success");
      print(res);
    }
    if (res.startsWith('66\$#\$')) {
      print("dategresite");
      print(res);
    }

    if (res.startsWith('132\$#\$')) {
      print("register error");
      print(res);
    }

    if (res.contains('%\$%')) {
      print(res);
      List<String> list = res.split('%\$%');
      List<String> viitoare = list[1].split('*\$*');
      List<String> trecute = list[0].split('*\$*');
      viitoare.removeWhere((element) => element.isEmpty);
      trecute.removeWhere((element) => element.isEmpty);

      for (var element in viitoare) {
        List<String> l = element.split('\$#\$');

        DateTime date = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[0].substring(8, 10)),
          int.parse(l[0].substring(10, 12)),
        );
        DateTime dateSf = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[1].substring(0, 2)),
          int.parse(l[1].substring(3, 5)),
        );

//TODO verif
        Programare p = Programare(
            nume: '',
            prenume: '',
            idPacient: '',
            medic: l[2],
            categorie: l[3],
            status: l[4],
            anulata: l[5],
            inceput: date,
            sfarsit: dateSf,
            id: l[6]);
        programariViitoare.add(p);
      }

      for (var element in trecute) {
        List<String> l = element.split('\$#\$');
//data inceput, ora final, identitate medic, categorie, status programare, 0/1 (este sau nu anulata)
        DateTime date = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[0].substring(8, 10)),
          int.parse(l[0].substring(10, 12)),
        );
        DateTime dateSf = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[1].substring(0, 2)),
          int.parse(l[1].substring(3, 5)),
        );
//TODO verif
        Programare p = Programare(
            nume: '',
            prenume: '',
            idPacient: '',
            id: l[6],
            medic: l[2],
            categorie: l[3],
            status: l[4],
            anulata: l[5],
            inceput: date,
            sfarsit: dateSf);
        programariTrecute.add(p);
      }
    }
    programariTrecute.sort((a, b) => b.inceput.compareTo(a.inceput));
    programariViitoare.sort((a, b) => a.inceput.compareTo(b.inceput));
    Programari? pP = Programari(trecute: programariTrecute, viitoare: programariViitoare);
    print(" ASta e ${programariViitoare.length}");
    setState(() {
      viitoare = programariViitoare;
      trecute = programariTrecute;
    });
    // print(" ASta e ${trecute.length}");
    return pP;
  }
}

class detaliiProgramareWidget extends StatelessWidget {
  final Programare? programare;
  const detaliiProgramareWidget({
    super.key,
    this.programare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black38),
          color: Colors.white),
      child: Column(children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data',
                    style: TextStyle(color: Colors.black45),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat('d.M.yyyy').format(programare!.inceput).capitalizeFirst(),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ora',
                    style: TextStyle(color: Colors.black45),
                  ),
                  const SizedBox(height: 5),
                  Text(DateFormat.Hm().format(programare!.inceput),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Doctor',
                    style: TextStyle(color: Colors.black45),
                  ),
                  const SizedBox(height: 5),
                  Text(programare!.medic, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        const Divider(thickness: 1, color: Colors.black26),
        const SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Manopera',
                          style: TextStyle(color: Colors.black45),
                        ),
                        SizedBox(height: 5),
                        Text(programare!.categorie, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'UNIDENT',
                          style: TextStyle(color: Colors.black45),
                        ),
                        SizedBox(height: 5),
                        Text('Tulcea', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: programare!.status == "Programat"
                      ? Colors.blue
                      : programare!.status == "Confirmat"
                          ? Colors.green
                          : programare!.status == "Finalizat" || programare!.status == "Terminat"
                              ? Colors.yellow
                              : programare!.status.startsWith("Anulat")
                                  ? Colors.red
                                  : Colors.grey),
              child: Center(
                child: Text(
                    programare!.status == "Programat"
                        ? "PROGRAMAT"
                        : programare!.status == "Confirmat"
                            ? "CONFIRMAT"
                            : programare!.status == "Finalizat" || programare!.status == "Terminat"
                                ? "FINALIZAT"
                                : programare!.status.startsWith("Anulat")
                                    ? "ANULAT"
                                    : "ANULAT",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        )
      ]),
    );
  }
}
