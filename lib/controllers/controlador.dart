import '../models/modelo.dart';

class BibleController {
  late List<String> books;
  late List<int> chapters;
  late List<int> verses;
  late String selectedBook;
  late int selectedChapter;
  late int selectedVerse;

  void loadBooks() {
    // Simulate loading books from a remote API
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
      'Amos',
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
      'Colossenses',
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
    // Simulate loading chapters for the selected book from a remote API
    chapters = [for (var i = 1; i <= 2; i++) i];
    selectedChapter = chapters.first;
    loadVerses();
  }

  void loadVerses() {
    // Simulate loading verses for the selected book and chapter from a remote API
    verses = [for (var i = 1; i <= 31; i++) i];
    selectedVerse = verses.first;
  }

  Future<String> fetchVerse() async {
    final verse = BibleVerse(selectedBook, selectedChapter, selectedVerse);
    return await BibleAPI.fetchVerse(verse);
  }
}
