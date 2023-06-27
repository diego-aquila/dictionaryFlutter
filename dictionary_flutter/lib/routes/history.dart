import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Rota Wordlist'),
          onPressed: () {
            Navigator.pushNamed(context, '/wordlist');
          },
        ),
      ),
    );
  }
}
