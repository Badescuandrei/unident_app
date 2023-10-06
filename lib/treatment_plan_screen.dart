import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color kDarkBlueColor = const Color(0xFF053149);
  final BoxShadow kDefaultBoxshadow = const BoxShadow(
    color: Color(0xFFDFDFDF),
    spreadRadius: 1,
    blurRadius: 10,
    offset: Offset(2, 2),
  );

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kDarkBlueColor,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 200,
              ),
              AppinioAnimatedToggleTab(
                duration: const Duration(milliseconds: 150),
                offset: 0,
                callback: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                tabTexts: const [
                  'make',
                  'your',
                  'tabs :)',
                ],
                height: 40,
                width: 300,
                boxDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    kDefaultBoxshadow,
                  ],
                ),
                animatedBoxDecoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFc3d2db).withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  color: kDarkBlueColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                activeStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                inactiveStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Text(
                'Current Index: $currentIndex',
                style: TextStyle(
                  fontSize: 20,
                  color: kDarkBlueColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
