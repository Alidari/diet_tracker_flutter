import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MesajAl extends StatelessWidget {
  final String userId;
  final String message_with;

  MesajAl({required this.userId,required this.message_with});

  List<dynamic> mevcutDiyetisyenKontrol = [];

  @override
  Widget build(BuildContext context) {

    //get the collection
    final ref = FirebaseDatabase.instance.ref("mesaj");
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return FutureBuilder(
        future: ref.child("$userId/$message_with").get(),
        builder: ((context,snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  Map messageList = {};
                  Map MessagesData;
                  if(snapshot.hasData){
                    MessagesData = snapshot.data!.value as Map;

                    MessagesData.forEach((key, value) {
                      messageList[key] = value;
                    });
                  }

                  messageList.forEach((key, value) {
                    print(value["mesaj"]);
                  });

                if(messageList.isNotEmpty){
                 return ListView.builder(
                  itemCount: messageList.length,
                   itemBuilder: (BuildContext context, int index) {
                    var values = messageList.values.toList();
                    var mesaj = values[index]["mesaj"];
                    var alici = values[index]["alici"];
                    var gonderen = values[index]["gonderen"];
                    var tarih = values[index]["tarih"];

                    return Row(
                      mainAxisAlignment: (gonderen == userId) ? MainAxisAlignment.end : MainAxisAlignment.start ,
                      children: [
                        Container(
                          margin: EdgeInsets.all(2),
                          constraints: BoxConstraints(// Minimum genişlik
                            maxWidth: 150, // Maksimum genişlik
                          ),
                          decoration: BoxDecoration(
                            color: (gonderen == userId) ? Colors.green : Colors.blueGrey[900],
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Text(mesaj,style: TextStyle(color: Colors.white.withOpacity(0.9)),),
                          ),
                        ),
                      ],
                    );

                   },
                 );
                }
                else{
                  return Text("Henüz Hiç Mesaj Yok");
                }

                }
                return Text("");
              }
        )
          );
        }
      }


