import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:unident_app/login.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool valueCheck = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            Color(0xFFC4A462),
            // Color(0xFFC53C5D),
            Color(0xFF22226C),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          children: [
            SizedBox(height: 55),
            Center(
              child: Image.asset('./assets/images/unident-alb.png', height: height * 0.1),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: height * 0.61,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  const Center(
                      child: Text(
                    'Termeni și Condiții',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 10),
                  Container(
                    height: height * 0.47,
                    child: const PrivacyDialog(mdFileName: "terms_and_conditions.md"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        value: valueCheck,
                        onChanged: (value) {
                          setState(() {
                            valueCheck = value!;
                            print(valueCheck);
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: const Text('Sunt de acord cu termenii și condițiile propuse de aplicația MyUnident',
                            maxLines: 3, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
                      ), //Text
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: valueCheck
                  ? () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }));
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: valueCheck ? Color.fromRGBO(195, 161, 110, 1) : Colors.grey,
                ),
                height: height * 0.08,
                child: Center(
                    child: Text(
                  'ÎNAINTE',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PrivacyDialog extends StatelessWidget {
  const PrivacyDialog({super.key, required this.mdFileName});
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 150)).then((value) {
            return rootBundle.loadString('assets/images/terms&conditions/$mdFileName');
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Markdown(data: snapshot.data!);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    ]);
  }
}
