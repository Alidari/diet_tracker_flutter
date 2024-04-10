import 'package:beslenme/ReadData/get_user_names.dart';
import 'package:beslenme/util/home_page_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  late String docId;

  Future getDocId() async {
    docId = user.uid;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.menu),
       actions: [
         /*Padding(
           padding: const EdgeInsets.only(right: 20.0),
           child: Icon(Icons.person),
         ),*/
         GestureDetector(
             onTap: (){
               FirebaseAuth.instance.signOut();
             },
             child: Icon(Icons.logout)),
       ],
       /* backgroundColor: Colors.green,
        title:  Text(
          user.email!,style: TextStyle(fontSize: 16),textAlign: TextAlign.center,
        ),
        actions: [
          GestureDetector(
              onTap: (){
                FirebaseAuth.instance.signOut();
              },
              child: Icon(Icons.logout)),

        ],
      */),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.face),
          label: "",
        ),
      ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: FutureBuilder(
              future: getDocId(),
              builder: (context,snapshot){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      CircleAvatar(
                        backgroundColor: Colors.green[50],
                        radius: 50,
                        child: Icon(
                          Icons.face,
                          size: 70,
                        ),
                      ),

                      SizedBox(
                        height: 50,
                      ),


                      Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("İsim: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                      GetUserName(documentId: docId,feature: "name"),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 7,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Kilo: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                      GetUserName(documentId: docId,feature: "weight"),
                                    ],
                                  ),
                                ],
                              ),



                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Soy İsim: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                      GetUserName(documentId: docId,feature: "lastname"),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 7,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Yaş: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                      GetUserName(documentId: docId,feature: "age"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 70,
                      ),



                      //----------BUTONLAR---------------

                      Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                        children: [
                          HomeOptions(
                              imagePath: "assets/dietisyen.png",
                              title: "Diyetisyenlerimiz",
                              subText: "Diyetisyen Seç"
                          ),
                          HomeOptions(
                              imagePath: "assets/bmi.png",
                              title: "Vücut Kitle İndeksi",
                              subText: "Hesapla"
                          ),
                          HomeOptions(
                              imagePath: "assets/list.png",
                              title: "Diyet Listem",
                              subText: "Görüntüle"
                          ),
                          HomeOptions(
                              imagePath: "assets/quiz.png",
                              title: "Günlük Quiz",
                              subText: "Cevapla"
                          ),
                          HomeOptions(
                              imagePath: "assets/food.png",
                              title: "Besin Bilgileri",
                              subText: "Görüntüle"
                          ),
                          HomeOptions(
                              imagePath: "assets/food.png",
                              title: "Mesajlarım",
                              subText: "Görüntüle"
                          ),

                        ],
                      ))



/*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children:  [

                              // Diyet Listelerim
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                    width: 180,
                                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text(
                                        "Diyet Listelerim",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              // Besin Bilgilerim
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                    width: 180,
                                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text(
                                        "Besin Bilgilerim",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              //Diyetisyenlerimiz
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                    width: 180,
                                    padding: EdgeInsets.symmetric(horizontal: 27,vertical: 50),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text(
                                        "Diyetisyenlerimiz",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )),
                              ),

                            ],
                          ),

                          Column(
                            children:  [

                              // Diyet Listelerim
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                  width: 180,
                                    padding: EdgeInsets.symmetric(vertical: 50),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(12),

                                    ),

                                    child: Center(
                                      child: Text(
                                        "Mesajlar",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              // Besin Bilgilerim
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                    width: 180,
                                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text(
                                        "Besin Bilgilerim",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              //Diyetisyenlerimiz
                              GestureDetector(
                                onTap: (){},

                                child: Container(
                                    width: 180,
                                    padding: EdgeInsets.symmetric(horizontal: 27,vertical: 50),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(12)),

                                    child: Center(
                                      child: Text(
                                        "Diyetisyenlerimiz",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),

                                ),


                              ),

                            ],
                          )

                        ],
                      )*/

                    ],
                  ),
                );
              },

            )
            )
          ],
        ),
      ),
    );
  }
}
