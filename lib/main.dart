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
    'Éxodo'
  ]; // Agrega aquí más libros si es necesario

  Map<String, List<int>> chapters = {
    'Génesis': [1, 2], // Agrega aquí los números de los capítulos de Génesis
    'Éxodo': [1, 2], // Agrega aquí los números de los capítulos de Éxodo
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
