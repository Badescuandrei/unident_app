import 'package:flutter/material.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
//import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unident_app/home.dart';
import 'package:unident_app/loading_screen.dart';
//import 'package:unident_app/home_screen.dart';
//import 'package:unident_app/my_account.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:unident_app/terms_and_conditions_screen.dart';
//import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
//import 'package:unident_app/clinics_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseApi().initNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loggedIn = prefs.getBool('loggedIn');
  // var firstTime = prefs.getBool('firstTime');
  runApp(
    MaterialApp(
      themeMode: ThemeMode.light,
      // localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('ro')],
      home: loggedIn == true ? LoadingScreen() : TermsAndConditionsScreen(),
      // home: TermsAndConditionsScreen(),
      debugShowCheckedModeBanner: false,
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
