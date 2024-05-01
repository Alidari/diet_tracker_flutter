import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class DiyetisYenAl extends StatelessWidget {
  final String userId;
  final String kosul;
  final Function(String) onTap;

  DiyetisYenAl({required this.userId,required this.kosul,required this.onTap});

  List<dynamic> mevcutDiyetisyenKontrol = [];

  @override
  Widget build(BuildContext context) {

    //get the collection
    final ref = FirebaseDatabase.instance.ref();


    return FutureBuilder(
      future: ref.child("bilgitbl").get(),
      builder: ((context,snapshot) {

        final newRef = ref.child("relationships");

        Future<DatabaseEvent> event = newRef.once();
        Map diyetistenData;
        event.then((value) => {

          diyetistenData = value.snapshot.value as Map,
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
              print(mevcutDiyetisyenKontrol);
            }
          }),
        });

        if(snapshot.connectionState == ConnectionState.done) {
          List<dynamic> diyetisyenlerMevcut = [];
          List<dynamic> mevcutOlmayandiyetisyenler = [];
          List<String> mevcutOlmayanKey = [];
          List<String> mevcutKey = [];
          Map diyetisyen = snapshot.data!.value as Map;


          //MEVCUT OLMAYAN DİYETİSYEN ATAMASI
          diyetisyen.forEach((key, value) {

            int control = 0;
            if(mevcutDiyetisyenKontrol.length != 0){


              mevcutDiyetisyenKontrol.forEach((element) {
                if(element == key) control = 1;
              });
              if(control != 1){
                mevcutOlmayandiyetisyenler.add(value);
                mevcutOlmayanKey.add(key);
              }
              else{
                diyetisyenlerMevcut.add(value);
                mevcutKey.add(key);
              }
            }
            else{
              mevcutOlmayandiyetisyenler.add(value);
              mevcutOlmayanKey.add(key);
            }





          });
          if(diyetisyen != null && kosul == "mevcut") {
            return Column(
              children: [
                //MEVCUT OLAN DİYETSYENLER LİSTESİ --------------------
                Container(
                  margin: EdgeInsets.all(12),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.person),
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          for(int i=0;i<diyetisyenlerMevcut.length;i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(diyetisyenlerMevcut[i]["ad"] + " " + diyetisyenlerMevcut[i]["soyad"]),
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          for(int i=0;i<diyetisyenlerMevcut.length;i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(diyetisyenlerMevcut[i]["ucret"]),
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          for(int i=0;i<diyetisyenlerMevcut.length;i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                onPressed: (){
                                  onTap(mevcutKey[i]);
                                },
                                child: Text("Görüntüle"),
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
          else if(diyetisyen != null && kosul == "mevcut degil"){
            return Container(
              margin: EdgeInsets.all(12),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.person),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      for(int i=0;i<mevcutOlmayandiyetisyenler.length;i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(mevcutOlmayandiyetisyenler[i]["ad"] + " " + mevcutOlmayandiyetisyenler[i]["soyad"]),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      for(int i=0;i<mevcutOlmayandiyetisyenler.length;i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(mevcutOlmayandiyetisyenler[i]["ucret"]),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      for(int i=0;i<mevcutOlmayandiyetisyenler.length;i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            onPressed: (){
                              onTap(mevcutOlmayanKey[i]);
                            },
                            child: Icon(Icons.add),
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
            return Text("Herhangi bir diyetisyen bulunamadı..");
          }
        }
        return Text("Yükleniyor...");
      }
      ),
    );

  }
}

