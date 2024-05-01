import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key,required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers

  final email_conttroller = TextEditingController();
  final password_controller = TextEditingController();

  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_conttroller.text.trim(),
          password: password_controller.text.trim());

      Navigator.of(context).pop();

    } catch (e) {
      print("Giriş Başarısız : {$e}");
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (BuildContext context){

            return AlertDialog(
              title: Text("Giriş Yapılamadı"),
              content: Text("Eposta ve Şifre Uyumsuz"),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text("Tamam"))
              ],
            );
          });

    }
  }

  @override
  void dispose() {
    email_conttroller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/dietLogo.png",scale: 1.2,),
               /* Icon(
                  Icons.local_dining,
                  size: 50,
                ),*/
                SizedBox(
                  height: 20,
                ),
                //Tekrar Hoşgeldiniz
                Text("Diet Tracker",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 35,

                    )),


                SizedBox(
                  height: 50,
                ),

                //email textfield

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: email_conttroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: password_controller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Şifre',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context){
                            return ForgotPasswordPage();
                          },),);
                        },
                        child: Text("Şifrenizi mi unuttunuz?",style:
                          TextStyle(color: Colors.blue),),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),




                //giriş yap button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Üye değil misiniz? "),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                        "Kayıt olmak",
                        style: TextStyle(
                            color: Colors.blue[800], fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(" için tıklayınız"),
                  ],
                ),

                //üye değil misin üye ol yazısı
              ],
            ),
          ),
        ),
      ),
    );
  }
}
