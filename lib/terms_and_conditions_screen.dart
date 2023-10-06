import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
            Color(0xFFFFC65C),
            // Color(0xFFC53C5D),
            Color(0xFF110D5C),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          children: [
            SizedBox(height: 25),
            Center(
              child: Image.asset('./assets/images/unident-alb.png', height: height * 0.1),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: height * 0.71,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  const Center(
                      child: Text(
                    'Termeni si Conditii',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 10),
                  Container(
                    height: height * 0.57,
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
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text('Sunt de acord cu termenii si conditiile propuse\nde aplicatia MyUnident',
                          maxLines: 3, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)), //Text
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 210, 153, 47),
              ),
              height: height * 0.08,
              child: const Center(
                  child: Text(
                'INAINTE',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
              )),
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
