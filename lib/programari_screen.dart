// import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unident_app/apinio.dart';
import 'package:unident_app/feedback_screen.dart';
import 'package:unident_app/utils/api_call.dart';
import 'package:unident_app/utils/api_call_functions.dart';
import 'package:unident_app/utils/classes.dart';
import 'package:unident_app/utils/functions.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;

class ProgramariScreen extends StatefulWidget {
  const ProgramariScreen({super.key});

  @override
  State<ProgramariScreen> createState() => _ProgramariScreenState();
}

class _ProgramariScreenState extends State<ProgramariScreen> {
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  Future<Programari?>? programari;
  Future<Programari?>? programariCopil;
  List<Programare> viitoare = <Programare>[];
  List<Programare> trecute = <Programare>[];
  List<Programare> viitoareCopil = <Programare>[];
  List<Programare> trecuteCopil = <Programare>[];
  ApiCall apiCall = ApiCall();
  final Color kDarkBlueColor = const Color(0xFF053149);
  final BoxShadow kDefaultBoxshadow = const BoxShadow(
    color: Color(0xFFDFDFDF),
    spreadRadius: 1,
    blurRadius: 10,
    offset: Offset(2, 2),
  );
  int currentIndexprogramariToggle = 0;
  int currentIndexprogramariCopilToggle = 0;
  int currentIndexprogramarileTaleToggle = 0;
  bool programariCopilToggle = true;
  bool programarileTaleToggle = true;
  bool programariToggle = true;

  @override
  void initState() {
    super.initState();
    programari = getListaProgramari();
    programariCopil = getListaProgramariCopil();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: const Icon(Icons.menu),
            ),
            title: const Text('PROGRAMĂRI', style: TextStyle(fontSize: 20)),
            backgroundColor: Color.fromRGBO(57, 52, 118, 1),
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
                  child: mainToggleTab(context),
                ),
                const SizedBox(height: 15),
                programariToggle ? listaProgramariUser(context) : listaProgramariCopil(context)
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
      ),
    );
  }

  Column listaProgramariCopil(BuildContext context) {
    return Column(
      children: [
        Center(
          child: toggleTabCopil(context),
        ),
        programariCopilToggle
            ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return detaliiProgramareWidget(
                    programare: viitoareCopil[index],
                  );
                },
                itemCount: viitoareCopil.length,
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return detaliiProgramareWidget(
                    programare: trecuteCopil[index],
                  );
                },
                itemCount: trecuteCopil.length,
              ),
      ],
    );
  }

  Column listaProgramariUser(BuildContext context) {
    return Column(
      children: [
        Center(
          child: toggleTabUser(context),
        ),
        programarileTaleToggle
            ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return detaliiProgramareWidget(
                    programare: viitoare[index],
                  );
                },
                itemCount: viitoare.length,
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return detaliiProgramareWidget(
                    programare: trecute[index],
                  );
                },
                itemCount: trecute.length,
              ),
      ],
    );
  }

  AppinioAnimatedToggleTab mainToggleTab(BuildContext context) {
    return AppinioAnimatedToggleTab(
      duration: const Duration(milliseconds: 150),
      offset: 0,
      callback: (int index) {
        setState(() {
          programariToggle = !programariToggle;
          // currentIndexprogramariToggle = index;
        });
      },
      tabTexts: const [
        'Programările dvs',
        'Programprile copilului',
      ],
      height: 45,
      width: MediaQuery.of(context).size.width * 0.9,
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

  AppinioAnimatedToggleTab toggleTabUser(BuildContext context) {
    return AppinioAnimatedToggleTab(
      duration: const Duration(milliseconds: 150),
      offset: 0,
      callback: (int index) {
        setState(() {
          programarileTaleToggle = !programarileTaleToggle;
          // currentIndexprogramarileTaleToggle = index;
        });
      },
      tabTexts: const [
        'Programări trecute',
        'Programări viitoare',
      ],
      height: 45,
      width: MediaQuery.of(context).size.width * 0.6,
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

  AppinioAnimatedToggleTab toggleTabCopil(BuildContext context) {
    return AppinioAnimatedToggleTab(
      duration: const Duration(milliseconds: 150),
      offset: 0,
      callback: (int index) {
        setState(() {
          programariCopilToggle = !programariCopilToggle;
          // currentIndexprogramariCopilToggle = index;
        });
      },
      tabTexts: const [
        'Programari trecute',
        'Programari viitoare',
      ],
      height: 45,
      width: MediaQuery.of(context).size.width * 0.6,
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
            id: l[6],
            hasFeedback: l[7],
            idMedic: l[8]);
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
            sfarsit: dateSf,
            hasFeedback: l[7],
            idMedic: l[8]);
        programariTrecute.add(p);
      }
    }
    programariTrecute.sort((a, b) => b.inceput.compareTo(a.inceput));
    programariViitoare.sort((a, b) => a.inceput.compareTo(b.inceput));
    Programari? pP = Programari(trecute: programariTrecute, viitoare: programariViitoare);
    print(" ASta e ${programariViitoare.length}");
    setState(() {
      viitoare = programariViitoare.reversed.toList();
      trecute = programariTrecute.reversed.toList();
    });
    // print(" ASta e ${trecute.length}");
    return pP;
  }

  Future<Programari?> getListaProgramariCopil() async {
    viitoare.clear();
    trecute.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String idUser = prefs.getString(pref_keys.userIdInregistrare)!;
    final Map<String, String> param = {
      'pIdMembru': Shared.familie[0].id,
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pIdLimba': '0',
    };

    String? res =
        await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaProgramariPeMembruFamilie', pParametrii: param);

    List<Programare> programariViitoareCopil = <Programare>[];
    List<Programare> programariTrecuteCopil = <Programare>[];

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
            id: l[6],
            hasFeedback: l[7],
            idMedic: l[8]);
        programariViitoareCopil.add(p);
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
            sfarsit: dateSf,
            hasFeedback: l[7],
            idMedic: l[8]);
        programariTrecuteCopil.add(p);
      }
    }
    programariTrecuteCopil.sort((a, b) => b.inceput.compareTo(a.inceput));
    programariViitoareCopil.sort((a, b) => a.inceput.compareTo(b.inceput));
    Programari? pP = Programari(trecute: programariTrecuteCopil, viitoare: programariViitoareCopil);
    print(" ASta e ${programariViitoareCopil.length}");
    setState(() {
      viitoareCopil = programariViitoareCopil.reversed.toList();
      trecuteCopil = programariTrecuteCopil.reversed.toList();
    });
    // print(" ASta e ${trecute.length}");
    return pP;
  }
}

class detaliiProgramareWidget extends StatefulWidget {
  final Programare? programare;
  const detaliiProgramareWidget({
    super.key,
    this.programare,
  });

  @override
  State<detaliiProgramareWidget> createState() => _detaliiProgramareWidgetState();
}

class _detaliiProgramareWidgetState extends State<detaliiProgramareWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                        DateFormat('d.M.yyyy').format(widget.programare!.inceput).capitalizeFirst(),
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
                      Text(DateFormat.Hm().format(widget.programare!.inceput),
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
                      Text(widget.programare!.medic, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                            const SizedBox(height: 5),
                            Text(widget.programare!.categorie,
                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                          ],
                        ),
                      ),
                      const Expanded(
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
                      color: widget.programare!.status == "Programat"
                          ? Colors.blue
                          : widget.programare!.status == "Confirmat"
                              ? Colors.green
                              : widget.programare!.status == "Finalizat" || widget.programare!.status == "Terminat"
                                  ? Colors.yellow
                                  : widget.programare!.status.startsWith("Anulat")
                                      ? Colors.red
                                      : Colors.grey),
                  child: Center(
                    child: Text(
                        widget.programare!.status == "Programat"
                            ? "PROGRAMAT"
                            : widget.programare!.status == "Confirmat"
                                ? "CONFIRMAT"
                                : widget.programare!.status == "Finalizat" || widget.programare!.status == "Terminat"
                                    ? "FINALIZAT"
                                    : widget.programare!.status.startsWith("Anulat")
                                        ? "ANULAT"
                                        : "ANULAT",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            )
          ]),
        ),
        widget.programare!.hasFeedback == "0" && widget.programare!.inceput.isBefore(DateTime.now())
            ? Positioned(
                right: 2,
                top: 2,
                child: IconButton(
                    icon: const Icon(
                      size: 30,
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedbackScreen(
                                    programare: widget.programare!,
                                  ))).then((value) => setState(() {}));
                    }),
              )
            : const SizedBox(),
      ],
    );
  }
}
