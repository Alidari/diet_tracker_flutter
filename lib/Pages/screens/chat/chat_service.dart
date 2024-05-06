import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatService {
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final DatabaseReference _database = FirebaseDatabase.instance.reference();

Future<void> sendMessage(String receiverId, String message) async {
  final String currentUserId = _firebaseAuth.currentUser!.uid;
  final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
  final DateTime timestamp = DateTime.now();

  // Yeni mesajı bir Map olarak oluşturun
  Map<String, dynamic> newMessage = {
    'senderId': currentUserId,
    'senderEmail': currentUserEmail,
    'receiverId': receiverId, // Doğru alıcıya ait receiverId'yi kullanın
    'message': message,
    'timestamp': timestamp.toIso8601String(), // DateTime'ı ISO 8601 biçimine dönüştürün
  };

  List<String> ids = [currentUserId, receiverId];
  ids.sort();
  String chatRoomId = ids.join("_");

  // Realtime Database'e mesajı gönderin
  await _database
      .child('chat_rooms')
      .child(chatRoomId)
      .child('messages')
      .push()
      .set(newMessage);
}


Stream<DatabaseEvent> getMessages(String userId, String receiverId) {
List<String> ids = [userId, receiverId];
ids.sort();
String chatRoomId = ids.join("_");


// Realtime Database'den mesajları alın
return _database
    .child('chat_rooms')
    .child(chatRoomId)
    .child('messages')
    .orderByChild('timestamp')
    .onValue;
}
}