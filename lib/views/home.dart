import 'package:biblia_libre/views/vista.dart';
import 'package:biblia_libre/controllers/controlador.dart'; // Asegúrate de tener la ruta correcta
import 'package:flutter/material.dart';
import 'layouts/mainlayout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BibleController _controller;
  String dailyVerse = 'Cargando versículo...';

  @override
  void initState() {
    super.initState();
    _controller = BibleController();
    initializeData();
  }

  void initializeData() {
    _controller
        .loadBooks(); // Asegúrate de que esta función carga los libros correctamente
    loadRandomVerse();
  }

  void loadRandomVerse() async {
    try {
      String verse = await _controller.fetchRandomVerse();
      setState(() {
        dailyVerse = verse;
      });
    } catch (e) {
      setState(() {
        dailyVerse = 'Error al cargar el versículo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 0,
      bodyContent: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            Text(
              'Maná Diario',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  dailyVerse, // Aquí se muestra el versículo aleatorio
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            // Aquí pueden seguir otros elementos de tu página de inicio...
          ],
        ),
      ),
    );
  }
}

class BiblePage extends StatelessWidget {
  const BiblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      selectedIndex: 1,
      bodyContent: BibleSelectionPage(),
    );
  }
}
