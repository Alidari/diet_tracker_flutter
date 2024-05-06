import 'package:beslenme/Pages/widgets/chat_input_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../ReadData/mesajları_al.dart';
class MessageTab extends StatefulWidget {
  final String message_with_id;
  final String userId;
  final String other_name;
  final String other_surname;


  const MessageTab({Key? key,required this.message_with_id,required this.userId,required this.other_name, required this.other_surname}) : super(key: key);

  @override
  State<MessageTab> createState() => _MessageWithState();
}

class _MessageWithState extends State<MessageTab> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();


  final ref = FirebaseDatabase.instance.ref("mesaj");

  @override
  void dispose(){
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage(String message) {
    final postKey = ref.push().key;
    final refChild = ref.child("${widget.userId}/${widget.message_with_id}/$postKey");

    // Şu anki zamanı al
    Timestamp now = Timestamp.now();

    print("Timeeee: " + DateTime.fromMillisecondsSinceEpoch(1715039147 * 1000).toString());

    setState(() {
      refChild.set({
        "alici" : widget.message_with_id,
        "durum" : "aktif",
        "gonderen" : widget.userId,
        "mesaj" : message,
        "tarih" : now.seconds
      });
    });
    print('Gönderilen mesaj: $message');
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 15,),
            Text(widget.other_name + " " + widget.other_surname),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: MesajAl(userId:  widget.userId, message_with: widget.message_with_id,),
            ),
          ),
          ChatInputBar(
            textEditingController: _textEditingController,
            onSendMessage: _sendMessage,
            focusNode: _focusNode,
          ),
        ],
      ),
    );
  }
}
