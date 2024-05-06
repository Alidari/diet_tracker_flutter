import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:beslenme/Pages/home_page.dart';

class FinishScreen extends StatelessWidget {
  final int Sorusayisi;
  final int trueScore;
  final int falseScore;
  final int score;

  const FinishScreen({
    Key? key,
    required this.Sorusayisi,
    required this.trueScore,
    required this.falseScore,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Sonucu'),
        backgroundColor: Colors.grey[200],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.lightGreen[500]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Quiz Bitti!',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                _buildScoreText('Toplam Soru: $Sorusayisi'),
                SizedBox(height: 10.0),
                _buildScoreText('Toplam Doğru: $trueScore'),
                SizedBox(height: 10.0),
                _buildScoreText('Toplam Yanlış: $falseScore'),
                SizedBox(height: 10.0),
                _buildScoreText('Toplam Puan: $score'),
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()), // Ana ekrana dön
                        );
                      },
                      child: Text('Ana ekrana dön'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue[200], // Buton rengi
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0), // Buton içi boşluk
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Butonun kenarlığının şekli
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        saveScoreToFirebase(context, score);
                      },
                      child: Text('Kaydet'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue[200], // Buton rengi
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0), // Buton içi boşluk
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Butonun kenarlığının şekli
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreText(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  void saveScoreToFirebase(BuildContext context, int score) async {
    try {
      // Firebase veritabanı referansını al
      DatabaseReference dbRef = FirebaseDatabase.instance.reference();

      // Kullanıcının kimlik bilgilerini al
      String userId = FirebaseAuth.instance.currentUser!.uid;
      if(score<0){
           await dbRef.child('users').child(userId).update({
        
        'score': 0
      });
      }
      // Skoru users altındaki userId altına kaydet
      else{
      await dbRef.child('users').child(userId).update({
        
        'score': score
      });}

      // Başarıyla kaydedildiğine dair mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Skor başarıyla kaydedildi!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      // Hata durumunda hata mesajını göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hata: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}