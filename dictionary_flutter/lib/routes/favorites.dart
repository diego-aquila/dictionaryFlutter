import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Abrir Rota 1'),
          onPressed: () {
            Navigator.pushNamed(context, '/favorites');
          },
        ),
      ),
    );
  }
}
