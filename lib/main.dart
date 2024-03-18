import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seleccionar Versículo de la Biblia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BibleSelectionPage(),
    );
  }
}

class BibleSelectionPage extends StatefulWidget {
  const BibleSelectionPage({super.key});

  @override
  _BibleSelectionPageState createState() => _BibleSelectionPageState();
}

class _BibleSelectionPageState extends State<BibleSelectionPage> {
  late String selectedBook;
  late int selectedChapter;
  late int selectedVerse;

  List<String> books = [
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
    'Hageo',
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

  Map<String, List<int>> chapters = {
    'Génesis': [1, 2],
    'Éxodo': [1, 2],
    'Levítico': [1, 2],
    'Números': [1, 2],
    'Deuteronomio': [1, 2],
    'Josué': [1, 2],
    'Jueces': [1, 2],
    'Rut': [1, 2],
    '1 Samuel': [1, 2],
    '2 Samuel': [1, 2],
    '1 Reyes': [1, 2],
    '2 Reyes': [1, 2],
    '1 Crónicas': [1, 2],
    '2 Crónicas': [1, 2],
    'Esdras': [1, 2],
    'Nehemías': [1, 2],
    'Ester': [1, 2],
    'Job': [1, 2],
    'Salmos': [1, 2],
    'Proverbios': [1, 2],
    'Eclesiastés': [1, 2],
    'Cantar de los Cantares': [1, 2],
    'Isaías': [1, 2],
    'Jeremías': [1, 2],
    'Lamentaciones': [1, 2],
    'Ezequiel': [1, 2],
    'Daniel': [1, 2],
    'Oseas': [1, 2],
    'Joel': [1, 2],
    'Amós': [1, 2],
    'Abdías': [1],
    'Jonás': [1, 2],
    'Miqueas': [1, 2],
    'Nahúm': [1, 2],
    'Habacuc': [1, 2],
    'Sofonías': [1, 2],
    'Hageo': [1, 2],
    'Zacarías': [1, 2],
    'Malaquías': [1, 2],
    'Mateo': [1, 2],
    'Marcos': [1, 2],
    'Lucas': [1, 2],
    'Juan': [1, 2],
    'Hechos': [1, 2],
    'Romanos': [1, 2],
    '1 Corintios': [1, 2],
    '2 Corintios': [1, 2],
    'Gálatas': [1, 2],
    'Efesios': [1, 2],
    'Filipenses': [1, 2],
    'Colosenses': [1, 2],
    '1 Tesalonicenses': [1, 2],
    '2 Tesalonicenses': [1, 2],
    '1 Timoteo': [1, 2],
    '2 Timoteo': [1, 2],
    'Tito': [1, 2],
    'Filemón': [1],
    'Hebreos': [1, 2],
    'Santiago': [1, 2],
    '1 Pedro': [1, 2],
    '2 Pedro': [1, 2],
    '1 Juan': [1, 2],
    '2 Juan': [1],
    '3 Juan': [1, 2],
    'Judas': [1],
    'Apocalipsis': [1, 2]
  };

  Map<int, int> verses = {
    1: 31, // Número de versículos para el capítulo 1 de Génesis
    2: 24, // Número de versículos para el capítulo 2 de Génesis
  };

  String baseUrl =
      'https://api-biblia-libre-default-rtdb.firebaseio.com/libros/';

  Future<String> fetchVerse(String book, int chapter, int verse) async {
    final response = await http.get(
        Uri.parse('$baseUrl$book/capitulos/$chapter/versiculos/$verse.json'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load verse');
    }
  }

  @override
  void initState() {
    super.initState();
    selectedBook = books.first;
    selectedChapter = chapters[selectedBook]!.first;
    selectedVerse = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Versículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedBook,
              items: books.map((String book) {
                return DropdownMenuItem<String>(
                  value: book,
                  child: Text(book),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedBook = newValue!;
                  selectedChapter = chapters[selectedBook]!.first;
                  selectedVerse = 1;
                });
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<int>(
              value: selectedChapter,
              items: chapters[selectedBook]!.map((int chapter) {
                return DropdownMenuItem<int>(
                  value: chapter,
                  child: Text('Capítulo $chapter'),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  selectedChapter = newValue!;
                  selectedVerse = 1;
                });
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<int>(
              value: selectedVerse,
              items: List.generate(
                verses[selectedChapter]!,
                (index) => DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text('Versículo ${index + 1}'),
                ),
              ),
              onChanged: (int? newValue) {
                setState(() {
                  selectedVerse = newValue!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                fetchVerse(selectedBook, selectedChapter, selectedVerse)
                    .then((verse) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(verse),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cerrar'),
                          ),
                        ],
                      );
                    },
                  );
                }).catchError((error) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('No se pudo cargar el versículo.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cerrar'),
                          ),
                        ],
                      );
                    },
                  );
                });
              },
              child: const Text('Seleccionar'),
            ),
          ],
        ),
      ),
    );
  }
}
