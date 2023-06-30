import 'dart:convert';

import 'package:dictionary_flutter/controllers/randomC.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dictionary_flutter/util/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../util/capitalize.dart';
import 'package:get/get.dart';

import '../util/http.dart';
import '../controllers/favoritesC.dart';

void main() {
  runApp(const MaterialApp());
}

class RandomWordsList extends StatelessWidget {
  RandomWordsList({super.key});
  final RandomC randomC = Get.put(RandomC());
  final FavoritesC favoritesC = Get.put(FavoritesC());
  final _randomWords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(16.0),
      itemCount: null,
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= _randomWords.length) {
          generateWordPairs().take(10).forEach((element) {
            _randomWords.add(element.first);
          });
        }
        return _buildRow(context, _randomWords[index]);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
      ),
    );
  }

  Widget _buildRow(context, word) {
    return InkWell(
      onTap: () {
        randomC.wordSearch = word;
        randomC.selectedIndex = 3;
        getWord(word, context);
      },
      child: Card(
        child: Center(
          child: Text(
            capitalizeFirstLetter(word),
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }

  Future getWord(word, context) async {
    var responseCache = await getFromCache(context, word);

    if (responseCache == null) {
      var responseData = await HttpService.getService(word, context);

      if (responseData != null) {
        addToCache(word, jsonEncode(responseData));
        randomC.responseSave = responseData;
        favoritesC.isFavorite.value = false;

        addhistory(word);
        Navigator.pushNamed(context, '/showPage');
      }
    }
  }

  addhistory(word) async {
    await FirebaseService.addDB(word, randomC.responseSave, "historico");
  }

  Future<void> addToCache(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<bool?> getFromCache(context, key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      Map<String, dynamic> json = jsonDecode(jsonString);
      addhistory(key);
      randomC.responseSave = json;
      Navigator.pushNamed(context, '/showPage');
      return true;
    }
    return null;
  }
}
