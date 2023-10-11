import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';


class FeedbackScreen extends StatefulWidget {
  
/*
  
  final String iconPath;
  final String textNume;
  final String textRating;
  final String textComentariu;
  final String textData;

  const FeedbackScreen({super.key, required this.iconPath, required this.textNume, required this.textRating, required this.textComentariu, required this.textData});
  
  */

  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreen();

}

class _FeedbackScreen extends State<FeedbackScreen> {
  
  int? _ratingValue = 1;

  final controllerFeedbackText = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    
    controllerFeedbackText.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context), 
                    icon: const Icon(Icons.arrow_back_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 110),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Te rugăm să ne lași si un feedback!',
                      style: GoogleFonts.rubik(color: const Color.fromRGBO(103, 114, 148, 1), fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  RatingBar(
                    //ignoreGestures: true,
                    initialRating: 0.0,
                    minRating: 1.0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 45,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 5.0),
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Color.fromRGBO(195, 161, 110, 1)),
                      half: const Icon(
                        Icons.star_half,
                        color: Color.fromRGBO(252, 220, 85, 1),
                      ),
                      empty: const Icon(
                        Icons.star_outline,
                        color: Color.fromRGBO(195, 161, 110, 1),
                      )),
                      
                    onRatingUpdate: (value) {
                      setState(() {
                        _ratingValue = value.toInt();
                      });
                    }
                  ),
                ],  
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 240, 240, 240),
                ),
                height: 130,
                child: TextField(
                  controller: controllerFeedbackText,
                  style: const TextStyle(color: Color.fromRGBO(103, 114, 148, 1)), //added by George Valentin Iordache
                  //decoration: InputDecoration(border: InputBorder.none, hintText: 'Doctorul a raspuns rapid...'),
                  decoration: const InputDecoration(border: InputBorder.none, 
                    hintText: 'Doctorul a raspuns rapid...',
                    hintStyle: TextStyle(color: Color.fromRGBO(103, 114, 148, 1), fontSize: 14, fontWeight: FontWeight.w300), //added by George Valentin Iordache 
                  ),
                  maxLines: 2,
                )
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    if (_ratingValue != 0)
                    {
                    /*  
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // Retrieve the text that the user has entered by using the
                            // TextEditingController.
                            content: Text('Feedback: ' + _ratingValue!.toString() + ' mesaj: ' + controllerFeedbackText.text),
                          );
                        },
                      );
                      */
                      print( 'Feedback: ' + _ratingValue!.toString() + ' mesaj: ' + controllerFeedbackText.text);
                      return const FeedbackScreen();
                    }
                    else { 
                      return const FeedbackScreen();
                    }  
                  },
                )),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: Colors.green, old
                    color: const Color.fromRGBO(57, 52, 118, 1)
                  ),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        //' TRIMITE CHESTIONARUL', old
                        // style: GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18), old
                        'TRIMITE FEEDBACK',
                        style: GoogleFonts.rubik(color: const Color.fromRGBO(195, 161, 110, 1), fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
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
}
