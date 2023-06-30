import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary_flutter/components/favoritesC.dart';
import 'package:dictionary_flutter/components/randomC.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToFavorites extends StatefulWidget {
  const AddToFavorites({super.key});

  @override
  State<AddToFavorites> createState() => _AddToFavoritesState();
}

class _AddToFavoritesState extends State<AddToFavorites> {
  @override
  void initState() {
    super.initState();
    isFavorite();
    // Chame a função desejada aqui
  }

  final FavoritesC favoritesC = Get.put(FavoritesC());
  final RandomC randomC = Get.put(RandomC());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: (favoritesC.isFavorite.value == false)
            ? addFavorite
            : deleteFavorite,
        child: Row(
          children: [
            Icon(favoritesC.isFavorite.value == false
                ? Icons.favorite_outline
                : Icons.favorite),
            const SizedBox(
              width: 5,
            ),
            Text(favoritesC.isFavorite.value == false
                ? 'Add to favorites'
                : 'Remove from favorites'),
          ],
        ),
      ),
    );
  }

  Future<void> addFavorite() async {
    var db = FirebaseFirestore.instance;

    final favorite = {
      'word': randomC.wordSearch,
      'json': jsonEncode(randomC.responseSave),
    };

    try {
      await db
          .collection("favorites")
          .doc(randomC.wordSearch)
          .set(favorite)
          .onError((e, _) => print("Error writing document: $e"));

      print('Dados inseridos com sucesso!');
      favoritesC.isFavorite.value = true;
    } catch (e) {
      print('Erro ao inserir dados: $e');
    }
  }

  Future<void> deleteFavorite() async {
    var db = FirebaseFirestore.instance;

    try {
      await db.collection("favorites").doc(randomC.wordSearch).delete().then(
            (doc) => print("Document deleted"),
            onError: (e) => print("Error updating document $e"),
          );
      favoritesC.isFavorite.value = false;
      print('Dados deletados com sucesso!');
    } catch (e) {
      print('Erro ao inserir dados: $e');
    }
  }

  Future<void> isFavorite() async {
    var db = FirebaseFirestore.instance;

    try {
      await db
          .collection("favorites")
          .where("word", isEqualTo: randomC.wordSearch)
          .get()
          .then(
        (querySnapshot) {
          print("Successfully completed");
          print(querySnapshot);

          for (var docSnapshot in querySnapshot.docs) {
            favoritesC.isFavorite.value =
                (docSnapshot.id == randomC.wordSearch) ? true : false;
            print('${docSnapshot.id} => ${docSnapshot.data()}');
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
    } catch (e) {
      print('Erro na busca: $e');
    }
  }
}
