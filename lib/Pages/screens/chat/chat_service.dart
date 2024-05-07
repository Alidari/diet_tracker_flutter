import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final DateTime timestamp = DateTime.now();

    // Yeni mesajı bir Map olarak oluşturdum
    Map<String, dynamic> newMessage = {
      'senderId': currentUserId,
      'senderEmail': currentUserEmail,
      'receiverId': receiverId, 
      'message': message,
      'timestamp': timestamp.toIso8601String(), 
    };

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // Realtime Database'e mesajı gönderme
    await _database
        .child('chat_rooms')
        .child(chatRoomId)
        .child('messages')
        .push()
        .set(newMessage);
  }

  Stream<List<Map<String, dynamic>>> getMessages(String userId, String receiverId) {
  List<String> ids = [userId, receiverId];
  ids.sort();
  String chatRoomId = ids.join("_");

  // Realtime Database'den mesajları alma
  return FirebaseDatabase.instance
      .reference()
      .child('chat_rooms')
      .child(chatRoomId)
      .child('messages')
      .orderByChild('timestamp')
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