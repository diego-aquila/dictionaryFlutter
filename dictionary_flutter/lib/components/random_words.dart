import 'package:dictionary_flutter/components/randomC.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../util/capitalize.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MaterialApp());
}

class RandomWordsList extends StatelessWidget {
  RandomWordsList({super.key});
  final RandomC randomC = Get.put(RandomC());
  final _randomWords = [];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(16.0),
      itemCount: null,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= _randomWords.length) {
          generateWordPairs().take(10).forEach((element) {
            _randomWords.add(element.first);
          });
        }
        return _buildRow(_randomWords[index]);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Define o número de colunas
        mainAxisSpacing: 1.0, // Espaçamento vertical entre os itens
        crossAxisSpacing: 1.0, // Espaçamento horizontal entre os itens
      ),
    );
  }

  Widget _buildRow(word) {
    return InkWell(
      onTap: () {
        randomC.wordSearch = word;
        print(randomC.wordSearch);
      },
      child: Card(
        child: Center(
          child: Text(
            capitalizeFirstLetter(word),
            style: _biggerFont,
          ),
        ),
      ),
    );
  }
}
