import 'package:flutter/material.dart';
import 'package:fx_project/screens/chatpage.dart';
import 'package:fx_project/screens/dashboardpage.dart';
import 'package:fx_project/screens/duplicatecamerapage.dart';
import 'package:fx_project/screens/morepage.dart';
import 'package:fx_project/screens/notificationpage.dart';

class BottomNaviBar extends StatefulWidget {
  const BottomNaviBar({super.key});

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  int selectedIndex = 0;
  static List<Widget> selectedOption = <Widget>[
    const DashboardPage(),
    const ChatPage(),
    //CameraPage(camera: firstCamera),
    const DuplicateCameraPage(),
    const NotificationPage(),
    const MorePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: selectedOption.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Photo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notification'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu')
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.orange[900],
        unselectedItemColor: const Color.fromARGB(255, 1, 21, 88),
        iconSize: 23,
        onTap: _onItemTapped,
        elevation: 3,
      ),
    );
  }
}
