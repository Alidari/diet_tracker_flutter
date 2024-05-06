import 'package:flutter/material.dart';
import 'package:beslenme/Pages/screens/Quizz.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
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