import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.question,
    required this.indexAction,
    required this.totalQuestions,
    required this.image,
  }) : super(key: key);

  final Image image;
  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200, // Resmin genişliğini burada belirleyin
          height: 200, // Resmin yüksekliğini burada belirleyin
          child: image,
        ),// Resmi burada gösterin
        const SizedBox(height: 25.0),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
              textAlign: TextAlign.center,
              'Question ${indexAction + 1}/$totalQuestions: $question',
              style: GoogleFonts.aBeeZee(fontSize: 20.0, color: neutralText,),
          ),
        ),
      ],
    );
  }
}
