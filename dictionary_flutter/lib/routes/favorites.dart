import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favoritesC.dart';
import '../controllers/randomC.dart';
import '../util/capitalize.dart';
import '../util/messages.dart';

class Favorites extends StatelessWidget {
  Favorites({super.key});

  final FavoritesC favoritesC = Get.put(FavoritesC());

  final RandomC randomC = Get.put(RandomC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Favorites'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('favorites').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                var data = document.data();
                return Dismissible(
                  key: Key(document.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete, color: Colors.white),
                    // padding: EdgeInsets.only(right: 16.0),
                  ),
                  onDismissed: (direction) {
                    // Ação de exclusão
                    FirebaseFirestore.instance
                        .collection('favorites')
                        .doc(document.id)
                        .delete();

                    messageDelete(context, document.id, 'favorites');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Container(
                      color: Colors.grey[200],
                      child: ListTile(
                        onTap: () {
                          var dados = data as Map<String, dynamic>;
                          randomC.wordSearch = dados['word'];
                          randomC.responseSave = jsonDecode(dados['json']);

                          Navigator.pushNamed(context, '/showPage');
                        },
                        title: Text(capitalizeFirstLetter(document.id)),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
