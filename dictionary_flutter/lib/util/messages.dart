import 'package:dictionary_flutter/util/capitalize.dart';
import 'package:flutter/material.dart';

void messageDelete(BuildContext context, word, local) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(capitalizeFirstLetter('$word removed from $local')),
    ),
  );
}
