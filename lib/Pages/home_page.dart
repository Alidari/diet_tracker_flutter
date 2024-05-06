import 'package:beslenme/Pages/diyetisyen_sec.dart';
import 'package:beslenme/Pages/messages.dart';
import 'package:beslenme/Pages/screens/Start.dart';
import 'package:beslenme/ReadData/get_user_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beslenme/Pages/VucutKitleIndeksi.dart';
import 'package:google_fonts/google_fonts.dart';
import 'foodInfo.dart';

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

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[200],
        leading: Icon(Icons.menu),
       actions: [
         GestureDetector(
             onTap: (){
               FirebaseAuth.instance.signOut();
             },
             child: Icon(Icons.logout)),
       ],
      ),
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
      body: Container(
        decoration: BoxDecoration(
        ),
        child: ListView(
          children: [
            FutureBuilder(
              future: getDocId(),
              builder: (context,snapshot){
                return Center(
                    child: Column(
                      children: [
<<<<<<< Updated upstream
            
                        SizedBox(height: 50,),
            
=======

                        SizedBox(height: 50,),

>>>>>>> Stashed changes
                        //PROFİL CONTAİNER
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 120.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  margin: EdgeInsets.all(35),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/profil.jpg"),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GetUserName(documentId: docId, feature: "name",styl: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 25,
                                        fontFamily: "Arial"
                                    ),),
                                    Text(" "),
                                    GetUserName(documentId: docId, feature: "lastname",styl: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 25,
                                        fontFamily: "Arial"
                                    ),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
<<<<<<< Updated upstream
            
            
                        //BAŞKA SEKMELER
            
=======


                        //BAŞKA SEKMELER

>>>>>>> Stashed changes
                        //Kilo, boy, bmi bilgileri
                        Stack(
                          children: [
                            // İlk container
                            Container(
<<<<<<< Updated upstream
  width: screenWidth,
  height: screenHeight,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.center,
      colors: [Colors.green.withOpacity(1), Colors.white]
    ),
    color: Colors.green.withOpacity(0.6),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(50),
      topRight: Radius.circular(50)
    )
  ),
  child: Padding(
    padding: const EdgeInsets.only(top: 35.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: screenWidth / 5,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 1)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetUserName(
                          documentId: docId,
                          feature: "kilo",
                          styl: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 20,
                            fontFamily: "Arial"
                          ),
                        ),
                        Text(" Kg")
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Kilo",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.4)
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: screenWidth / 5,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 1)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetUserName(
                          documentId: docId,
                          feature: "boy",
                          styl: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 20,
                            fontFamily: "Arial"
                          ),
                        ),
                        Text(" Cm")
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Boy",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.4)
                            )
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: screenWidth / 5,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 1)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetUserName(
                          documentId: docId,
                          feature: "bmi",
                          styl: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 20,
                            fontFamily: "Arial"
                          ),
                        )
                        
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Bmi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.4)
                            )
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Skor kısmı burada ekleniyor
              Container(
                width: screenWidth / 5,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 1)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetUserName(
                          documentId: docId,
                          feature: "score",
                          styl: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 20,
                            fontFamily: "Arial"
                          ),
                        ),
                        Text(" Puan",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.4)
                            )
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Quiz Skor",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.4)
                            )
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
                         ),
                                    ),
                                    ),
            
                            // İkinci container
                            Positioned(
                              top: 150, // İlk container'ın üst kısmından bu kadar mesafede olacak
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: screenHeight - 150, // İlk container'ın üzerine binmeyecek şekilde ayarlanır
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    )
                                ),
            
                                
                                //BUTONLAR
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
            
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => diyetisyenSec()), // Geçiş yapmak istediğiniz sayfayı buraya ekleyin)
                                            );
                                          },
                                          child : Container(
            
                                            child: Column(
                                              children: [
                                                Image.asset("assets/dietisyen.png",width: 100,),
                                                Text("Diyetisyen",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)
            
                                                  ),)
                                              ],
                                            ),
            
                                          ),
                                        ),
            
                                        SizedBox(height: 55,),
            
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => FoodsInfo()), // Geçiş yapmak istediğiniz sayfayı buraya ekleyin)
                                            );
                                          },
                                          child : Container(
            
                                            child: Column(
                                              children: [
                                                Image.asset("assets/food.png",width: 80,),
                                                SizedBox(height: 10,),
                                                Text("Besin Bilgileri",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)
            
                                                  ),)
                                              ],
                                            ),
            
                                          ),
                                        ),
            
                                        SizedBox(height: 40,),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => VucutKitleIndeksi()), // Geçiş yapmak istediğiniz sayfayı buraya ekleyin)
                                            );
                                          },
                                          child : Container(
            
                                            child: Column(
                                              children: [
                                                Image.asset("assets/bmi.png",width: 100,),
                                                Text("Bmi Hesaplama",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)
            
                                                  ),)
                                              ],
                                            ),
            
                                          ),
                                        ),
            
                                      ],
                                    ),
            
                                    Column(
                                      children: [
                                        SizedBox(height: 15,),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => StartScreen()), // Geçiş yapmak istediğiniz sayfayı buraya ekleyin)
                                            );
                                          },
                                          child : Container(
                                            child: Column(
                                              children: [
            
                                                Image.asset("assets/quiz.png",width: 75,),
                                                SizedBox(height: 10,),
                                                Text("Quiz Oyunu",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)
            
                                                  ),
                                                ),
            
                                              ],
                                            ),
            
                                          ),
                                        ),
                                        SizedBox(height: 45,),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => Messages()), // Geçiş yapmak istediğiniz sayfayı buraya ekleyin)
                                            );
                                          },
                                          child : Container(
                                            child: Column(
                                              children: [
            
                                                Image.asset("assets/message.png",width: 90,),
                                                SizedBox(height: 10,),
                                                Text("Mesajlar",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)
            
                                                  ),
                                                ),
            
                                              ],
                                            ),
            
                                          ),
                                        ),
            
                                        SizedBox(height: 40,),
                                        GestureDetector(
                                          onTap: (){},
                                          child : Container(
                                            child: Column(
                                              children: [
            
                                                Image.asset("assets/list.png",width: 90,),
                                                SizedBox(height: 10,),
                                                Text("Diyet Listesi",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)
            
                                                  ),
                                                ),
            
                                              ],
                                            ),
            
                                          ),
                                        ),
            
            
                                      ],
                                    ),
            
            
                                  ],
                                ),
=======
                                width: screenWidth,
                                height: screenHeight,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.center,
                                        colors: [Colors.green.withOpacity(1), Colors.white]
                                    ),
                                    color: Colors.green.withOpacity(0.6),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50)
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top:35.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: screenWidth/5,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  color: Colors.green[100],
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(color: Colors.white.withOpacity(0.5),width: 1)
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                    GetUserName(documentId: docId, feature: "kilo",styl: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black.withOpacity(0.7),
                                                        fontSize: 20,
                                                        fontFamily: "Arial"
                                                    ),),
                                                    Text(" Kg")],
                                                  ),

                                                  Row(

                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20.0),
                                                        child: Text("Kilo",style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black.withOpacity(0.4)
                                                        )
                                                          ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),

                                            Container(
                                              width: screenWidth/5,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  color: Colors.green[100],
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(color: Colors.white.withOpacity(0.5),width: 1)
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      GetUserName(documentId: docId, feature: "boy",styl: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black.withOpacity(0.7),
                                                          fontSize: 20,
                                                          fontFamily: "Arial"
                                                      ),),
                                                      Text(" Cm")],
                                                  ),

                                                  Row(

                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20.0),
                                                        child: Text("Boy",style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black.withOpacity(0.4)
                                                        )
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),


                                            Container(
                                              width: screenWidth/5,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  color: Colors.green[100],
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(color: Colors.white.withOpacity(0.5),width: 1)
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      GetUserName(documentId: docId, feature: "bmi",styl: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black.withOpacity(0.7),
                                                          fontSize: 20,
                                                          fontFamily: "Arial"
                                                      ),)
                                                    ],
                                                  ),

                                                  Row(

                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20.0),
                                                        child: Text("Bmi",style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black.withOpacity(0.4)
                                                        )
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              // İlk container içeriği burada olabilir
                            ),

                            // İkinci container
                            Positioned(
                              top: 150, // İlk container'ın üst kısmından bu kadar mesafede olacak
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: screenHeight - 150, // İlk container'ın üzerine binmeyecek şekilde ayarlanır
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    )
                                ),


                                //BUTONLAR
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [

                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => diyetisyenSec()), // Geçiş yapmak istediğiniz sayfayı buraya ekleyin)
                                            );
                                          },
                                          child : Container(

                                            child: Column(
                                              children: [
                                                Image.asset("assets/dietisyen.png",width: 100,),
                                                Text("Diyetisyen",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)

                                                  ),)
                                              ],
                                            ),

                                          ),
                                        ),

                                        SizedBox(height: 55,),

                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => FoodsInfo()), // Geçiş yapmak istediğiniz sayfayı buraya ekleyin)
                                            );
                                          },
                                          child : Container(

                                            child: Column(
                                              children: [
                                                Image.asset("assets/food.png",width: 80,),
                                                SizedBox(height: 10,),
                                                Text("Besin Bilgileri",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)

                                                  ),)
                                              ],
                                            ),

                                          ),
                                        ),

                                        SizedBox(height: 40,),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => VucutKitleIndeksi()), // Geçiş yapmak istediğiniz sayfayı buraya ekleyin)
                                            );
                                          },
                                          child : Container(

                                            child: Column(
                                              children: [
                                                Image.asset("assets/bmi.png",width: 100,),
                                                Text("Bmi Hesaplama",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)

                                                  ),)
                                              ],
                                            ),

                                          ),
                                        ),

                                      ],
                                    ),

                                    Column(
                                      children: [
                                        SizedBox(height: 15,),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => HomeScreen()), // Geçiş yapmak istediğiniz sayfayı buraya ekleyin)
                                            );
                                          },
                                          child : Container(
                                            child: Column(
                                              children: [

                                                Image.asset("assets/quiz.png",width: 75,),
                                                SizedBox(height: 10,),
                                                Text("Quiz Oyunu",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)

                                                  ),
                                                ),

                                              ],
                                            ),

                                          ),
                                        ),
                                        SizedBox(height: 45,),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => Messages()), // Geçiş yapmak istediğiniz sayfayı buraya ekleyin)
                                            );
                                          },
                                          child : Container(
                                            child: Column(
                                              children: [

                                                Image.asset("assets/message.png",width: 90,),
                                                SizedBox(height: 10,),
                                                Text("Mesajlar",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)

                                                  ),
                                                ),

                                              ],
                                            ),

                                          ),
                                        ),

                                        SizedBox(height: 40,),
                                        GestureDetector(
                                          onTap: (){},
                                          child : Container(
                                            child: Column(
                                              children: [

                                                Image.asset("assets/list.png",width: 90,),
                                                SizedBox(height: 10,),
                                                Text("Diyet Listesi",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight : FontWeight.bold,
                                                      fontSize : 18,
                                                      color : Colors.black.withOpacity(0.7)

                                                  ),
                                                ),

                                              ],
                                            ),

                                          ),
                                        ),


                                      ],
                                    ),


                                  ],
                                ),
>>>>>>> Stashed changes
                                // İkinci container içeriği burada olabilir
                              ),
                            ),
                          ],
                        )
<<<<<<< Updated upstream
            
            
=======


>>>>>>> Stashed changes
                      ],
                    )
                );
              },
            ),
          ]
        ),
      )
    );
  }
}
