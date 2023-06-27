import 'package:dictionary_flutter/components/random_words.dart';
import 'package:flutter/material.dart';

class WordList extends StatelessWidget {
  const WordList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worlist'),
      ),
      body: Center(
        child: RandomWordsList(),
      ),
    );
  }
}
