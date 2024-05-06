import 'dart:async';

import 'package:beslenme/Pages/widgets/comment_input_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DiyetisyenSayfa extends StatefulWidget {
  final Map diyetisyen;

  const DiyetisyenSayfa({Key? key,required this.diyetisyen,}) : super(key: key);

  @override
  State<DiyetisyenSayfa> createState() => _DiyetisyenSayfaState();
}

class _DiyetisyenSayfaState extends State<DiyetisyenSayfa> {
  int starControl = 0;
  String kullaniciAdi = '';

  final ref = FirebaseDatabase.instance.ref("reviews");
  final user = FirebaseAuth.instance.currentUser!;
  late final String userId;

  @override
  void initState() {
    userId = user.uid;
    _fetchKullaniciAdi();
    super.initState();
  }

  void _fetchKullaniciAdi(){
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _controller = TextEditingController();

    void sendRating(String rating){
      ref.child(widget.diyetisyen["id"]).update({
        "Doktor" : widget.diyetisyen["id"].toString(),
        "Hasta" : ""
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diyetisyen["ad"] + " " + widget.diyetisyen["soyad"]),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
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
                Text("Diyetisyen Dr." + widget.diyetisyen["ad"] + " " + widget.diyetisyen["soyad"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),textAlign: TextAlign.center,),
                Text("Tel No: +90 " + widget.diyetisyen["telefon"]),
        
        
                SizedBox(height: 30,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(9)
                  ),
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
        
                       Container(
                         width: screenWidth - 100,
                         margin: EdgeInsets.symmetric(vertical: 10),
                         child: Column(
        
                            children: [
                              Text("Email: " + widget.diyetisyen["mail"]),
                              Divider(),
                              Text("Adres: " + widget.diyetisyen["adres"] ),
                              Divider(),
                              Text("Deneyim: " + widget.diyetisyen["deneyim"] + " Yıl"),
                              Divider(),
                              Text("D.Tarihi: " + widget.diyetisyen["dtarih"] ),
                              Divider(),
                              Text("Okul: " + widget.diyetisyen["okul"] ),
                              Divider(),
                              Text("Ucret: " + widget.diyetisyen["ucret"] + " TL" ),
        
        
                              SizedBox(height: 20,),
                              /*Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.green[300],
                                ),
                                  child: Text("Puan")),*/
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  for(int i=0;i<starControl;i++)
                                  GestureDetector(
                                    child: SvgPicture.asset(
                                      'assets/star.svg',
                                      width: 40,
                                      ),
        
                                    onTap: (){
                                      setState(() {
                                        starControl = i+1;
                                      });
                                    },
                                  ),
                                  for(int i = starControl;i<5;i++)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                      child: GestureDetector(
                                        child: SvgPicture.asset(
                                          'assets/empty-star.svg',
                                          width: 37,),
                                        onTap: (){
                                          setState(() {
                                            starControl = i+1;
                                          });
                                          print("STARRRR : " + starControl.toString());
                                        },
                                      ),
                                    )
                                ],
                              ),
                              SizedBox(height: 15,),
                              
                              CommentInputBar(textEditingController: _controller, onSendMessage: sendRating)

                            ],
                          ),
                       ),
        
                    ],
                  ),
                ),
                SizedBox(height: 20), // Araya bir boşluk ekleyelim


              ],
            ),
          ),
        ),
      ),

    );
  }
}
