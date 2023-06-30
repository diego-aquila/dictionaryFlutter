import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary_flutter/controllers/favoritesC.dart';
import 'package:dictionary_flutter/controllers/randomC.dart';
import 'package:dictionary_flutter/util/firebase_service.dart';
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
  }

  final FavoritesC favoritesC = Get.put(FavoritesC());
  final RandomC randomC = Get.put(RandomC());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: (favoritesC.isFavorite.value == false)
            ? addFavoriteDB
            : delfavoriteDB,
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

  delfavoriteDB() async {
    var response =
        await FirebaseService.deleteDB(randomC.wordSearch, "favorites");
    if (response == true) {
      favoritesC.isFavorite.value = false;
    }
  }

  addFavoriteDB() async {
    var response = await FirebaseService.addDB(
        randomC.wordSearch, randomC.responseSave, "favorites");

    // ignore: unrelated_type_equality_checks
    if (response == true) {
      favoritesC.isFavorite.value = true;
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
          for (var docSnapshot in querySnapshot.docs) {
            favoritesC.isFavorite.value =
                (docSnapshot.id == randomC.wordSearch) ? true : false;
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
    } catch (e) {
      print('Erro na busca: $e');
    }
  }
}
