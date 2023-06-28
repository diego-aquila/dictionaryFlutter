import 'package:dictionary_flutter/routes/favorites.dart';
import 'package:dictionary_flutter/routes/history.dart';
import 'package:dictionary_flutter/routes/view_definition_screen.dart';
import 'package:dictionary_flutter/routes/wordlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const WordList(),
    const History(),
    const Favorites(),
    const ShowWordsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dictionary Flutter',
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          // Define o padding dos itens
        ),
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dictionary Flutter'),
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
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
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
      ),
      routes: {
        '/wordlist': (context) => const WordList(),
        '/favorites': (context) => const Favorites(),
        '/history': (context) => const History(),
        '/showPage': (context) => const ShowWordsPage(),
      },
    );
  }
}
