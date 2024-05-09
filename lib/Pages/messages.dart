import 'package:beslenme/Pages/screens/home_page_chat.dart';
import 'package:beslenme/ReadData/diyetisyen_al_mesaj.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_tab2.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();

}

class _MessagesState extends State<Messages> {
  final user = FirebaseAuth.instance.currentUser!;
  late final String userId;

  @override
  void initState() {
    userId = user.uid;
  }

  void goMessageTab(String messageWithId,String messageWithName,String messageWithSurname){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MessageTab2(message_with_id: messageWithId, userId: userId, other_name: messageWithName, other_surname: messageWithSurname,)), // Geçiş yapmak istediğiniz sayfayı buraya ekleyin)
    );
 }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sohbetler'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Text("Kullanıcılar"),
                
              ),
              Tab(
                icon: Text("Diyetisyenler"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: UserListPage(),
            ),
            Center(
              child: DiyetisYenAlMesaj(userId: userId,onTap: goMessageTab)
            ),

          ],
        ),
      ),
    );
  }
}
