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
    final ref = FirebaseDatabase.instance.ref("mesaj/$userId/$message_with");
    
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return FutureBuilder(
        future: ref.get(),
        builder: ((context,snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  Map messageList = {};
                  Map MessagesData;

                  if(snapshot.hasData && snapshot.data!.value != null){
                    MessagesData = snapshot.data!.value as Map;



                    List<MapEntry> entries = MessagesData.entries.toList();
                    entries.sort((a, b) => (b.value['tarih'] as int).compareTo(a.value['tarih'] as int));
                    Map<String, Map> sortedMap = {};

                    print("AAAA: " + entries.toString());
                    for (var entry in entries) {
                      sortedMap[entry.key] = entry.value;
                    }

                    MessagesData = sortedMap;
                    MessagesData.forEach((key, value) {

                      messageList[key] = value;
                    });
                  }


                if(messageList.isNotEmpty){
                 return ListView.builder(
                   reverse: true,
                  itemCount: messageList.length,
                   itemBuilder: (BuildContext context, int index) {
                    var values = messageList.values.toList();
                    var mesaj = values[index]["mesaj"];
                    var alici = values[index]["alici"];
                    var gonderen = values[index]["gonderen"];
                    var tarih = values[index]["tarih"];
                    var saat = DateTime.fromMillisecondsSinceEpoch(tarih * 1000).hour;
                    var dakika = DateTime.fromMillisecondsSinceEpoch(tarih * 1000).minute;
                    var tarihDate = DateTime.fromMillisecondsSinceEpoch(tarih * 1000);

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
                            child: Column(
                              children: [
                                Text(mesaj,style: TextStyle(color: Colors.white.withOpacity(0.9)),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );

                   },
                 );
                }
                else{
                  return Center(child: Text("Henüz Hiç Mesaj Yok"));
                }

                }
                return Text("");
              }
        )
          );
        }
      }


