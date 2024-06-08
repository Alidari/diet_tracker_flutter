import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


class ChatWithAI extends StatefulWidget {

  final userId;
  const ChatWithAI({Key? key,required this.userId}) : super(key: key);

  @override
  State<ChatWithAI> createState() => _DietitianAssistantState();
}


class _DietitianAssistantState extends State<ChatWithAI> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  final ref = FirebaseDatabase.instance.ref();
  Map userInfo = {};
  int index = 0;

  @override
  void initState() {
    super.initState();
    FetchData();
  }

  String _initialPrompt = 'Sen şu an "Diet Tracker" adlı bir uygulamada kişisel bir diyetisyen asistanısın. Kullanıcıların Diyet ve beslenme ile ilgili sorularını yanıtlamalasın. Eğer soru diyetle ilgili değilse, “Bu benim uzmanlık alanımın dışında” şeklinde cevap verin.';


  Future<void> _sendMessage(String userInput) async {
    if (userInput.trim().isEmpty) return;

    setState(() {
      _messages.add({"user" : userInput});
    });

    _initialPrompt += "Şu anda konuştuğun kullanıcının bilgileri şu şekilde. Adı: ${userInfo["name"]} , Yaşı:${userInfo["age"]}, Boyu: ${userInfo["boy"]}, Kilosu: ${userInfo["kilo"]}, Vücut Kitle İndeksi (BMI): ${userInfo["bmi"]}";

    final apiKey = "AIzaSyAGvaBeWbbrkU1Hg7aBo5iFhBGVTLlvwXE";

    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final content = [Content.text('$_initialPrompt + " " + $userInput')];

    final response = await model.generateContent(content);

    String? responseText = response.text;

    if(index!=0){
      if(response.text!.contains("Merhaba Ali!")) {
        responseText = response.text?.split("Merhaba Ali!")[1];
      }
    }
    setState(() {
      _messages.add({'bot': responseText ?? 'No response received'});
    });

    _controller.clear();
    index++;
  }

  Future<void> FetchData() async {
    final newRef = ref.child("users/${widget.userId}");
    DatabaseEvent event = await newRef.once();
    userInfo = event.snapshot.value as Map;
    //print("USERRR"+ userInfo.toString());
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diyetisyen Asistan'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(
                    message.containsKey('user') ? '${userInfo["name"]}: ${message['user']}' : 'Kişisel Asistan: ${message['bot']}',
                    style: TextStyle(
                      color: message.containsKey('user') ? Colors.blue : Colors.green,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Sorunuzu Giriniz',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
