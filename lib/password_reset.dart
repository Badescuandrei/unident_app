import './password_reset_pin.dart';
import 'package:flutter/material.dart';
import 'package:unident_app/utils/api_call_functions.dart';
import '../utils/functions.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class _PasswordResetState extends State<PasswordReset> {
  bool verificationOk = false;
  final loginKey = GlobalKey<FormState>();
  bool isHidden = true;
  final controllerEmail = TextEditingController();
  final controllerPass = TextEditingController();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  void passVisibiltyToggle() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
              Color(0xFFC4A462),
              // Color(0xFFC53C5D),
              Color(0xFF22226C),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  Row(children: [
                    IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        ),
                        color: Colors.black,
                        onPressed: () => Navigator.pop(context)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Înapoi",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
                      ),
                    )
                  ]),
                ],
              ),
              const SizedBox(height: 55),
              Image.asset(
                './assets/images/unident-alb.png',
                height: 70,
              ),
              const SizedBox(height: 100),

              // Welcome message
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Resetează parola!",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Text Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: loginForm(),
              ),
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 176, 146, 86),
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    final isValidForm = loginKey.currentState!.validate();
                    if (isValidForm) {
                      resetPassword();
                    }
                  },
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: const Text(
                      'Trimite cererea de resetare',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Container loginForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Form(
        key: loginKey,
        child: Column(
          children: [
            TextFormField(
              onFieldSubmitted: (String s) {
                focusNodePassword.requestFocus();
              },
              controller: controllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Image.asset('./assets/images/login/icons8-email-48.png', height: 22, width: 22),
                  hintText: 'E-mail',
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  filled: true,
                  fillColor: Colors.white),
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
              focusNode: focusNodePassword,
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
                if (value!.isEmpty) {
                  return "Introduceți o parolă";
                } else if (value.length < 6) {
                  return "Parola trebuie sa conțină minim 6 caractere";
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  resetPassword() async {
    String? res =
        await apiCallFunctions.reseteazaParola(pAdresaMail: controllerEmail.text, pParolaNoua: controllerPass.text);
    print(res);
    if (res == null) {
      showSnackbar(
        context,
        "E-mail gresit!",
      );
      return;
    } else if (res.startsWith('66')) {
      showSnackbar(context, "E-mail gresit!");
      return;
    } else if (res.startsWith('13')) {
      showSnackbar(context, "E-mail corect - cerere trimisa!");
      setState(() {
        verificationOk = true;
        if (verificationOk) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PasswordResetPin(
                    resetEmailOrPhoneNumber: false,
                    password: controllerPass.text,
                    email: controllerEmail.text,
                  )));
        }
      });

      return;
    }
  }
}
