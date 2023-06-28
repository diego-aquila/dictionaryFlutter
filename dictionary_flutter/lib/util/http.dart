import 'package:dictionary_flutter/components/randomC.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpService {
  final RandomC randomC = Get.put(RandomC());

  static Future getService(word, context) async {
    var response = await http.get(
        Uri.parse('https://wordsapiv1.p.rapidapi.com/words/$word'),
        headers: {
          "X-Mashape-Key": '0fe188ce76mshf6a73869a700e63p120506jsn0160ce171b16',
          'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com'
        });

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
