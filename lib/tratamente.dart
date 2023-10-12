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
  late Future<List<LinieFisaTratament>?> tratamenteUser;
  late Future<List<LinieFisaTratament>?> tratamenteCopilUser;
  final Color kDarkBlueColor = const Color(0xFF053149);
  bool isSwitched = false;
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
    tratamenteUser = getListaTratamente();
    tratamenteCopilUser = getListaLiniiFisaTratamentRealizateMembruFamilie();
  }

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
          title: const Text('PLANUL DE TRATAMENT', style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.purple[900],
          centerTitle: true),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: toggleTab(context),
          ),
          const SizedBox(height: 20),
          isSwitched
              ? FutureBuilder(
                  future: tratamenteCopilUser,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        return listaTratamenteCopil(snapshot);
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
                  future: tratamenteUser,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        return listaTratamenteUser(snapshot);
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
        ],
      ),
    );
  }

  AppinioAnimatedToggleTab toggleTab(BuildContext context) {
    return AppinioAnimatedToggleTab(
      duration: const Duration(milliseconds: 150),
      offset: 0,
      callback: (int index) {
        setState(() {
          isSwitched = !isSwitched;
        });
      },
      tabTexts: const [
        'Tratamentele dvs.',
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

  ListView listaTratamenteUser(AsyncSnapshot<List<LinieFisaTratament>?> snapshot) {
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

  ListView listaTratamenteCopil(AsyncSnapshot<List<LinieFisaTratament>?> snapshot) {
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

  // void loadData() async {
  //   List<MembruFamilie> f = await apiCallFunctions.getListaFamilie();
  //   Shared.familie.addAll(f);
  //   print('ASta este ${f.length}');
  // }
}
