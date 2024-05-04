import 'package:flutter/cupertino.dart';
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

  const FoodDetails({Key? key
    ,required this.foodName,required this.energy,required this.carbohydrate,required this.protein,required this.totalFat
    ,required this.water,required this.sugars,required this.calcium,required this.iron,required this.magnesium, required this.potassium, required this.sodium

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {




    final double total = carbohydrate! + totalFat!+ protein!;

    final double percentCar = carbohydrate!/total * 100 ;
    final double percentFat = totalFat!/total * 100 ;
    final double percentPro = protein!/total * 100 ;

    return Scaffold(appBar:
    AppBar(
      title: Text(foodName),

    ),
    body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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

