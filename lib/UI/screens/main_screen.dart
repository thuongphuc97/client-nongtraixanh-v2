import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_travel_ui/UI/pages/home_page.dart';
import 'package:flutter_travel_ui/UI/pages/notifications_page.dart';
import 'package:flutter_travel_ui/UI/pages/profile_page.dart';
import 'package:flutter_travel_ui/UI/pages/testpage.dart';
import 'package:flutter_travel_ui/UI/pages/ticket_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTab = 0;
  List<Widget> pages;
  Widget currentPage;
  double iconSize = 20;
  double activateIconSize = 35;
  HomePage homePage;
  NotificationsPage notiPage;
  ProfilePage profilePage;
  TicketPage ticketPage;
  GetChuckCategories getChuckCategories;

  @override
  void initState() {
    super.initState();
    homePage = new HomePage();
    profilePage = new ProfilePage();
    notiPage = new NotificationsPage();
    ticketPage = new TicketPage();
    getChuckCategories = new GetChuckCategories();
    pages = [homePage, ticketPage, notiPage, profilePage];
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
              Feather.home, // icon giờ viết kiểu chấm như vầy luôn chứ k phải như hôm trước là Feather.getIcon('ten icon nữa)
              size: iconSize,
            ),
            title: Text('home'),
                                    activeIcon: Icon(Icons.home, size: activateIconSize,)

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.briefcase,
              size: iconSize,
            ),
            title: Text('ticket'),
                        activeIcon: Icon(Icons.confirmation_number, size: activateIconSize,)

          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Feather.getIconData('heart'),
          //     size: iconSize,
          //   ),
          //   title: Text('favourite'),
          //               activeIcon: Icon(Icons.favorite, size: activateIconSize,)

          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.bell,
              size: iconSize,
            ),
            title: Text('notify'),
                        activeIcon: Icon(Icons.notifications, size: activateIconSize,)

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.user,
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
