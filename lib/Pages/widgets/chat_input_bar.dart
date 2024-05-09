import 'package:flutter/material.dart';

class ChatInputBar extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String) onSendMessage;

  const ChatInputBar({
    Key? key,
    required this.textEditingController,
    required this.onSendMessage,
  }) : super(key: key);

  @override
  State<ChatInputBar> createState() => _ChatInputState();

}
@override
class _ChatInputState extends State<ChatInputBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: TextField(
                  controller: widget.textEditingController,
                  decoration: InputDecoration(
                      hintText: 'Mesajınızı buraya yazın...',
                      border: InputBorder.none
                  ),
                  onTap: (){
                    //isKeyboardVisible = true;
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.circular(100)
            ),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                // Gönderme işlemi
                final message = widget.textEditingController.text.trim();
                if (message.isNotEmpty) {
                  widget.onSendMessage(message);
                  widget.textEditingController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
