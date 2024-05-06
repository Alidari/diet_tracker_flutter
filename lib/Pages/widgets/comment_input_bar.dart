import 'package:flutter/material.dart';

class CommentInputBar extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String) onSendMessage;

  const CommentInputBar({
    Key? key,
    required this.textEditingController,
    required this.onSendMessage,
  }) : super(key: key);

  @override
  State<CommentInputBar> createState() => _ChatInputState();

}
@override
class _ChatInputState extends State<CommentInputBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                border: Border.all()
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: TextField(
                  controller: widget.textEditingController,
                  decoration: InputDecoration(
                      hintText: 'Diyetisyen Yorumunu...',
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
