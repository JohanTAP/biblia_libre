import 'package:flutter/material.dart';
import 'views/vista.dart';

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
