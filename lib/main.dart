import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
//import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unident_app/firebase_options.dart';
import 'package:unident_app/home.dart';
//import 'package:unident_app/home_screen.dart';
import 'package:unident_app/login.dart';
//import 'package:unident_app/my_account.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:unident_app/terms_and_conditions_screen.dart';
import 'package:unident_app/utils/api_firebase.dart';
//import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
//import 'package:unident_app/clinics_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loggedIn = prefs.getBool('loggedIn');
  var firstTime = prefs.getBool('firstTime');
  runApp(
    MaterialApp(
      // localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('ro')],
      home: const TermsAndConditionsScreen(),
      // home: firstTime == true
      //     ? const TermsAndConditionsScreen()
      //     : loggedIn == true
      //         ? const MyApp()
      //         : const LoginScreen(), //Andrei Badescu
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
    );
  }
}
