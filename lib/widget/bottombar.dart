import 'package:flutter/material.dart';

import '../pages/home/home.dart';
import '../pages/list/list.dart';
import '../pages/mywork/my_work.dart';
import '../pages/profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    ListPage(),
    const MyWorkPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'หน้าแรก',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'รายการ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.create_rounded),
              label: 'งานของฉัน',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'ฉัน',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightGreenAccent,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
