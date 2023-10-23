import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:unident_app/home.dart';
import 'package:unident_app/home_screen.dart';
import 'package:unident_app/loading_screen.dart';
import 'package:unident_app/password_reset.dart';
import 'package:unident_app/register.dart';
import 'package:unident_app/utils/api_call_functions.dart';
import 'package:unident_app/utils/api_firebase.dart';
import 'package:unident_app/utils/classes.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/functions.dart';

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginKey = GlobalKey<FormState>();
  bool isHidden = true;
  bool loginPhoneOrEmail = false;

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
        body: SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            Color(0xFFFFC65C),
            // Color(0xFFC53C5D),
            Color(0xFF110D5C),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(children: [
          const SizedBox(height: 70),
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
            child: Column(children: [
              Form(
                  key: loginKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Column(
                      children: [
                        TextFormField(
                          focusNode: focusNodeEmail,
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
                              return "Enter a valid Email Address or Password";
                            } else {
                              return null;
                            }
                          },
                        ),
                        TextFormField(
                          focusNode: focusNodePassword,
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
                            if (value!.isEmpty) {
                              return "Please Enter New Password";
                            } else if (value.length < 6) {
                              return "Password must be atleast 6 characters long";
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
                  )),
            ]),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              final isValidForm = loginKey.currentState!.validate();
              if (isValidForm) {
                login(context);
              }
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
                child: const Center(
                  child: Text(
                    'Intra in cont',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Nu ai deja un cont? ',
                    style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
                      },
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Ai uitat parola? ',
                    style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PasswordReset()));
                      },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    ));
  }

  login(BuildContext context) async {
    String mail = controllerEmail.text;
    String pass = controllerPass.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final token = await FirebaseMessaging.instance.getToken() ?? '';

    String? res = await apiCallFunctions.login(
        pAdresaEmail: mail.trim(),
        pParolaMD5: apiCallFunctions.generateMd5(pass),
        pFirebaseGoogleDeviceID:
            prefs.getString(pref_keys.fcmToken) ?? "FCM Token not available in Shared Preferences");
    print(res);
    if (res == null) {
      showSnackbar(
        context,
        "Date de login gresite!",
      );
      return;
      // } else if (res.startsWith('161')) {
      //   showsnackbar(
      //     context,
      //     "Date de login varule!",
      //   );
      // return;
    } else if (res.startsWith('66')) {
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
      return;
    } else if (res.contains('\$#\$')) {
      // ignore: use_build_context_synchronously
      Flushbar(
        message: "Login incheiat cu succes!",
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
      // showsnackbar(context, "Succes!");
      List<String> info = res.split('\$#\$');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(pref_keys.userPassMD5, apiCallFunctions.generateMd5(controllerPass.text));
      prefs.setString(pref_keys.userIdInregistrare, info[0]);
      prefs.setString(pref_keys.userNume, info[1]);
      prefs.setString(pref_keys.userPrenume, info[2]);
      prefs.setString(pref_keys.userIdPacientAsociat, info[3]);
      prefs.setString(pref_keys.userVip, info[4]);
      prefs.setString(pref_keys.userNeserios, info[5]);
      prefs.setString(pref_keys.userDDN, info[6]);
      prefs.setString(pref_keys.userSex, info[7]);
      prefs.setString(pref_keys.userIdAjustareCurenta, info[8]);
      prefs.setString(pref_keys.userDataInceputAjustare, info[9]);
      prefs.setString(pref_keys.userDataSfarsitAjustare, info[10]);
      prefs.setString(pref_keys.dataAsociere, info[11]);
      prefs.setString(pref_keys.userDataFisa, info[12]);
      prefs.setString(pref_keys.userTelefon, info[13]);
      prefs.setString(pref_keys.userEmail, info[14]);
      prefs.setString(pref_keys.userNumarPuncteAcumulate, info[15]);
      prefs.setString(pref_keys.userUltimaDataAsociere, info[16]);
      prefs.setString(pref_keys.userTotalPuncteNivelMediu, info[17]);
      prefs.setString(pref_keys.userTotalPuncteNivelSuperior, info[18]);
      prefs.setString(pref_keys.idSediuUser, info[19]);
      prefs.setString(pref_keys.permiteIntroducereaDeProgramari, info[20]);
      prefs.setBool(pref_keys.loggedIn, true);
      prefs.setBool(pref_keys.firstTime, false);
      Future.delayed(const Duration(seconds: 2), () {
        saveTokenToDB(Shared.FCMtoken);
        Navigator.of(context)
            .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoadingScreen()), (route) => false);
      });
    }
  }
}
