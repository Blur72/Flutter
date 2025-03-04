import 'package:flutter/material.dart';
import 'page_one.dart';
import 'page_two.dart';
import 'page_three.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [PageOne(), PageTwo(), PageThree()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // Отображаем текущую страницу
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Страница 1'),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Страница 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Страница 3',
          ),
        ],
      ),
    );
  }
}
