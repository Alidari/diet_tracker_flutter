import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GetUserName extends StatelessWidget {
  final String documentId;
  final String feature;
  final TextStyle styl;

  GetUserName({required this.documentId,required this.feature,required this.styl});


  @override
  Widget build(BuildContext context) {

    //get the collection
    final ref = FirebaseDatabase.instance.ref("users");

    return FutureBuilder(
      future: ref.child("/$documentId").get(),
      builder: ((context,snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasData) {
            Map user = snapshot.data!.value as Map;
            if (user[feature] != null) {
              return Text(user[feature].toString(), style: styl
              );
            }
          }
          else{
            return Text("Bilinmiyor");
          }
        }
        return Text("-");
      }
      ),
    );

  }
}