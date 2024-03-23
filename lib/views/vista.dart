import 'package:flutter/material.dart';
import '../controllers/controlador.dart';

class BibleSelectionPage extends StatefulWidget {
  const BibleSelectionPage({super.key});

  @override
  _BibleSelectionPageState createState() => _BibleSelectionPageState();
}

class _BibleSelectionPageState extends State<BibleSelectionPage> {
  late BibleController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BibleController();
    _controller.loadBooks();
  }

  // Nuevo método para manejar la selección de un capítulo y cargar los versículos
  void _onChapterSelected(int? newValue) async {
    if (newValue == null) return;
    setState(() {
      _controller.selectedChapter = newValue;
    });
    await _controller.loadVersesFromAPI();
    setState(() {});
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
              value: _controller.selectedBook,
              items: _controller.books.map((book) {
                return DropdownMenuItem<String>(
                  value: book,
                  child: Text(book),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _controller.selectedBook = newValue!;
                  _controller.loadChapters();
                });
                _controller.loadVersesFromAPI();
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<int>(
              value: _controller.selectedChapter,
              items: _controller.chapters.map((chapter) {
                return DropdownMenuItem<int>(
                  value: chapter,
                  child: Text('Capítulo $chapter'),
                );
              }).toList(),
              onChanged: _onChapterSelected,
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<int>(
              value: _controller.selectedVerse,
              items: _controller.verses.map((verse) {
                return DropdownMenuItem<int>(
                  value: verse,
                  child: Text('Versículo $verse'),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  _controller.selectedVerse = newValue!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _controller.fetchVerse().then((verse) {
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
