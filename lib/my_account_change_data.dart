import 'package:another_flushbar/flushbar.dart';

import './password_reset_pin.dart';
import './utils/functions.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api_call_functions.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool verificationOk = false;

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
  final FocusNode focusNodeBirthdate = FocusNode();
  DateTime? dataNasterii;

  String hintNume = '';
  String hintPrenume = '';
  String hintEmail = '';
  String hintTelefon = '';
  String hintDataNastere = '';
  String hintParola = '';
  bool isHidden = true;
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text('Profilul meu', style: TextStyle(fontSize: 20)),
          backgroundColor: const Color.fromRGBO(57, 52, 118, 1),
          centerTitle: true),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  registrationFields(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(57, 52, 118, 1),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      final isValidForm = registerKey.currentState!.validate();
                      if (isValidForm) {
                        changeUserData();
                      }
                    },
                    child: const Text(
                      'Schimbă datele',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form registrationFields() {
    return Form(
      key: registerKey,
      child: Column(children: [
        TextFormField(
            readOnly: true,
            focusNode: focusNodePrenume,
            controller: controllerNume,
            autocorrect: false,
            onFieldSubmitted: (String s) {
              focusNodeNume.requestFocus();
            },
            decoration: InputDecoration(
                hintText: hintPrenume,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        const SizedBox(height: 3),
        TextFormField(
            readOnly: true,
            focusNode: focusNodeNume,
            controller: controllerPrenume,
            autocorrect: false,
            onFieldSubmitted: (String s) {
              focusNodeEmail.requestFocus();
            },
            decoration: InputDecoration(
                hintText: hintNume,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        const SizedBox(height: 3),
        TextFormField(
            focusNode: focusNodeEmail,
            controller: controllerEmail,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (String s) {
              focusNodeTelefon.requestFocus();
            },
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.edit),
                hintText: hintEmail,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        const SizedBox(height: 3),
        TextFormField(
            focusNode: focusNodeTelefon,
            keyboardType: TextInputType.number,
            controller: controllerTelefon,
            autocorrect: false,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.edit),
                hintText: hintTelefon,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        const SizedBox(height: 3),
        // TextFormField(
        //     focusNode: focusNodeBirthdate,
        //     autocorrect: false,
        //     readOnly: true,
        //     decoration: InputDecoration(
        //         hintText: hintDataNastere,
        //         enabledBorder:
        //             const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
        //         filled: true,
        //         fillColor: Colors.white)),
        // const SizedBox(height: 3),
      ]),
    );
  }

  void loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hintNume = prefs.getString(pref_keys.userNume)!;
      hintPrenume = prefs.getString(pref_keys.userPrenume)!;
      hintTelefon = prefs.getString(pref_keys.userTelefon)!;
      hintEmail = prefs.getString(pref_keys.userEmail)!;
      hintParola = prefs.getString(pref_keys.userPassMD5)!;
    });
  }

  changeUserData() async {
    String? res = await apiCallFunctions.adaugaTaskActualizareDateContact(
      pAdresaMailNoua: controllerEmail.text.isEmpty ? hintEmail : controllerEmail.text.trim(),
      pTelefonNou: controllerTelefon.text.isEmpty ? hintTelefon : controllerTelefon.text.trim(),
    );
    print(res);
    if (res == null) {
      Flushbar(
        message: "Eroare server!",
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
    } else if (res.startsWith('66')) {
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
      return;
    } else if (res.startsWith('13')) {
      Flushbar(
        message: "Date corecte, cererea a fost trimisă!",
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
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.green,
      ).show(context);
      // setState(
      //   () {
      //     verificationOk = true;
      //     if (verificationOk) {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (context) => PasswordResetPin(
      //             resetEmailOrPhoneNumber: true,
      //             email: hintEmail,
      //             password: hintParola,
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // );
      return;
    }
  }
}
