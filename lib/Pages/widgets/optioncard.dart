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
    return GestureDetector(
      onTap: (){
        onTap(optionIndex);
        },
      child: Card(
        color: color,
        child: ListTile(
          title: Text(
            option,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0,color: Colors.white)
            ,
          ),
        ),
      ),
    );
  }
}