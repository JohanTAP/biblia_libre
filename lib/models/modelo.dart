import 'dart:convert';
import 'package:http/http.dart' as http;

class BibleVerse {
  final String book;
  final int chapter;
  final int verse;

  BibleVerse(this.book, this.chapter, this.verse);
}

class BibleAPI {
  static Future<String> fetchVerse(BibleVerse verse) async {
    const baseUrl =
        'https://api-biblia-libre-default-rtdb.firebaseio.com/libros/';
    final response = await http.get(Uri.parse(
        '$baseUrl${verse.book}/capitulos/${verse.chapter}/versiculos/${verse.verse}.json'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load verse');
    }
  }
}
