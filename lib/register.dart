import 'package:flutter/material.dart';
import 'package:unident_app/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Column(
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                            icon: Image.asset('./assets/images/login/icons8-contact-48.png', height: 22, width: 22),
                            hintText: 'Nume, prenume',
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            filled: true,
                            fillColor: Colors.white)),
                    TextFormField(
                        decoration: InputDecoration(
                            icon: Image.asset('./assets/images/login/icons8-key-50.png', height: 22, width: 22),
                            hintText: 'Parola',
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            filled: true,
                            fillColor: Colors.white)),
                    TextFormField(
                        decoration: InputDecoration(
                            icon: Image.asset('./assets/images/login/icons8-key-50.png', height: 22, width: 22),
                            hintText: 'Confirmare parola',
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            filled: true,
                            fillColor: Colors.white)),
                    TextFormField(
                        decoration: InputDecoration(
                            icon: Image.asset('./assets/images/login/icons8-email-48.png', height: 22, width: 22),
                            hintText: 'E-mail',
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            filled: true,
                            fillColor: Colors.white)),
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
                child: const Center(
                  child: Text(
                    'Inregistreaza-ma',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
