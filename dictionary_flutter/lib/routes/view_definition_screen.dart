import 'package:dictionary_flutter/components/add_to_favorites.dart';
import 'package:dictionary_flutter/util/capitalize.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/randomC.dart';

class ShowWordsPage extends StatefulWidget {
  const ShowWordsPage({super.key});

  @override
  State<ShowWordsPage> createState() => _ShowWordsPageState();
}

class _ShowWordsPageState extends State<ShowWordsPage> {
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
    createPartOfSpeechSet();
  }

  final partOfSpeechSet = [];
  final RandomC randomC = Get.put(RandomC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Definition Page'),
      ),
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                  decoration: const BoxDecoration(
                      color: Color(0xFFDEDEDE),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: Get.width,
                  height: 290,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        randomC.responseSave["word"],
                        style: const TextStyle(
                          fontSize: 48,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "PHONETIC RESPELLING:",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        "/ ${randomC.responseSave["pronunciation"]["all"]} /",
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "LISTEN TO PRONUNCIATION:",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.play_circle_fill),
                        iconSize: 50,
                        onPressed: () {
                          playAudio(randomC.responseSave["word"]);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const AddToFavorites(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Definitions:",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                for (var part in partOfSpeechSet)
                  for (var item in randomC.responseSave["results"] ?? [])
                    if (part == item["partOfSpeech"])
                      // ignore: curly_braces_in_flow_control_structures
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item["partOfSpeech"] != null)
                            Text(
                                "Part of speech: (${capitalizeFirstLetter(item["partOfSpeech"])})"),
                          Text(
                            "• ${capitalizeFirstLetter(item["definition"])}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (item["examples"] != null)
                            const SizedBox(
                              height: 10,
                            ),
                          if (item["examples"] != null)
                            const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                "Example:",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          if (item["examples"] != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                  capitalizeFirstLetter(item["examples"][0])),
                            ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> playAudio(String word) async {
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(0.2);
    await flutterTts.speak(word);
  }

  createPartOfSpeechSet() {
    for (var result in randomC.responseSave["results"] ?? []) {
      if (result['partOfSpeech'] != null) {
        if (!partOfSpeechSet.contains(result['partOfSpeech'])) {
          partOfSpeechSet.add(result['partOfSpeech']);
        }
      }
    }
  }
}
