import 'package:flutter/material.dart';
import '../../widgets/chat_card.dart';
import 'personal_chat_screen.dart';

class ChatPage extends StatelessWidget {
  final List<Widget> chats = [];

  List<Widget> chatScreen() {
    chats.removeRange(0, chats.length - 1);

    chats.add(ChatCard());
    chats.add(ChatCard());
    chats.add(ChatCard());
    chats.add(ChatCard());
    chats.add(ChatCard());
    chats.add(ChatCard());
    chats.add(ChatCard());
    chats.add(ChatCard());
    chats.add(ChatCard());
    chats.add(ChatCard());

    return chats;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: ListView.builder(
  //       itemCount: chats.length,
  //       itemBuilder: (context, index) {
  //         return GestureDetector(
  //           onTap: () => Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (BuildContext context) => PersonalChatScreen(),
  //             ),
  //           ),
  //           child: Container(
  //             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //             child: Row(
  //               children: chatScreen(),
  //             ),
  //           ),
  //         );
  //       },
  //       // children: chatScreen(),
  //     ),
  //   );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: new Container(child: null,),
        automaticallyImplyLeading: false,
        title: Text('Messages'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(child: ChatCard(),onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalChatScreen())),);
          },
        ),
      ),
    );
  }
}
