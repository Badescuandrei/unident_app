import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unident_app/home_screen.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          height: MediaQuery.of(context).size.height * 1.2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
              Color(0xFFFFC65C),
              // Color(0xFFC53C5D),
              Color(0xFF110D5C),
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
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const HomeScreen();
                }));
              },
              child: Padding(
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
                        'Inregistreaza-ma',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
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
                      text: 'Conecteaza-te aici!',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            )
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
                onFieldSubmitted: (String s) {
                  focusNodeNume.requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 3 || RegExp(r'\d').hasMatch(value)) {
                    return "Enter a valid username";
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
              TextFormField(
                focusNode: focusNodeNume,
                controller: controllerPrenume,
                autocorrect: false,
                onFieldSubmitted: (String s) {
                  focusNodeEmail.requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 3 || RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Enter a valid username";
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
              TextFormField(
                controller: controllerBirthdate,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.date_range_outlined,
                      size: 22,
                      color: Color.fromARGB(255, 80, 14, 187),
                    ),
                    hintText: 'Data de nastere',
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1960),
                      lastDate: DateTime(2024));
                  controllerBirthdate.text = DateFormat('yyyyMMdd').format(date!).toString();
                },
                onFieldSubmitted: (String s) {
                  focusNodeEmail.requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Alegeti o data de nastere!";
                  } else {
                    return null;
                  }
                },
              ),
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
                    return "Enter a valid Email Address";
                  } else {
                    return null;
                  }
                },
              ),
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
                    hintText: 'Numar de telefon',
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white),
                focusNode: focusNodeTelefon,
                keyboardType: TextInputType.number,
                controller: controllerTelefon,
                autocorrect: false,
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Introduceti un numar de telefon valid";
                  } else {
                    return null;
                  }
                },
              ),
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
                    hintText: 'Parola',
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white),
                validator: (value) {
                  confirmPassCheck = value;
                  if (value!.isEmpty) {
                    return "Please enter a password";
                  } else if (value.length < 6) {
                    return "Password must be atleast 6 characters long";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                focusNode: focusNodePassConfirm,
                obscureText: isHidden,
                controller: controllerPassConfirm,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: passVisibiltyToggle,
                        icon: isHidden ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
                    icon: Image.asset('./assets/images/login/icons8-key-50.png', height: 22, width: 22),
                    hintText: 'Confirma parola',
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Colors.white),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a password";
                  }
                  if (value != confirmPassCheck) {
                    return "Parolele nu se potrivesc!";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10),
              Image.asset(
                './assets/images/login/CALL CENTER.png',
                width: 100,
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
      pDataDeNastereYYYYMMDD: controllerBirthdate.text,
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
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
        Flushbar(
          message: "Register incheiat cu succes!",
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
          Navigator.pop(context);
        });
      }
      return;
    }
    if (res.startsWith('66\$#\$')) {
      Flushbar(
        message: "Date gresite, verifica cu atentie datele introduse si incearca inca o data!",
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
    }

    if (res.startsWith('132\$#\$')) {
      print("register error");
      return;
    }
    print(res);
  }

  void passVisibiltyToggle() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}
