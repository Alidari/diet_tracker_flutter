import 'package:beslenme/ReadData/get_user_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beslenme/Pages/screens/Quizz.dart';

// ignore: must_be_immutable
class QuizStartScreen extends StatelessWidget {

  final user = FirebaseAuth.instance.currentUser!;
  late String docId;

  QuizStartScreen({super.key});
  Future getDocId() async {
    docId = user.uid;
  }
  @override
  Widget build(BuildContext context) {
     getDocId(); 
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Bilgilendirilmesi'),
        backgroundColor: Colors.grey[200],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue[500],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sınava hoş geldiniz!',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    'Bu quizde her doğru yaptığınızda 100 puan kazanırken, yanlış yaptığınızda 60 puan ceza alırsınız.',
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.0),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10.0),
                  
                  ),
                  
                  child:  const Text('En güncel skorunuz:', style: TextStyle(fontSize: 18.0)),

                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10.0),

                  ),
                  
                  child:  GetUserName(documentId: docId,feature: 'score',styl: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black.withOpacity(0.7),
                                            fontSize: 25,
                                            fontFamily: "Arial"
                                        ))

                ),
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizHomeScreen()),
                    );
                  },
                  child: const Text('Başla', style: TextStyle(fontSize: 18.0)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Buton rengi
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0), // Buton içi boşluk
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Butonun kenarlığının şekli
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}