import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GlisareImaginiScreen extends StatefulWidget {

  const GlisareImaginiScreen({super.key});

  @override
  State<GlisareImaginiScreen> createState() => _GlisareImaginiScreenState();

}

class _GlisareImaginiScreenState extends State<GlisareImaginiScreen> {
  
  //bool valueCheck = false;
  
  @override
  Widget build(BuildContext context) {
    
    //var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
    children: [
      CarouselSlider(
        items: [
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage('./assets/images/clinics/clinica_brasov_50.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage('./assets/images/clinics/clinica_buzau_50.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage('./assets/images/clinics/clinica_galati_50.jpg'),
                //image: NetworkImage("url"), old
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage('./assets/images/clinics/clinica_tulcea_50.jpg'),
                //image: NetworkImage("url"), old
                fit: BoxFit.cover,
              ),
            ),
          ),
        ], 
        options: CarouselOptions(
            height: 380.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),
    ]),
    );
  }
}
