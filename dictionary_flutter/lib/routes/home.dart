import 'package:dictionary_flutter/controllers/homeC.dart';
import 'package:dictionary_flutter/routes/favorites.dart';
import 'package:dictionary_flutter/routes/history.dart';
import 'package:dictionary_flutter/routes/view_definition_screen.dart';
import 'package:dictionary_flutter/routes/wordlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeC homeC = Get.put(HomeC());
  final int _selectedIndex = 0;

  final List<Widget> _screens = [
    const WordList(),
    const History(),
    Favorites(),
    const ShowWordsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      homeC.selectedIndex = index;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dictionary Flutter'),
      ),
      body: _screens[homeC.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedFontSize: 18,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.lightBlue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Wordlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
