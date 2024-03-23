import 'dart:convert';
import 'dart:math';

import '../models/modelo.dart';
import 'package:http/http.dart' as http;

class BibleController {
  late List<String> books;
  late List<int> chapters;
  late List<int> verses;
  late String selectedBook;
  late int selectedChapter;
  late int selectedVerse;

  BibleController() {
    chapters = <int>[];
  }

  void loadBooks() {
    books = [
      'Génesis',
      'Éxodo',
      'Levítico',
      'Números',
      'Deuteronomio',
      'Josué',
      'Jueces',
      'Rut',
      '1 Samuel',
      '2 Samuel',
      '1 Reyes',
      '2 Reyes',
      '1 Crónicas',
      '2 Crónicas',
      'Esdras',
      'Nehemías',
      'Ester',
      'Job',
      'Salmos',
      'Proverbios',
      'Eclesiastés',
      'Cantar de los Cantares',
      'Isaías',
      'Jeremías',
      'Lamentaciones',
      'Ezequiel',
      'Daniel',
      'Oseas',
      'Joel',
      'Amós',
      'Abdías',
      'Jonás',
      'Miqueas',
      'Nahúm',
      'Habacuc',
      'Sofonías',
      'Ageo',
      'Zacarías',
      'Malaquías',
      'Mateo',
      'Marcos',
      'Lucas',
      'Juan',
      'Hechos',
      'Romanos',
      '1 Corintios',
      '2 Corintios',
      'Gálatas',
      'Efesios',
      'Filipenses',
      'Colosenses',
      '1 Tesalonicenses',
      '2 Tesalonicenses',
      '1 Timoteo',
      '2 Timoteo',
      'Tito',
      'Filemón',
      'Hebreos',
      'Santiago',
      '1 Pedro',
      '2 Pedro',
      '1 Juan',
      '2 Juan',
      '3 Juan',
      'Judas',
      'Apocalipsis'
    ];
    selectedBook = books.first;
    loadChapters();
  }

  void loadChapters() {
    final Map<String, List<int>> chaptersMap = {
      'Génesis': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        35,
        36,
        37,
        38,
        39,
        40,
        41,
        42,
        43,
        44,
        45,
        46,
        47,
        48,
        49,
        50,
      ],
      'Éxodo': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        35,
        36,
        37,
        38,
        39,
        40
      ],
      'Levítico': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27
      ],
      'Números': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        35,
        36
      ],
      'Deuteronomio': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34
      ],
      'Josué': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24
      ],
      'Jueces': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21
      ],
      'Rut': [1, 2, 3, 4],
      '1 Samuel': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31
      ],
      '2 Samuel': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24
      ],
      '1 Reyes': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22
      ],
      '2 Reyes': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25
      ],
      '1 Crónicas': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29
      ],
      '2 Crónicas': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        35,
        36
      ],
      'Esdras': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
      'Nehemías': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
      'Ester': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
      'Job': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        35,
        36,
        37,
        38,
        39,
        40,
        41,
        42
      ],
      'Salmos': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        35,
        36,
        37,
        38,
        39,
        40,
        41,
        42,
        43,
        44,
        45,
        46,
        47,
        48,
        49,
        50,
        51,
        52,
        53,
        54,
        55,
        56,
        57,
        58,
        59,
        60,
        61,
        62,
        63,
        64,
        65,
        66,
        67,
        68,
        69,
        70,
        71,
        72,
        73,
        74,
        75,
        76,
        77,
        78,
        79,
        80,
        81,
        82,
        83,
        84,
        85,
        86,
        87,
        88,
        89,
        90,
        91,
        92,
        93,
        94,
        95,
        96,
        97,
        98,
        99,
        100,
        101,
        102,
        103,
        104,
        105,
        106,
        107,
        108,
        109,
        110,
        111,
        112,
        113,
        114,
        115,
        116,
        117,
        118,
        119,
        120,
        121,
        122,
        123,
        124,
        125,
        126,
        127,
        128,
        129,
        130,
        131,
        132,
        133,
        134,
        135,
        136,
        137,
        138,
        139,
        140,
        141,
        142,
        143,
        144,
        145,
        146,
        147,
        148,
        149,
        150
      ],
      'Proverbios': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31
      ],
      'Eclesiastés': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'Cantar de los Cantares': [1, 2, 3, 4, 5, 6, 7, 8],
      'Isaías': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        35,
        36,
        37,
        38,
        39,
        40,
        41,
        42,
        43,
        44,
        45,
        46,
        47,
        48,
        49,
        50,
        51,
        52,
        53,
        54,
        55,
        56,
        57,
        58,
        59,
        60,
        61,
        62,
        63,
        64,
        65,
        66
      ],
      'Jeremías': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        35,
        36,
        37,
        38,
        39,
        40,
        41,
        42,
        43,
        44,
        45,
        46,
        47,
        48,
        49,
        50,
        51,
        52
      ],
      'Lamentaciones': [1, 2, 3, 4, 5],
      'Ezequiel': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        35,
        36,
        37,
        38,
        39,
        40,
        41,
        42,
        43,
        44,
        45,
        46,
        47,
        48
      ],
      'Daniel': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'Oseas': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
      'Joel': [1, 2, 3],
      'Amós': [1, 2, 3, 4, 5, 6, 7, 8, 9],
      'Abdías': [1],
      'Jonás': [1, 2, 3, 4],
      'Miqueas': [1, 2, 3, 4, 5, 6, 7],
      'Nahúm': [1, 2, 3],
      'Habacuc': [1, 2, 3],
      'Sofonías': [1, 2, 3],
      'Ageo': [1, 2],
      'Zacarías': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
      'Malaquías': [1, 2, 3, 4],
      'Mateo': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28
      ],
      'Marcos': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
      'Lucas': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24
      ],
      'Juan': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21
      ],
      'Hechos': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28
      ],
      'Romanos': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
      '1 Corintios': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
      '2 Corintios': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
      'Gálatas': [1, 2, 3, 4, 5, 6],
      'Efesios': [1, 2, 3, 4, 5, 6],
      'Filipenses': [1, 2, 3, 4],
      'Colosenses': [1, 2, 3, 4],
      '1 Tesalonicenses': [1, 2, 3, 4, 5],
      '2 Tesalonicenses': [1, 2, 3],
      '1 Timoteo': [1, 2, 3, 4, 5, 6],
      '2 Timoteo': [1, 2, 3, 4],
      'Tito': [1, 2, 3],
      'Filemón': [1],
      'Hebreos': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
      'Santiago': [1, 2, 3, 4, 5],
      '1 Pedro': [1, 2, 3, 4, 5],
      '2 Pedro': [1, 2, 3],
      '1 Juan': [1, 2, 3, 4, 5],
      '2 Juan': [1],
      '3 Juan': [1],
      'Judas': [1],
      'Apocalipsis': [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22
      ]
    };
    chapters = chaptersMap[selectedBook]!;
    selectedChapter = chapters.first;
    loadVerses();
  }

  void loadVerses() {
    verses = [for (var i = 1; i <= 31; i++) i];
    selectedVerse = verses.first;
  }

  Future<String> fetchVerse() async {
    final verse = BibleVerse(selectedBook, selectedChapter, selectedVerse);
    return await BibleAPI.fetchVerse(verse);
  }

// Nuevo método para cargar versículos desde la API
  Future<void> loadVersesFromAPI() async {
    try {
      final String url =
          'https://api-biblia-libre-default-rtdb.firebaseio.com/libros/$selectedBook/capitulos/$selectedChapter/versiculos.json';

      print("URL de la solicitud: $url");

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Suponiendo que la respuesta es una lista de versículos
        final List<dynamic> versiculosJson = json.decode(response.body);

        print("Respuesta de la API: ${response.body}");

        // El primer elemento en la lista es nulo, así que lo omitimos y contamos el resto
        verses = [for (var i = 1; i < versiculosJson.length; i++) i];
        selectedVerse = verses.isNotEmpty ? verses.first : 0;
      } else {
        // Manejar errores de la API o respuestas inesperadas
        print('Error al cargar los versículos: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar excepciones de la solicitud HTTP o del parsing JSON
      print('Error al cargar los versículos: $e');
    }
  }

  Future<String> fetchRandomVerse() async {
    // Primero, selecciona un libro al azar
    Random rand = Random();
    String randomBook = books[rand.nextInt(books.length)];

    // Luego, obtén la cantidad de capítulos para ese libro
    final chaptersUrl =
        'https://api-biblia-libre-default-rtdb.firebaseio.com/libros/$randomBook.json';
    var chaptersResponse = await http.get(Uri.parse(chaptersUrl));
    if (chaptersResponse.statusCode == 200) {
      final chaptersJson = json.decode(chaptersResponse.body);
      List<dynamic> chaptersList = chaptersJson['capitulos'] as List<dynamic>;

      // Selecciona un capítulo al azar
      int randomChapter = rand.nextInt(chaptersList.length) +
          1; // Asumiendo que los capítulos comienzan en 1

      // Ahora, obtén la cantidad de versículos para el capítulo seleccionado
      final versesUrl =
          'https://api-biblia-libre-default-rtdb.firebaseio.com/libros/$randomBook/capitulos/$randomChapter.json';
      var versesResponse = await http.get(Uri.parse(versesUrl));
      if (versesResponse.statusCode == 200) {
        final versesJson = json.decode(versesResponse.body);
        List<dynamic> versesList = versesJson['versiculos'] as List<dynamic>;

        // Selecciona un versículo al azar
        int randomVerseNumber = rand.nextInt(versesList.length - 1) +
            1; // Asumiendo que el primer elemento es nulo

        // Construye el versículo aleatorio seleccionado
        String randomVerse = versesList[randomVerseNumber];
        return '$randomBook $randomChapter:$randomVerseNumber - $randomVerse';
      } else {
        throw Exception('Failed to load verses');
      }
    } else {
      throw Exception('Failed to load chapters');
    }
  }
}
