import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final email_controller = TextEditingController();

  @override
  void dispose() {
    email_controller.dispose();
    super.dispose();
  }

  Future resetPassword() async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email_controller.text.trim());
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text("Şifre Sıfırlama linki mail adresinize gönderildi",style: TextStyle(
            color: Colors.green,
          ),
            textAlign: TextAlign.center,
          ),
        );
      });

    } on FirebaseAuthException catch(e){
      print(e);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text(e.message.toString(),style: TextStyle(
            color: Colors.red,
          ),
            textAlign: TextAlign.center,
          ),
        );
      });
    }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: Text(
                 "Email adresinizi girin ve size bir şifre sıfırlama linki gönderelim",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
                    controller: email_controller,
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
            MaterialButton(
              onPressed: resetPassword,
              child: Text("Şifre Sıfırla"),
              color: Colors.deepPurpleAccent[200],
            ),

          ],
        ),
      ),
    );
  }
}
