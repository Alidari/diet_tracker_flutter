import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatServiceForDoctor {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance.ref("mesaj");


  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    Timestamp now = Timestamp.now();


    // Yeni mesajı bir Map olarak oluşturdum
    Map<String, dynamic> newMessage = {
      'gonderen': currentUserId,
      'alici': receiverId,
      'mesaj': message,
      'tarih': now.seconds,
    };

    List<String> ids = [currentUserId, receiverId];
    ids.sort();

    final postKey = _database.push().key;
    final refChild = _database.child("$currentUserId/$receiverId/$postKey");


    // Realtime Database'e mesajı gönderme
    await refChild
        .set(newMessage);
  }

  Stream<List<Map<String, dynamic>>> getMessages(String receiverId, String userId) {

    // Realtime Database'den mesajları alma
    return FirebaseDatabase.instance
        .reference()
        .child('mesaj')
        .child(userId)
        .child(receiverId)
        .orderByChild('tarih')
        .onValue
        .map((event) {
      List<Map<String, dynamic>> messages = [];
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values;
        if (event.snapshot.value is Map<dynamic, dynamic>) {
          values = event.snapshot.value as Map<dynamic, dynamic>;
        }
        if (values != null) {
          values.forEach((key, value) {
            messages.add({
              'key': key,
              ...value,
            });
          });
        }
      }
      return messages;
    });
  }
}