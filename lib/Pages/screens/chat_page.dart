import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:beslenme/Pages/screens/components/chat_bubble.dart';
import 'package:beslenme/Pages/screens/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverID;
  final String receiverUserName;

  const ChatPage({
    Key? key,
    required this.receiverID,
    required this.receiverUserName,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverID,
        _messageController.text,
      );
      _messageController.clear();
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.grey[200],
      title: Text(widget.receiverUserName),
    ),
    body: Container(
      color: Colors.lightGreen[400], // Arka plan rengi
      child: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    ),
  );
}

Widget _buildMessageList() {
  return StreamBuilder<DatabaseEvent>(
    stream: _chatService.getMessages(
      widget.receiverID,
      _firebaseAuth.currentUser!.uid,
    ),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      List<Widget> messageWidgets = [];
      Map<dynamic, dynamic>? values =
          (snapshot.data?.snapshot.value as Map<dynamic, dynamic>?);
      if (values != null) {
        // Mesajları ters sırala
        var sortedValues = values.values.toList().reversed.toList();
        sortedValues.forEach((value) {
          messageWidgets.add(_buildMessageItem(value));
        });
      }
      return Expanded(
        child: ListView(
          reverse: true, // ListView'ı tersine çevirme
          children: messageWidgets,
        ),
      );
    },
  );
}

Widget _buildMessageItem(Map<dynamic, dynamic> data) {
  final bool isCurrentUser =
      data['senderEmail'] == _firebaseAuth.currentUser!.email;

  return Align(
    alignment:
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['senderEmail'] ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isCurrentUser ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 4.0),
          ChatBubble(message: data['message'] ?? ''),
        ],
      ),
    ),
  );
}

Widget _buildMessageInput() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Mesajınızı buraya girin...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
          ),
        ),
        SizedBox(width: 8.0),
        IconButton(
          onPressed: sendMessage,
          icon: Icon(Icons.send),
          color: Colors.blue,
          iconSize: 32.0,
        ),
      ],
    ),
  );
}
}