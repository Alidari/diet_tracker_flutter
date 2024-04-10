import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GetUserName extends StatelessWidget {
  final String documentId;
  final String feature;

  GetUserName({required this.documentId,required this.feature});


  @override
  Widget build(BuildContext context) {

    //get the collection

    CollectionReference users = FirebaseFirestore.instance.collection("users");
    final ref = FirebaseDatabase.instance.ref();

    return FutureBuilder(
        future: ref.child("users/$documentId").get(),
        builder: ((context,snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            Map user = snapshot.data!.value as Map;
            if(user[feature] != null) {
            return Text(user[feature].toString());
            }
            else{
              return Text("Bilinmiyor");
            }
          }
            return Text("Yükleniyor...");
          }
        ),
    );

  }
}
