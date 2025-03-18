import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/auth.dart';
import 'package:flutter_application_1/pages/notification.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/search.dart';
import 'package:flutter_application_1/pages/tiktok.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  int _currentIndex = 0;
  String title = "Главная";

  final pages = [TiktikPage(), SearchPage(), NotificationPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () async {
                await authService.signOut();
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.popAndPushNamed(context, '/reg');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: pages.elementAt(_currentIndex),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff2b2d42),
        onPressed: () {

        }, child: Icon(Icons.add, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          if (value == 0) {
            title = "Главная";
          }
          if (value == 1) {
            title = "Поиск";
          }
          if (value == 2) {
            title = "Уведолмения";
          }
          if (value == 3) {
            title = "Профиль";
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
      ),
    );
  }
}
