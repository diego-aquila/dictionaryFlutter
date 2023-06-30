import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary_flutter/controllers/favoritesC.dart';
import 'package:get/get.dart';

import '../controllers/randomC.dart';

class FirebaseService {
  final FavoritesC favoritesC = Get.put(FavoritesC());
  final RandomC randomC = Get.put(RandomC());

  static Future addDB(word, json, collection) async {
    var db = FirebaseFirestore.instance;

    final body = {
      'word': word,
      'json': jsonEncode(json),
    };

    try {
      await db
          .collection(collection)
          .doc(word)
          .set(body)
          .onError((e, _) => print("Error writing document: $e"));

      print('Dados inseridos com sucesso!');
      return true;
    } catch (e) {
      print('Erro ao inserir dados: $e');
    }
  }

  static Future deleteDB(word, collection) async {
    var db = FirebaseFirestore.instance;

    try {
      await db.collection(collection).doc(word).delete().then(
            (doc) => print("Document deleted"),
            onError: (e) => print("Error updating document $e"),
          );
      print('Dados deletados com sucesso!');
      return true;
    } catch (e) {
      print('Erro ao inserir dados: $e');
    }
  }
}
