import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vinet/modules/Main%20Menu/home/screens/home_screen.dart';
import 'package:flutter_vinet/modules/Main%20Menu/profile/screens/profile_screen.dart';
import 'package:flutter_vinet/modules/Main%20Menu/server/screens/server_screen.dart';
import 'package:flutter_vinet/widgets/widgets.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomeScreen(), ServerScreen(), ProfileScreen()];

  void bottomTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.home_filled, title: "Home"),
          TabData(iconData: Icons.dns_rounded, title: "Server"),
          TabData(iconData: Icons.manage_accounts_rounded, title: "Profile"),
        ],
        onTabChangedListener: bottomTapped,
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.black,
        circleColor: Color(myColors.primaryGreen()),
        textColor: Colors.black,
        barBackgroundColor: Colors.white,
      ),
      body: _children[_currentIndex],
    );
  }
}
