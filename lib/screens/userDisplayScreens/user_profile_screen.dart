import 'package:flutter/material.dart';
import './accounts_page.dart';
import './explorer_page.dart';
import './chat_page.dart';
import 'match_page.dart';

class UserProfileScreen extends StatefulWidget {
  final String email;
  UserProfileScreen({required this.email});
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
    late String getEmail;
    void initState() {
    super.initState();
    getEmail = widget.email;
  }

  int _selectedIndex = 0;
  
  late final List<Widget> _widgetOptions = <Widget>[
    ExplorerPage(email: getEmail),
    MatchPage(),
    ChatPage(),
    AccountPage(email: getEmail,),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bolt),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
