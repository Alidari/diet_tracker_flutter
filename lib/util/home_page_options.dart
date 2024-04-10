import 'package:flutter/material.dart';

class HomeOptions extends StatelessWidget {

  final String imagePath;
  final String title;
  final String subText;

  HomeOptions({
    required this.imagePath,
    required this.title,
    required this.subText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0,right: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        width: 175,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.green),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(imagePath),
            Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            SizedBox(height: 15,),
            GestureDetector(

                onTap: (){},
                child: Container(

                  decoration: BoxDecoration(color: Colors.green[300],borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(subText,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color:Colors.white ,)
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
