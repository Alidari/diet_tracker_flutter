import 'package:firebase_database/firebase_database.dart';

class GetMessageNew {
  final String userId;
  final String message_with;

  GetMessageNew({required this.message_with,required this.userId});

  Future<Map> initMessages() async{

    final ref = FirebaseDatabase.instance.ref("mesaj/$userId/$message_with");
    
    return {};
  }

}