import 'package:flutter/material.dart';
import 'package:flutter_icons/feather.dart';
import 'package:flutter_travel_ui/UI/pages/home_page.dart';
import 'package:flutter_travel_ui/UI/pages/profile_page.dart';
import 'package:flutter_travel_ui/UI/pages/search_page.dart';
import 'package:flutter_travel_ui/UI/screens/profile_screen.dart';
import 'package:flutter_travel_ui/widgets/destination_carousel.dart';
import 'package:flutter_travel_ui/widgets/hotel_carousel.dart';
import 'package:flutter_travel_ui/widgets/search_field.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTab = 0;
  List<Widget> pages;
  Widget currentPage;
  double iconSize = 20;

  HomePage homePage;
  ProfilePage profilePage;
  @override
  void initState() {
    super.initState();
    homePage = new HomePage();
    profilePage = new ProfilePage();
    pages = [homePage, homePage, homePage, profilePage];
    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
            currentPage = pages[value];
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Feather.getIconData('home'),
              size: 25.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.getIconData('briefcase'),
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.getIconData('heart'),
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.getIconData('user'),
              size: 25.0,
            ),
            title: SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  _findText() {
    return Text(
      'What would you \nlike to find?',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
