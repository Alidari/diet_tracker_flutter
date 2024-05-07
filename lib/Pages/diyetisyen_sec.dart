import 'package:beslenme/ReadData/diyetisyenAl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'diyetisyen_sayfası.dart';

class diyetisyenSec extends StatefulWidget {

  const diyetisyenSec({Key? key}) : super(key: key);

  @override
  State<diyetisyenSec> createState() => _diyetisyenSecState();

}

class _diyetisyenSecState extends State<diyetisyenSec> {

  final user = FirebaseAuth.instance.currentUser!;
  final ref = FirebaseDatabase.instance.ref("relationships");

  late String userId;

  List<String> mevcutDiyetisyenler = [];


  void diyetisyenEkle(String key){
    final addingRef = ref.child("$key/$userId");

    setState(() {
      addingRef.set({
        "id" : userId,
        "durum" : "etkin"
      });
    });
  }
  void diyetisyenGoruntule(Map diyetisyen,String diyetisyenId){
    Navigator.push(
        context,
      MaterialPageRoute(builder: (context) => DiyetisyenSayfa(diyetisyen: diyetisyen,diyetisyenID: diyetisyenId))
    );
  }

  @override
  void initState() {
    userId = user.uid;
    super.initState();
    setState(() {
    });
    FetchData();
  }

  Future<void> FetchData() async {
    final newRef = ref.child("relationships");
    DatabaseEvent event = await newRef.once();
    Map diyetistenData = event.snapshot.value as Map;

    diyetistenData.forEach((key, value) {

      int control = 0;
      Map kullanicilar = value as Map;
      kullanicilar.forEach((key, value) {
        if(key == userId){
          control = 1;
        }
      });
      if(control == 1){
        mevcutDiyetisyenler.add(key);
        print("Mevcut Diyetisyenler: " + mevcutDiyetisyenler.toString());
      }
      //Ekranı yenilemesi için
      setState((){});

    });




  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Diyetisyenlerimiz"),
        centerTitle: true,
      ),
      body:


      Container(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            children: [
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: SearchAnchor(
                          builder: (BuildContext context, SearchController controller) {
                          return SearchBar(
                            controller: controller,
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 16.0)),
                            onTap: () {
                              controller.openView();
                            },
                            onChanged: (_) {
                              controller.openView();
                            },
                            leading: const Icon(Icons.search),

                          );
                          },
                          suggestionsBuilder: (BuildContext context, SearchController controller) {
                            return List<ListTile>.generate(5, (int index) {
                              final String item = 'Diyetisyen $index';
                              return ListTile(
                                title: Text(item),
                                onTap: () {
                                  setState(() {
                                    controller.closeView(item);
                                  });
                                },
                              );
                            });
                          }
                      ),
                    ),

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Fotoğraf",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("Diyetisyen İsmi",style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("Puan",style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("Seç",style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Column(

                            children: [
                              DiyetisYenAl(userId: userId,kosul: "mevcut",onTap: diyetisyenGoruntule,onTapMevcutDegil: diyetisyenEkle,),
                              SizedBox(height: 20,),
                              Text("Yeni Diyetisyenler Ekle",
                                style: GoogleFonts.caveat(
                                  fontSize : 24
                                )
                              ),
                              SizedBox(height: 20,),
                              DiyetisYenAl(userId: userId,kosul: "mevcut degil",onTap: diyetisyenGoruntule,onTapMevcutDegil: diyetisyenEkle),
                            ],
                          ),

                        )
                      ],

                    ),



                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}



