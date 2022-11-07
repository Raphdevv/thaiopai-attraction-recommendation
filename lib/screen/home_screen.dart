import 'package:flutter/material.dart';
import 'package:thiaopai/screen/about_screen.dart';
import 'package:thiaopai/screen/recommender_screen.dart';
import 'package:thiaopai/screen/main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  static const List<Widget> _pages = <Widget>[
    MainScreen(),
    RecommenderScreen(),
    AboutScreen(),
  ];

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 3,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.recommend), label: "Recommender"),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
          ],
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xff71D3FF),
          unselectedItemColor: const Color.fromARGB(255, 70, 68, 68),
          onTap: onTapped,
        ));
  }
}
