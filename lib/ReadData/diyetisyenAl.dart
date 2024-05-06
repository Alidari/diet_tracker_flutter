import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class DiyetisYenAl extends StatelessWidget {
  final String userId;
  final String kosul;
  final Function(Map) onTap;
  final Function (String) onTapMevcutDegil;

  DiyetisYenAl({required this.userId,required this.kosul,required this.onTap,required this.onTapMevcutDegil});

  List<dynamic> mevcutDiyetisyenKontrol = [];

  @override
  Widget build(BuildContext context) {

    //get the collection
    final ref = FirebaseDatabase.instance.ref();


    return FutureBuilder(
      future: ref.child("bilgitbl").get(),
      builder: ((context,snapshot) {
        final newRef = ref.child("relationships");
        return FutureBuilder(
            future: newRef.once(),
            builder: (context, eventSnapshot){
              if(snapshot.connectionState == ConnectionState.done) {
                Map diyetistenData = eventSnapshot.data!.snapshot.value as Map;
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


          List<dynamic> diyetisyenlerMevcut = [];
          List<dynamic> mevcutOlmayandiyetisyenler = [];
          List<String> mevcutOlmayanKey = [];
          List<String> mevcutKey = [];
          Map diyetisyen = snapshot.data!.value as Map;

          int i = 0;
          //MEVCUT OLMAYAN DİYETİSYEN ATAMASI
          diyetisyen.forEach((key, value) {


            int control = 0;
              mevcutDiyetisyenKontrol.forEach((element) {

                if(element == key) control = 1;
                print("AŞAMA: $i , Kontrol edilen elemanlar a:$element b:$key, kontrol değişkeni: $control");
                i++;
              });
              if(control != 1){
                mevcutOlmayandiyetisyenler.add(value);
                mevcutOlmayanKey.add(key);
              }
              else{
                print("KONTROL DEĞİŞKENİ 1 OLDUĞU İÇİN $key değerli atandı");
                diyetisyenlerMevcut.add(value);
                mevcutKey.add(key);
              }
          });
          if(diyetisyen != null && kosul == "mevcut" && diyetisyenlerMevcut.length != 0) {
            print("Mevcut Diyetisyenler: " + diyetisyenlerMevcut.toString());
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //MEVCUT OLAN DİYETSYENLER LİSTESİ --------------------
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color:Colors.grey),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          for(int i=0;i<diyetisyenlerMevcut.length;i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                              child: Icon(Icons.person,size: 20,),
                            ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for(int i=0;i<diyetisyenlerMevcut.length;i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                              child: Text(diyetisyenlerMevcut[i]["ad"] + " " + diyetisyenlerMevcut[i]["soyad"]),
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          for(int i=0;i<diyetisyenlerMevcut.length;i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                              child: Text(diyetisyenlerMevcut[i]["ucret"]),
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          for(int i=0;i<diyetisyenlerMevcut.length;i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0),
                              child: MaterialButton(
                                minWidth: 5, // minimum genişlik
                                height: 10,
                                padding: EdgeInsets.all(1), // padding ayarı
                                onPressed: (){
                                  onTap(diyetisyenlerMevcut[i]);
                                },
                                child: Text("Detay",style: TextStyle(fontSize: 15),),
                                color: Colors.green,
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            );
          }
          else if(diyetisyen != null && kosul == "mevcut degil" && mevcutOlmayandiyetisyenler.length != 0){
            print("Mevcut Olmayan Diyetisyenler: " + mevcutOlmayandiyetisyenler.toString());
            return Container(
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  border: Border.all(color:Colors.grey),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      for(int i=0;i<mevcutOlmayandiyetisyenler.length;i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                          child: Icon(Icons.person),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      for(int i=0;i<mevcutOlmayandiyetisyenler.length;i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                          child: Text(mevcutOlmayandiyetisyenler[i]["ad"] + " " + mevcutOlmayandiyetisyenler[i]["soyad"]),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      for(int i=0;i<mevcutOlmayandiyetisyenler.length;i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                          child: Text(mevcutOlmayandiyetisyenler[i]["ucret"]),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      for(int i=0;i<mevcutOlmayandiyetisyenler.length;i++)
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: MaterialButton(
                            minWidth: 5, // minimum genişlik
                            height: 20,
                            padding: EdgeInsets.all(1),
                            onPressed: (){
                              onTapMevcutDegil(mevcutOlmayanKey[i]);
                            },
                            child: Icon(Icons.add,size: 20,),
                            color: Colors.green,
                          ),
                        )
                    ],
                  ),
                ],
              ),
            );
          }
          else{
            return Container(
                decoration : BoxDecoration(
                    border: Border.all(color:Colors.grey),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 7),
                  child: Text("Herhangi bir diyetisyen bulunamadı.."),
                ));
          }
        }
        return CircularProgressIndicator();
      }

      );
      })
    );

  }
}

