import 'package:flutter/material.dart';


class FoodDetails extends StatelessWidget {
  final String foodName;
  final double? energy;
  final double? carbohydrate;
  final double? protein;
  final double? totalFat;
  final double? water;
  final double? sugars;
  final double? calcium;
  final double? iron;
  final double? magnesium;
  final double? potassium;
  final double? sodium;
  final String url;
  final String altUrl;

  const FoodDetails({Key? key
    ,required this.foodName,required this.energy,required this.carbohydrate,required this.protein,required this.totalFat
    ,required this.water,required this.sugars,required this.calcium,required this.iron,required this.magnesium,
    required this.potassium, required this.sodium,required this.url,required this.altUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double total = carbohydrate! + totalFat!+ protein!;

    final double percentCar = carbohydrate!/total * 100 ;
    final double percentFat = totalFat!/total * 100 ;
    final double percentPro = protein!/total * 100 ;

    String selectedOptionPorsiyon = 'Porsiyon (Orta)'; // Başlangıçta orta seçeneği seçili
    List<String> optionsPorsiyon = ['Porsiyon (Büyük)', 'Porsiyon (Orta)', 'Porsiyon (Küçük)']; // Seçenekler listesi



    return Scaffold(appBar:
    AppBar(
      title: Text(foodName),

    ),
    body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 200,
              child: Image.network(
                url,
                loadingBuilder: (context, child, loadingProgress){
                  if (loadingProgress == null) return child;
                  if(loadingProgress.cumulativeBytesLoaded == 0){
                    return CircularProgressIndicator(); // Yükleme sırasında gösterilecek ilerleme çubuğu
                  }
                  else{
                    return Image.network(
                      altUrl,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child; // Yükleme tamamlandıysa resmi göster
                        return CircularProgressIndicator(); // Alternatif URL yükleme sırasında gösterilecek ilerleme çubuğu
                      },
                      errorBuilder: (context, error, stackTrace) {
                        // Alternatif URL yüklenirken hata olursa
                        return Text('Resim yüklenirken bir hata oluştu: $error');
                      },

                    );

                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  // Alternatif URL yüklenirken hata olursa
                  return Text('Resim yüklenirken bir hata oluştu: $error');
                },
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all()
                  ),
                  child: DropdownButton<String>(
                    value: selectedOptionPorsiyon,
                    onChanged: (String? newValue){
                      selectedOptionPorsiyon = newValue!;
                    },
                    items: optionsPorsiyon.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 25,),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all()
                  ),
                  child: DropdownButton<String>(
                    value: selectedOptionPorsiyon,
                    onChanged: (String? newValue){
                      selectedOptionPorsiyon = newValue!;
                    },
                    items: optionsPorsiyon.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(decoration: TextDecoration.none)), // Altı çiziliği kaldırmak için TextDecoration.none kullanılır,
                      );
                    }).toList(),
                    style: TextStyle(decoration: TextDecoration.none),
                  ),
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Karbonhidrat
            Column(
              children: [
                Text("Karbonhidrat"),
                Text(carbohydrate.toString()),
                Text("%"+percentCar.toStringAsFixed(2))
              ],
            ),
            //Yağ
            Column(
              children: [
                Text("Yağ"),
                Text(totalFat.toString()),
                Text("%"+percentFat.toStringAsFixed(2))
              ],
            ),

            //Protein
            Column(
              children: [
                Text("Protein"),
                Text(protein.toString()),
                Text("%"+percentPro.toStringAsFixed(2))
              ],
            ),
          ],
        )
      ],
    ) ,
    );
  }
}

