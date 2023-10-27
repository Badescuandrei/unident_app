import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:unident_app/apinio.dart';
import 'package:unident_app/tratamente_item.dart';
import 'package:unident_app/utils/api_call_functions.dart';
import 'package:unident_app/utils/classes.dart';

class TratamenteScreen extends StatefulWidget {
  const TratamenteScreen({super.key});

  @override
  State<TratamenteScreen> createState() => _TratamenteScreenState();
}

class _TratamenteScreenState extends State<TratamenteScreen> {
  late Future<List<LinieFisaTratament>?> tratamenteDeFacutUser;
  late Future<List<LinieFisaTratament>?> tratamenteDeFacutUserCopil;
  late Future<List<LinieFisaTratament>?> tratamenteFinalizateUser;
  late Future<List<LinieFisaTratament>?> tratamenteFinalizateCopilUser;
  final Color kDarkBlueColor = const Color(0xFF053149);
  bool tratamenteToggle = true;
  bool tratamenteCopilToggle = true;
  bool tratamenteTaleToggle = true;
  // int currentIndextratamenteToggle = 0;
  // int currentIndextratamenteCopilToggle = 0;
  // int currentIndextratamenteTaleToggle = 0;

  final BoxShadow kDefaultBoxshadow = const BoxShadow(
    color: Color(0xFFDFDFDF),
    spreadRadius: 1,
    blurRadius: 10,
    offset: Offset(2, 2),
  );
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();

  @override
  void initState() {
    super.initState();
    // loadData();
    tratamenteDeFacutUser = getListaTratamenteDeFacut();
    tratamenteDeFacutUserCopil = getListaLiniiFisaTratamentDeFacutMembruFamilie();
    tratamenteFinalizateUser = getListaTratamente();
    tratamenteFinalizateCopilUser = getListaLiniiFisaTratamentRealizateMembruFamilie();
  }

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
            title: const Text('Planul de tratament', style: TextStyle(fontSize: 20)),
            backgroundColor: Color.fromRGBO(57, 52, 118, 1),
            centerTitle: true),
        backgroundColor: const Color.fromARGB(255, 236, 236, 236),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Shared.familie.length == 0
                  ? Center(
                      child: tratamenteToggleTabDacaNuAreCopil(context),
                    )
                  : Center(
                      child: tratamenteToggleTabDacaAreCopil(context),
                    ),
              const SizedBox(height: 20),
              tratamenteToggle
                  ? FutureBuilder(
                      future: tratamenteFinalizateUser,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data == null) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    tratamenteToggleTabUser(context),
                                    SizedBox(height: 20),
                                  ],
                                ),
                                tratamenteTaleToggle
                                    ? listaTratamenteFinalizateUser(snapshot)
                                    : FutureBuilder(
                                        future: tratamenteDeFacutUser,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            if (snapshot.data == null) {
                                              return const Center(child: CircularProgressIndicator());
                                            }
                                            if (snapshot.hasData) {
                                              return Column(
                                                children: [
                                                  listaTratamenteDeFacutUser(snapshot),
                                                ],
                                              );
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                child: Text("Error"),
                                              );
                                            }
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        })
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error"),
                            );
                          }
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      })
                  : FutureBuilder(
                      future: tratamenteFinalizateCopilUser,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data == null) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    tratamenteToggleTabCopil(context),
                                    SizedBox(height: 20),
                                  ],
                                ),
                                tratamenteCopilToggle
                                    ? listaTratamenteFinalizateCopil(snapshot)
                                    : FutureBuilder(
                                        future: tratamenteDeFacutUserCopil,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            if (snapshot.data == null) {
                                              return const Center(child: CircularProgressIndicator());
                                            }
                                            if (snapshot.hasData) {
                                              return Column(
                                                children: [
                                                  listaTratamenteDeFacutCopil(snapshot),
                                                ],
                                              );
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                child: Text("Error"),
                                              );
                                            }
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        })
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error"),
                            );
                          }
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }

  AppinioAnimatedToggleTab tratamenteToggleTabDacaNuAreCopil(BuildContext context) {
    return AppinioAnimatedToggleTab(
      duration: const Duration(milliseconds: 150),
      offset: 0,
      callback: (int index) {
        null;
      },
      tabTexts: const ['Programările dvs'],
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

  AppinioAnimatedToggleTab tratamenteToggleTabDacaAreCopil(BuildContext context) {
    return AppinioAnimatedToggleTab(
      duration: const Duration(milliseconds: 150),
      offset: 0,
      callback: (int index) {
        setState(() {
          tratamenteToggle = !tratamenteToggle;
        });
      },
      tabTexts: const [
        'Tratamentele dvs',
        'Tratamentele copilului',
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

  AppinioAnimatedToggleTab tratamenteToggleTabUser(BuildContext context) {
    return AppinioAnimatedToggleTab(
      duration: const Duration(milliseconds: 150),
      offset: 0,
      callback: (int index) {
        setState(() {
          tratamenteTaleToggle = !tratamenteTaleToggle;
        });
      },
      tabTexts: const [
        'Tratamentele finalizate',
        'Tratamentele viitoare',
      ],
      height: 45,
      width: MediaQuery.of(context).size.width * 0.65,
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

  AppinioAnimatedToggleTab tratamenteToggleTabCopil(BuildContext context) {
    return AppinioAnimatedToggleTab(
      duration: const Duration(milliseconds: 150),
      offset: 0,
      callback: (int index) {
        setState(() {
          tratamenteCopilToggle = !tratamenteCopilToggle;
        });
      },
      tabTexts: const [
        'Tratamentele finalizate',
        'Tratamentele viitoare',
      ],
      height: 45,
      width: MediaQuery.of(context).size.width * 0.65,
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

  ListView listaTratamenteFinalizateUser(AsyncSnapshot<List<LinieFisaTratament>?> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Center(
            child: TratamenteItem(
                data: snapshot.data![index].dataDateTime,
                doctor: snapshot.data![index].numeMedic,
                price: snapshot.data![index].pret,
                procedure: snapshot.data![index].denumireInterventie),
          );
        });
  }

  ListView listaTratamenteFinalizateCopil(AsyncSnapshot<List<LinieFisaTratament>?> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Center(
            child: TratamenteItem(
                data: snapshot.data![index].dataDateTime,
                doctor: snapshot.data![index].numeMedic,
                price: snapshot.data![index].pret,
                procedure: snapshot.data![index].denumireInterventie),
          );
        });
  }

  ListView listaTratamenteDeFacutCopil(AsyncSnapshot<List<LinieFisaTratament>?> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Center(
            child: TratamenteItem(
                data: snapshot.data![index].dataDateTime,
                doctor: snapshot.data![index].numeMedic,
                price: snapshot.data![index].pret,
                procedure: snapshot.data![index].denumireInterventie),
          );
        });
  }

  ListView listaTratamenteDeFacutUser(AsyncSnapshot<List<LinieFisaTratament>?> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Center(
            child: TratamenteItem(
                data: snapshot.data![index].dataDateTime,
                doctor: snapshot.data![index].numeMedic,
                price: snapshot.data![index].pret,
                procedure: snapshot.data![index].denumireInterventie),
          );
        });
  }

  Future<List<LinieFisaTratament>?> getListaTratamente() async {
    List<LinieFisaTratament>? lista1 = await apiCallFunctions.getListaLiniiFisaTratamentRealizate();
    if (lista1 == null) {
      return null;
    } else {
      // ignore: avoid_print
      print(lista1);
      return lista1;
    }
    // ignore: avoid_print
  }

  Future<List<LinieFisaTratament>?> getListaTratamenteDeFacut() async {
    List<LinieFisaTratament>? lista1 = await apiCallFunctions.getListaLiniiFisaTratamentDeFacut();
    if (lista1 == null) {
      return null;
    } else {
      // ignore: avoid_print
      print(lista1);
      return lista1;
    }
    // ignore: avoid_print
  }

  Future<List<LinieFisaTratament>?> getListaLiniiFisaTratamentRealizateMembruFamilie() async {
    List<LinieFisaTratament>? lista1 =
        await apiCallFunctions.getListaLiniiFisaTratamentRealizateMembruFamilie(Shared.familie[0]);
    if (lista1 == null) {
      return null;
    } else {
      // ignore: avoid_print
      print(lista1);
      return lista1;
    }
    // ignore: avoid_print
  }

  Future<List<LinieFisaTratament>?> getListaLiniiFisaTratamentDeFacutMembruFamilie() async {
    List<LinieFisaTratament>? lista1 =
        await apiCallFunctions.getListaLiniiFisaTratamentDeFacutPeMembruFamilie(Shared.familie[0]);
    if (lista1 == null) {
      return null;
    } else {
      // ignore: avoid_print
      print(lista1);
      return lista1;
    }
    // ignore: avoid_print
  }

  // void loadData() async {
  //   List<MembruFamilie> f = await apiCallFunctions.getListaFamilie();
  //   Shared.familie.addAll(f);
  //   print('ASta este ${f.length}');
  // }
}
