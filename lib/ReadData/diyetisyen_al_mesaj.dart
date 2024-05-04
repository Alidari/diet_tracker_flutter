import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class DiyetisYenAlMesaj extends StatelessWidget {
  final String userId;
  final Function(String,String,String) onTap;

  DiyetisYenAlMesaj({required this.userId,required this.onTap});

  List<dynamic> mevcutDiyetisyenKontrol = [];

  @override
  Widget build(BuildContext context) {

    //get the collection
    final ref = FirebaseDatabase.instance.ref();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return FutureBuilder(
        future: ref.child("bilgitbl").get(),
        builder: ((context,snapshot) {
          final newRef = ref.child("relationships");
          return FutureBuilder(
              future: newRef.once(),
              builder: (context, eventSnapshot){
                if(snapshot.connectionState == ConnectionState.done) {
                  Map diyetistenData;
                  if(eventSnapshot.hasData) {
                    diyetistenData = eventSnapshot.data!.snapshot
                        .value as Map;

                    diyetistenData.forEach((key, value) {

                      int control = 0;
                      Map kullanicilar = value as Map;
                      kullanicilar.forEach((key, value) {
                        if(key == userId){
                          control = 1;
                        }
                      });
                      if(control == 1){
                        mevcutDiyetisyenKontrol.add(key);
                      }
                    });
                  }



                  List<dynamic> diyetisyenlerMevcut = [];
                  List<String> mevcutKey = [];
                  Map diyetisyen = snapshot.data!.value as Map;

                  //MEVCUT OLAN DİYETİSYEN ATAMASI
                  diyetisyen.forEach((key, value) {


                    int control = 0;
                    mevcutDiyetisyenKontrol.forEach((element) {

                      if(element == key) control = 1;
                    });

                    if(control == 1){
                      diyetisyenlerMevcut.add(value);
                      mevcutKey.add(key);
                    }
                  });
                  
                  if(diyetisyenlerMevcut.length != 0){
                    return Column(
                      children: [
                        for(int i = 0; i<diyetisyenlerMevcut.length;i++)
                          Container(
                            width: screenWidth,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2.0, color: Colors.black.withOpacity(0.5)),
                              ),
                            ),
                            margin: EdgeInsets.symmetric(),
                            child: MaterialButton(
                              child: Row(
                                children: [
                                  Text(diyetisyenlerMevcut[i]["ad"] + " " + diyetisyenlerMevcut[i]["soyad"])
                                ],
                              ),
                              onPressed: (){
                                onTap(mevcutKey[i],diyetisyenlerMevcut[i]["ad"],diyetisyenlerMevcut[i]["soyad"]);
                              },
                            ),
                          )
                      ],
                    );
                  }
                  
                }
                return CircularProgressIndicator();
              }

          );
        })
    );

  }
}

