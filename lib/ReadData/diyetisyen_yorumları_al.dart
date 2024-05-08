import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DiyetisyenYorumAl extends StatefulWidget {
  final String diyetisyenId;
  const DiyetisyenYorumAl({Key? key,required this.diyetisyenId}) : super(key: key);

  @override
  State<DiyetisyenYorumAl> createState() => _DiyetisyenYorumAlState();
}

class _DiyetisyenYorumAlState extends State<DiyetisyenYorumAl> {

  final ref = FirebaseDatabase.instance.ref("reviews");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.child(widget.diyetisyenId).get(),
      builder: ((context,snapshot) {

        List<dynamic> yorumlar = [];

        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasData && snapshot.data!.value != null) {
            Map data = snapshot.data!.value as Map;
            data.forEach((key, value) {
              yorumlar.add(value);
            });
            print(yorumlar);
            return Container(
              child: Column(
                children: [
                  for(int i = 0; i< yorumlar.length;i++)
                  Row(
                    children: [
                        Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/defaultProfilPicture.png"),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(yorumlar[i]["Hasta"],style: TextStyle(color:Colors.blue),textAlign: TextAlign.start,),
                                Text("Puan: " + yorumlar[i]["Puan"],style: TextStyle(color:Colors.black.withOpacity(0.5),fontSize: 12),)
                              ],
                            ),
                          ),

                          Container(
                              width: 200,
                              child: Text(yorumlar[i]["Yorum"])),
                          SizedBox(height: 20,),
                        ],

                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          else{
            return Text("");
          }
        }
        else return Text("");
      }
      ),
    );
  }
}
