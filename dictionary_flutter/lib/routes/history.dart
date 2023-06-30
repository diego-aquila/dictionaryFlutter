import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favoritesC.dart';
import '../controllers/historyC.dart';
import '../controllers/randomC.dart';
import '../util/capitalize.dart';
import '../util/messages.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    hasHistory();
  }

  final FavoritesC favoritesC = Get.put(FavoritesC());
  final HistoryC historyC = Get.put(HistoryC());

  final RandomC randomC = Get.put(RandomC());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          automaticallyImplyLeading: false,
        ),
        body: historyC.hasHistory.value ? bodyHistory() : bodyNoHasData(),
      ),
    );
  }

  Widget bodyHistory() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('historico').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            var document = snapshot.data!.docs[index];
            var data = document.data();
            return Dismissible(
              key: Key(document.id),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                FirebaseFirestore.instance
                    .collection('historico')
                    .doc(document.id)
                    .delete();

                messageDelete(context, document.id, 'history');
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
    );
  }

  Widget bodyNoHasData() {
    return const Padding(
      padding: EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text(
            "There is no navigation history between words yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF313131),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> hasHistory() async {
    var db = FirebaseFirestore.instance;

    try {
      await db.collection("historico").get().then(
        (querySnapshot) {
          if (querySnapshot.docs == []) {
            historyC.hasHistory.value = false;
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
    } catch (e) {
      print('Erro na busca: $e');
    }
  }
}
