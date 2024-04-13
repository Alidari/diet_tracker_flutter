import 'package:flutter/material.dart';



class VucutKitleIndeksi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(

        appBar: AppBar(
          backgroundColor: Color(0xFFE7E7E7),
          centerTitle: true,
          title: Text('Vücut Kitle İndeksi'),
           leading: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Ana sayfaya geri dönme işlemi
          },
          child:  Icon(Icons.arrow_back_ios,),
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.transparent,
               elevation: 0,
               shadowColor: Colors.transparent,
               padding: EdgeInsets.only(right: 0.1)
             ), // Geri butonu ikonu
        ),
        ),
        body:BMICalculator(),
        
        
      ),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmiResult = 0.0;
  String bmiResultClassification = "";
  Color? bmiColor = Colors.black;

  void calculateBMI() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100.0; // Convert height from cm to m
    double bmi = weight / (height * height);

    if(bmi < 18.5){
      bmiResultClassification = " (Çok Zayıf)";
      bmiColor = Colors.lightBlue;
    }
    else if(bmi < 25){
      bmiResultClassification = " (Normal Kilo)";
      bmiColor = Colors.green;
    }
    else if(bmi < 30){
      bmiResultClassification = " (Kilolu)";
      bmiColor = Colors.amber;
    }
    else if(bmi < 35){
      bmiResultClassification = " (1. Sınıf Obezite!)";
      bmiColor = Colors.orange[600];
    }
    else if(bmi < 40){
      bmiResultClassification = " (2. Sınıf Obezite!)";
      bmiColor = Colors.orange[900];
    }
    else if(bmi >= 40){
      bmiResultClassification = " (3. Sınıf Obezite!)";
      bmiColor = Colors.red[600];
    }
    setState(() {
      bmiResult = bmi;

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFE7E7E7),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                  border: Border.all(color: Colors.black45,width: 1),
                  borderRadius: BorderRadius.circular(12)
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(

                  labelText: 'Weight (kg)',

                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(color: Colors.black45,width: 1),
                  borderRadius: BorderRadius.circular(12)
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                ),
              ),
            ),
            SizedBox(height: 16),
           ElevatedButton(
            onPressed: calculateBMI,
            style: ElevatedButton.styleFrom(
              backgroundColor:  Colors.green[900], // Koyu yeşil arka plan
            ),
            child: Text(
              'Hesapla',
              style: TextStyle(
                color: Colors.white, // Beyaz yazı
              ),
            ),
          ),
            SizedBox(height: 16),
            Text(
              'BMI: ${bmiResult.toStringAsFixed(1)  + bmiResultClassification}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: bmiColor
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Image.asset(
                'assets/vucutkitleindeksi.png',
                width: 1000, // Resim genişliği
                height: 300, // Resim yüksekliği
              ),
            ),
          ],
        ),
      ),
    );
  }
}