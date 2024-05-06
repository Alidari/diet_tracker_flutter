import 'dart:math';
import 'dart:async';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/question.dart';
import 'package:beslenme/Pages/screens/Bitis.dart';





class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Question> _questions;
  int _score = 0;
  int _trueScore = 0;
  int _falseScore = 0;
  int _currentIndex = 0;
  int _currentTime = 90; // 1 dakikalık süre
  bool _isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _questions = [];
    _loadCSV();
    _startTimer();
  }

  Future<void> _loadCSV() async {
    try {
      final String csvString =
          await rootBundle.loadString('assets/dietTracker-1.csv');
      final List<List<dynamic>> csvTable = CsvToListConverter(
              eol: '\n', fieldDelimiter: ",")
          .convert(csvString);
      
      final int randomIndex = Random().nextInt(csvTable.length);
      final int randomIndex2=Random().nextInt(csvTable.length);
      final int index=Random().nextInt(2);
      final String foodName = csvTable[randomIndex][1];
      final String foodName2=csvTable[randomIndex2][1];
      final double kcal =
          double.parse(csvTable[randomIndex][2].toString());
      final double protein1=double.parse(csvTable[randomIndex][4].toString());
      final double protein2=double.parse(csvTable[randomIndex2][4].toString());
      final questionTitle1 = 'Yemeğin adı $foodName, 165 kcal\'den büyük veya eşit midir?';
      final options1 = {
        'A) Evet': kcal >= 165 ? true : false,
        'B) Hayır': kcal < 165 ? true : false,
      };
      final questionTitle2='$foodName ile $foodName2 yemeklerinden hangisinin proteini daha yüksek? ';
      final options2={
        'A) $foodName': protein1 >= protein2 ? true : false,
        'B) $foodName2': protein1 <= protein2 ? true : false,
      };

      setState(() {

        if(index==0){
        _questions.add(Question(
          
          id: _currentIndex.toString(),
          title: questionTitle1,
          options: options1,
        ));}
         if(index==1){
        _questions.add(Question(
          
          id: _currentIndex.toString(),
          title: questionTitle2,
          options: options2,
        ));}
        _isLoading = false;
      });
    } catch (e) {
      print('Hata: $e');
      setState(() {
        _isLoading = false; // Hata durumunda da yüklemeyi durdur
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTime > 0) {
          _currentTime--;
        } else {
          _timer.cancel();
          _finishQuiz();
        }
      });
    });
  }

  void _finishQuiz() {
    
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => FinishScreen(
        Sorusayisi: _currentIndex,
        trueScore: _trueScore,
        falseScore: _falseScore,
        score: _score,
      ),
    ),
  );

  }

  void _nextQuestion() {
    setState(() {
      _currentIndex++;
    });
  }

  void _answerQuestion(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        _trueScore++;
        _score += 100; // Doğru cevap için 100 puan ekle
      } else {
        _falseScore++;
        _score -= 60; // Yanlış cevap için 60 puan çıkar
      }
    });

    _nextQuestion();
    _loadCSV(); // Her cevaplandıktan sonra yeni bir soru yükle
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.grey[200],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue[500], // Koyu mavi arka plan rengi
        ),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Text(
              'Kalan Süre: $_currentTime saniye',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.check, color: Colors.green),
                    SizedBox(height: 4.0),
                    Text('Doğru: $_trueScore', style: TextStyle(fontSize: 16.0, color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.close, color: Colors.red),
                    SizedBox(height: 4.0),
                    Text('Yanlış: $_falseScore', style: TextStyle(fontSize: 16.0, color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.score, color: Colors.yellow),
                    SizedBox(height: 4.0),
                    Text('Skor: $_score', style: TextStyle(fontSize: 16.0, color: Colors.white)),
                  ],
                ),
              ],
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _questions.isEmpty
                      ? Center(child: Text('Sorular yükleniyor...'))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen[100],
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   
                                    Text(
                                      _questions[_currentIndex].title,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    SizedBox(height: 20.0),
                                    ..._questions[_currentIndex]
                                        .options
                                        .entries
                                        .map((option) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 3,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          title: Text(option.key),
                                          onTap: () =>
                                              _answerQuestion(option.value),
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            ElevatedButton(
                              onPressed: _finishQuiz,
                              child: Text('Bitir'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightGreen[100], // Buton rengi
                                textStyle: TextStyle(fontSize: 20), // Buton yazı stili
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Buton içi boşluk
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Butonun kenarlığının şekli
                              ),
                            ),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}