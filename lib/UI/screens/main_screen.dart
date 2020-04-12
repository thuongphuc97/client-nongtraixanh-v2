import 'package:flutter/material.dart';
import 'package:flutter_icons/feather.dart';
import 'package:flutter_travel_ui/UI/pages/home_page.dart';
import 'package:flutter_travel_ui/UI/pages/notifications_page.dart';
import 'package:flutter_travel_ui/UI/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTab = 0;
  List<Widget> pages;
  Widget currentPage;
  double iconSize = 20;
 double activateIconSize = 40;
  HomePage homePage;
  NotificationsPage notiPage;
  ProfilePage profilePage;

  @override
  void initState() {
    super.initState();
    homePage = new HomePage();
    profilePage = new ProfilePage();
    notiPage = new NotificationsPage();
    pages = [homePage, homePage, homePage, notiPage, profilePage];
    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
            currentPage = pages[value];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Feather.getIconData('home'),
              size: iconSize,
            ),
            title: Text('home'),
                                    activeIcon: Icon(Icons.home, size: activateIconSize,)

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.getIconData('briefcase'),
              size: iconSize,
            ),
            title: Text('order'),
                        activeIcon: Icon(Icons.confirmation_number, size: activateIconSize,)

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.getIconData('heart'),
              size: iconSize,
            ),
            title: Text('favourite'),
                        activeIcon: Icon(Icons.favorite, size: activateIconSize,)

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.getIconData('bell'),
              size: iconSize,
            ),
            title: Text('notify'),
                        activeIcon: Icon(Icons.notifications, size: activateIconSize,)

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.getIconData('user'),
              size: iconSize,
            ),
            title: Text('You'),
            activeIcon: Icon(Icons.person, size: activateIconSize,)
          )
        ],
      ),
    );
  }

  
}
