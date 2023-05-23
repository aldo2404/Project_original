import 'package:flutter/material.dart';
import 'package:fx_project/screens/chatFolder/chatpage.dart';
import 'package:fx_project/screens/dashboardpage.dart';
import 'package:fx_project/screens/duplicatecamerapage.dart';
import 'package:fx_project/screens/morepage.dart';
import 'package:fx_project/screens/notificationpage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Persistentnavbar extends StatefulWidget {
  const Persistentnavbar({super.key});

  @override
  State<Persistentnavbar> createState() => _PersistentnavbarState();
}

class _PersistentnavbarState extends State<Persistentnavbar> {
  PersistentTabController _controller = PersistentTabController();
  final _dashNaviKey = GlobalKey<NavigatorState>();
  final _chatNaviKey = GlobalKey<NavigatorState>();
  final _camNaviKey = GlobalKey<NavigatorState>();
  final _notifiNaviKey = GlobalKey<NavigatorState>();
  final _moreNaviKey = GlobalKey<NavigatorState>();
  late final GlobalKey<NavigatorState>? navigatorkey;
  int selectedIndex = 0;
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        decoration: const NavBarDecoration(
            border: Border(top: BorderSide(color: Colors.black, width: 1))),
        screens: const [
          DashboardPage(),
          ChatPage(),
          //CameraPage(camera: firstCamera),
          DuplicateCameraPage(),
          NotificationPage(),
          MorePage(),
        ],
        items: items(),
        // onWillPop: (context) async {
        //   if (items.navigatorkey?.currentState?.canPop() ?? false) {
        //     items[selectedIndex].navigatorkey?.currentState?.pop();
        //     return false;
        //   } else {
        //     // if current tab can't be popped then use the root navigator
        //     return true;
        //   }
        // },
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: false,
        popActionScreens: PopActionScreensType.once,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.simple,
      ),
    );
  }

  List<PersistentBottomNavBarItem> items() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.dashboard),
          title: 'Dashboard',
          activeColorPrimary: const Color.fromARGB(255, 230, 81, 0),
          inactiveColorPrimary: const Color.fromARGB(255, 1, 21, 88),
          routeAndNavigatorSettings:
              RouteAndNavigatorSettings(navigatorKey: _dashNaviKey),
          // onPressed: (context) {

          //   //Navigator.push((BuildContext? context)=> MaterialPageRoute(builder: (_)=>DashboardPage()))
          // },
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.chat),
          title: 'Chat',
          activeColorPrimary: const Color.fromARGB(255, 230, 81, 0),
          inactiveColorPrimary: const Color.fromARGB(255, 1, 21, 88),
          routeAndNavigatorSettings:
              RouteAndNavigatorSettings(navigatorKey: _chatNaviKey),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.camera_alt),
          title: 'Photo',
          activeColorPrimary: const Color.fromARGB(255, 230, 81, 0),
          inactiveColorPrimary: const Color.fromARGB(255, 1, 21, 88),
          routeAndNavigatorSettings:
              RouteAndNavigatorSettings(navigatorKey: _camNaviKey),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.notifications),
          title: 'Notification',
          activeColorPrimary: const Color.fromARGB(255, 230, 81, 0),
          inactiveColorPrimary: const Color.fromARGB(255, 1, 21, 88),
          routeAndNavigatorSettings:
              RouteAndNavigatorSettings(navigatorKey: _notifiNaviKey),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.menu),
          title: 'More',
          activeColorPrimary: const Color.fromARGB(255, 230, 81, 0),
          inactiveColorPrimary: const Color.fromARGB(255, 1, 21, 88),
          routeAndNavigatorSettings:
              RouteAndNavigatorSettings(navigatorKey: _moreNaviKey),
        )
      ];
}
