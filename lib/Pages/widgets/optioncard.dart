import 'package:flutter/material.dart';


class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    required this.option,
    required this.color,
    required this.onTap,
    required this.optionIndex
  }) : super(key: key);

  final String option;
  final Color color;
  final Function(int) onTap;
  final optionIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12)
      ),
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: (){
          onTap(optionIndex);
          },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                option,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17.0,color: Colors.white)
                ,
              ),
          ],
        ),

      ),
    );
  }
}