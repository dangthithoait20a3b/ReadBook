import 'package:flutter/material.dart';
import 'package:flutter2/khampha.dart';
import 'package:flutter2/profile.dart';
import 'package:flutter2/tusach.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final tabBar = [
   KhamPha(),
    TuSach(),
    Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBar[_selectedIndex],
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          selectedItemColor: Color.fromRGBO(66, 200, 60, 1),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          unselectedItemColor: Color.fromRGBO(115, 115, 115, 1),
          items: const<BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Khám phá sách",
                backgroundColor: Colors.grey
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                label: "Tủ sách",
                backgroundColor: Colors.grey
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "Tài khoản",
                backgroundColor: Colors.grey
            ),
          ],
        ),
      ),
    );
  }
}
