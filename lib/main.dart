import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unident_app/firebase_options.dart';
import 'package:unident_app/terms_and_conditions_screen.dart';
import 'package:unident_app/home.dart';
import 'package:unident_app/home_screen.dart';
import 'package:unident_app/horizontal_week_calendar.dart';
import 'package:unident_app/login.dart';
import 'package:unident_app/my_account.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:unident_app/glisare_imagini_screen_IGV_only.dart';
import 'package:unident_app/clinics_glisare_imagini_screen.dart';
import 'package:unident_app/utils/api_firebase.dart';
//import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';

//import 'package:unident_app/clinics_list_screen.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  var loggedIn = prefs.getBool('loggedIn');
  runApp(
    MaterialApp(
      // localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [Locale('en'), Locale('ro')],
      home: loggedIn == true ? const MyApp() : const LoginScreen(), //Andrei Badescu
      // home: MyApp(),
      // theme: ThemeData(
      //   textTheme: GoogleFonts.openSansTextTheme(),
      // ), // use MaterialApp
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Home(),
      //home: GlisareImaginiScreen(),
      // home: ClinicsGlisareImaginiScreen(),
      //home: ClinicsScreen(),
    );
  }
}

class MyApp2 extends StatefulWidget {
  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  DateTime selectedDate = DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  int selectedIndex = -1;
  bool wasHourSelected = false;

  // @override
  // void initState() {
  //   super.initState();
  //   selectedDate = DateTime.now();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: const Icon(Icons.menu),
            ),
            title: const Text(
              'Solitica o programare',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            backgroundColor: Colors.purple[900],
            centerTitle: true),
        body: Column(
          children: [
            const SizedBox(height: 40),
            HorizontalWeekCalendar(
              weekStartFrom: WeekStartFrom.Monday,
              activeBackgroundColor: const Color.fromARGB(255, 46, 4, 171),
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
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.6 / 1.6),
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
                          color: index == selectedIndex ? const Color.fromARGB(255, 46, 4, 171) : Colors.grey.shade200,
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Text(
                  'Nota: Echipa noastra va propune sa alegeti o zi si o ora pentru programare la o consultatie ca ulterior sa puteti prelua legatura cu o colega care sa va confirme daca alegerea dvs. este posibila sau sa va poata propune o data alternativa',
                  maxLines: 5,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => print(selectedDate),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 46, 4, 171),
                  ),
                  height: 50,
                  width: 200,
                  child: const Center(
                    child: Text(
                      'Programeaza-ma',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
}

// class MyWidget extends StatefulWidget {
//   final ValueGetter valueGetter;
//   final ValueSetter valueSetter;
//   final ValueChanged<String?> valueChanged;

//   MyWidget({required this.valueChanged, required this.valueGetter, required this.valueSetter});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   //Declare the callbacks

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       //Sample usage of the callbacks
//       TextField(
//         onChanged: widget.valueSetter,
//       ),
//       TextField(
//         onChanged: widget.valueChanged,
//       ),
//       ElevatedButton(
//           onPressed: () {},
//           child: Text(
//             'Am a ValueGetter',
//           )),
//     ]);
//   }
// }
