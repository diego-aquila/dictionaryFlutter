import 'package:dictionary_flutter/controllers/homeC.dart';
import 'package:dictionary_flutter/routes/favorites.dart';
import 'package:dictionary_flutter/routes/history.dart';
import 'package:dictionary_flutter/routes/home.dart';
import 'package:dictionary_flutter/routes/splash.dart';
import 'package:dictionary_flutter/routes/view_definition_screen.dart';
import 'package:dictionary_flutter/routes/wordlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final HomeC randomC = Get.put(HomeC());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dictionary Flutter',
      home: const SplashScreen(),
      initialRoute: '/splash',
      routes: {
        '/wordlist': (context) => const WordList(),
        '/favorites': (context) => Favorites(),
        '/history': (context) => const History(),
        '/showPage': (context) => const ShowWordsPage(),
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
