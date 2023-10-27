import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unident_app/home_screen.dart';
import 'package:unident_app/login.dart';
import 'package:unident_app/utils/api_call_functions.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String birthdate = '';
  final registerKey = GlobalKey<FormState>();

  final controllerNume = TextEditingController();
  final controllerPrenume = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerTelefon = TextEditingController();
  final controllerPass = TextEditingController();
  final controllerPassConfirm = TextEditingController();
  final controllerBirthdate = TextEditingController();

  final FocusNode focusNodeNume = FocusNode();
  final FocusNode focusNodePrenume = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeTelefon = FocusNode();
  final FocusNode focusNodePass = FocusNode();
  final FocusNode focusNodePassConfirm = FocusNode();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 1.1,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
              Color(0xFFC4A462),
              // Color(0xFFC53C5D),
              Color(0xFF22226C),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(children: [
            const SizedBox(height: 40),
            Center(
              child: Image.asset(
                './assets/images/unident-alb.png',
                width: 250,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: registrationFields(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFC3A16E),
                ),
                height: 70,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    if (registerKey.currentState!.validate()) {
                      register(context);
                    }
                  },
                  child: const Center(
                    child: Text(
                      'Înregistrează-mă',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                text: 'Ai deja un cont? ',
                style: const TextStyle(fontSize: 16, color: Colors.white),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pop(context);
                  },
                children: [
                  TextSpan(
                      text: 'Conectează-te aici!',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Form registrationFields() {
    String? confirmPassCheck;
    return Form(
        key: registerKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Column(
            children: [
              TextFormField(
                focusNode: focusNodePrenume,
                controller: controllerNume,
                autocorrect: false,
                textCapitalization: TextCapitalization.words,
                onFieldSubmitted: (String s) {
                  focusNodeNume.requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 3 || RegExp(r'\d').hasMatch(value)) {
                    return "Introduceți un prenume valid";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    icon: Image.asset('./assets/images/login/icons8-contact-48.png', height: 22, width: 22),
                    hintText: 'Prenume',
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white),
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                focusNode: focusNodeNume,
                controller: controllerPrenume,
                autocorrect: false,
                onFieldSubmitted: (String s) {
                  focusNodeEmail.requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 3 || RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Introduceți un nume valid";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    icon: Image.asset('./assets/images/login/icons8-contact-48.png', height: 22, width: 22),
                    hintText: 'Nume',
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white),
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              TextFormField(
                controller: controllerBirthdate,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.date_range_outlined,
                      size: 22,
                      color: Color.fromARGB(255, 80, 14, 187),
                    ),
                    hintText: 'Data de naștere',
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1960),
                      lastDate: DateTime(2024));
                  controllerBirthdate.text = DateFormat('dd-MM-yyyy').format(date!).toString();
                  birthdate = DateFormat('yyyyMMdd').format(date).toString();
                  print(birthdate);
                },
                onFieldSubmitted: (String s) {
                  focusNodeEmail.requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Alegeți o data de nastere!";
                  } else {
                    return null;
                  }
                },
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              TextFormField(
                decoration: InputDecoration(
                    icon: Image.asset('./assets/images/login/icons8-email-48.png', height: 22, width: 22),
                    hintText: 'E-mail',
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white),
                focusNode: focusNodeEmail,
                controller: controllerEmail,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (String s) {
                  focusNodeTelefon.requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r'.+@.+\.+').hasMatch(value)) {
                    return "Introduceți un e-mail valid";
                  } else {
                    return null;
                  }
                },
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              TextFormField(
                onFieldSubmitted: (String s) {
                  focusNodePass.requestFocus();
                },
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      size: 22,
                      color: Color.fromARGB(255, 102, 18, 175),
                    ),
                    hintText: 'Număr de telefon',
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white),
                focusNode: focusNodeTelefon,
                keyboardType: TextInputType.number,
                controller: controllerTelefon,
                autocorrect: false,
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Introduceți un numar de telefon valid";
                  } else {
                    return null;
                  }
                },
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              TextFormField(
                focusNode: focusNodePass,
                onFieldSubmitted: (String s) {
                  focusNodePassConfirm.requestFocus();
                },
                controller: controllerPass,
                obscureText: isHidden,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: passVisibiltyToggle,
                        icon: isHidden ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
                    icon: Image.asset('./assets/images/login/icons8-key-50.png', height: 22, width: 22),
                    hintText: 'Parolă',
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white),
                validator: (value) {
                  confirmPassCheck = value;
                  if (value!.isEmpty) {
                    return "Introduceți o parolă";
                  } else if (value.length < 6) {
                    return "Parola trebuie sa conțină minim 6 caractere";
                  } else {
                    return null;
                  }
                },
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              TextFormField(
                focusNode: focusNodePassConfirm,
                obscureText: isHidden,
                controller: controllerPassConfirm,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: passVisibiltyToggle,
                        icon: isHidden ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
                    icon: Image.asset('./assets/images/login/icons8-key-50.png', height: 22, width: 22),
                    hintText: 'Confirmă parola',
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Introduceți o parolă";
                  }
                  if (value != confirmPassCheck) {
                    return "Parolele nu se potrivesc!";
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ));
  }

  void register(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = await apiCallFunctions.register(
      pNume: controllerNume.text,
      pPrenume: controllerPrenume.text,
      pTelefonMobil: controllerTelefon.text,
      pDataDeNastereYYYYMMDD: birthdate,
      pAdresaMail: controllerEmail.text.trim(),
      pParola: controllerPass.text,
      pFirebaseGoogleDeviceID: prefs.getString(pref_keys.fcmToken) ?? "FCM Token not available in Shared Preferences",
    );

    if (!mounted) {
      return;
    }
    // var l = LocalizationsApp.of(context)!;
    if (res == null) {
      // errorInfo = l.universalEroare;
      // infoWidget = InfoWidget.error;
      print("Eroare null");
      return;
    }
    if (res.startsWith('13\$#\$')) {
      prefs.setString(pref_keys.userEmail, controllerEmail.text);
      if (context.mounted) {
        Flushbar(
          message: "Register încheiat cu succes!",
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
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
        });
      }
      return;
    } else if (res.startsWith('66\$#\$')) {
      Flushbar(
        message: "Date greșite, verifică cu atenție datele introduse și încearca încă o dată!",
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red,
        ),
        borderColor: Colors.red,
        borderWidth: 2,
        isDismissible: false,
        margin: const EdgeInsets.all(6.0),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(12),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
      print("dategresite");
      return;
    } else if (res.startsWith('132')) {
      Flushbar(
        message: "Un pacient cu datele introduse este deja înregistrat!",
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red,
        ),
        borderColor: Colors.red,
        borderWidth: 2,
        isDismissible: false,
        margin: const EdgeInsets.all(6.0),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(12),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
      return;
    }
  }

  void passVisibiltyToggle() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}
