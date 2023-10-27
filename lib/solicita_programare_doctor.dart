import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
// import 'package:unident_app/home.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:unident_app/horizontal_week_calendar.dart';
import 'package:unident_app/utils/api_call_functions.dart';

Map<String, Duration> orarProgramari = {
  '8:00 AM': const Duration(hours: 8),
  '9:00 AM': const Duration(hours: 9),
  '10:00 AM': const Duration(hours: 10),
  '11:00 AM': const Duration(hours: 11),
  '12:00 PM': const Duration(hours: 12),
  '13:00 PM': const Duration(hours: 13),
  '14:00 PM': const Duration(hours: 14),
  '15:00 PM': const Duration(hours: 15),
  '16:00 PM': const Duration(hours: 16),
  '17:00 PM': const Duration(hours: 17),
  '18:00 PM': const Duration(hours: 18),
  '19:00 PM': const Duration(hours: 19),
};
ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class SolicitaProgramareDoctorScreen extends StatefulWidget {
  // eu aici ii dau judet, dar pot sa fac asta doar din doctorii cu intervalul de timp selectat
  final String? judet;
  final Uint8List poza;
  final String nume;
  final String id;
  const SolicitaProgramareDoctorScreen(
      {super.key, required this.poza, required this.nume, required this.id, this.judet});

  @override
  State<SolicitaProgramareDoctorScreen> createState() => _SolicitaProgramareDoctorScreenState();
}

class _SolicitaProgramareDoctorScreenState extends State<SolicitaProgramareDoctorScreen> {
  DateTime selectedDate = DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  int selectedIndex = -1;
  bool wasHourSelected = false;
  final controllerDetails = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text(
            'Solicită o programare',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: Color.fromRGBO(57, 52, 118, 1),
          centerTitle: true),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      CircleAvatar(
                        backgroundImage: MemoryImage(widget.poza),
                        radius: 50,
                      )
                    ]),
                    const Column(
                      children: [
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(widget.nume,
                              style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
                        ), // TO-DO : get doctor name from api')
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_pin, color: Colors.black38, size: 20),
                            SizedBox(width: 5),
                            Text(widget.judet ?? "SankyFresh",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)) // TO-DO : get doctor location from api'
                          ],
                        )
                      ],
                    )
                  ],
                )),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  HorizontalWeekCalendar(
                    weekStartFrom: WeekStartFrom.Monday,
                    activeBackgroundColor: const Color.fromRGBO(57, 52, 118, 1),
                    activeTextColor: Colors.white,
                    inactiveBackgroundColor: Colors.white,
                    inactiveTextColor: Colors.black,
                    disabledTextColor: Colors.grey,
                    disabledBackgroundColor: Colors.white,
                    activeNavigatorColor: Colors.black,
                    inactiveNavigatorColor: Colors.grey,
                    monthColor: Colors.black,
                    onDateChange: (date) {
                      selectedDate = date;
                      print(selectedDate);
                    },
                  ),
                  const Divider(color: Colors.black12, thickness: 2),
                  SizedBox(
                    height: 70,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: orarProgramari.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.6 / 1.6),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: GestureDetector(
                            onTap: wasHourSelected
                                ? () {
                                    // selectedDate.add(orarProgramari.values.elementAt(index));
                                    // print(DateFormat.jms().format(selectedDate));
                                    setState(() {
                                      wasHourSelected = true;
                                      selectedIndex = index;
                                      selectedDate = selectedDate.copyWith(
                                          hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
                                      selectedDate = selectedDate.add(orarProgramari.values.elementAt(index));
                                      // selectedDate.add(orarProgramari.values.elementAt(index));
                                      // print(orarProgramari.values.elementAt(index));
                                      // print(selectedDate.add(orarProgramari.values.elementAt(index)));
                                    });
                                    // print(DateTime.now().add(Duration(hours: 5)));
                                  }
                                : () {
                                    setState(() {
                                      wasHourSelected = true;
                                      selectedIndex = index;
                                      selectedDate = selectedDate.add(orarProgramari.values.elementAt(index));
                                    });
                                  },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index == selectedIndex
                                    ? const Color.fromARGB(255, 46, 4, 171)
                                    : Colors.grey.shade200,
                              ),
                              child: Center(
                                child: Text(
                                  orarProgramari.keys.elementAt(index),
                                  style: TextStyle(
                                      color: index == selectedIndex ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: controllerDetails,
                keyboardType: TextInputType.streetAddress,
                maxLines: 2,
                decoration: const InputDecoration(
                    hintText: "Introduceți câteva detalii despre problema dvs.",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 227, 221, 221)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Nota: Echipa noastra va propune sa alegeti o zi si o ora pentru programare la o consultatie ca ulterior sa puteti prelua legatura cu o colega care sa va confirme daca alegerea dvs. este posibila sau sa va poata propune o data alternativa',
                maxLines: 5,
                style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                sendAppointmentRequest().then((value) {
                  value == null
                      ? null
                      : value.contains('13')
                          ? Future.delayed(const Duration(milliseconds: 10), () {})
                          : null;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(57, 52, 118, 1),
                  ),
                  height: 50,
                  width: 200,
                  child: const Center(
                    child: Text(
                      'Programează-mă',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> sendAppointmentRequest() async {
    if (controllerDetails.text.isEmpty) {
      Flushbar(
        message: "Adăugați câteva detalii!",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red[400],
        ),
        borderColor: Colors.red[400],
        borderWidth: 2,
        isDismissible: false,
        margin: const EdgeInsets.all(6.0),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(12),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red[400],
      ).show(context);
      return null;
    } else if (selectedDate.hour == 0) {
      Flushbar(
        message: "Selectați o oră!",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red[400],
        ),
        borderColor: Colors.red[400],
        borderWidth: 2,
        isDismissible: false,
        margin: const EdgeInsets.all(6.0),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(12),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red[400],
      ).show(context);
      return null;
    }
    // } else if (controllerDatePicker.toString().isEmpty) {
    //   print("error 2");
    //   return;
    // }
    // } else if (controllerEndDate.text.isEmpty) {
    //   controllerStartDate.text = _startTime;
    //   print("error 3");
    // } else if (controllerStartDate.text.isEmpty) {
    //   controllerStartDate.text = _endTime;
    //   print("error 4");
    // }
    // TO-DO : implement snackbar message please fill all the fields
    else {
      String? res = await apiCallFunctions.adaugaProgramare(
          pIdCategorie: '',
          pIdMedic: widget.id,
          pDataProgramareDDMMYYYYHHmm: selectedDate.toString(),
          pObservatiiProgramare: controllerDetails.text,
          pIdSediu: '',
          pIdMembruFamilie: '');
      // ignore: avoid_print
      print(res);

      if (res!.startsWith("13")) {
        print('e bine');
        Flushbar(
          message: "Cerere trimisă cu succes!",
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.green,
          ),
          borderColor: Colors.green,
          borderWidth: 2,
          isDismissible: false,
          margin: const EdgeInsets.all(6.0),
          flushbarStyle: FlushbarStyle.FLOATING,
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(12),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: Colors.green,
        ).show(context);

        return "13";
      }
      return "eroare";
    }
  }
}
