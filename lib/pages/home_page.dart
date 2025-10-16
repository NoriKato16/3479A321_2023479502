import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'list_art.dart';
import 'about.dart';
import 'list_creation.dart';
import 'pixel_art_screen.dart';
import 'config_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 35, 190, 53),
        ),
        textTheme: GoogleFonts.arizoniaTextTheme(),
      ),
      home: const MyHomePage(title: '2023479502'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _color = Colors.cyanAccent;
  final Color _newColor = Colors.red;

  void _incrementCounter() => setState(() {
        _counter++;
      });

  void _decrementCounter() => setState(() {
        _counter--;
      });

  void _restartCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _setColor() {
    setState(() {
      if (_color != Colors.green) {
        _color = Colors.green;
      } else {
        _color = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    logger.d("Logger is working!");

    var persistentFooterButtons = [
      FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: _newColor,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
      FloatingActionButton(
        onPressed: _decrementCounter,
        tooltip: 'Decrementar',
        child: const Icon(Icons.remove),
      ),
      FloatingActionButton(
        onPressed: _restartCounter,
        tooltip: 'Restaurar',
        child: const Icon(Icons.refresh),
      ),
      FloatingActionButton(
        onPressed: _setColor,
        backgroundColor: _color,
        tooltip: 'Custom Action',
        child: const Icon(Icons.star),
      ),
    ];

    var scaffold = Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'about') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AboutScreen()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem<String>(value: 'about', child: Text('About')),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Card(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Pixel Art sobre una grilla personalizable'),

                // Scroll horizontal para las imagenes
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Image.asset('assets/Pixel-Art-Hot-Pepper-2-1.webp',
                          width: 400),
                      Image.asset('assets/Pixel-Art-Pizza-2.webp', width: 400),
                      Image.asset('assets/Pixel-Art-Watermelon-3.webp',
                          width: 400),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Botones principales 
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.info_outline),
                      label: const Text('About'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AboutScreen()),
                        );
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.image),
                      label: const Text('Lista de Pixel Art'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ListArtScreen()),
                        );
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.image),
                      label: const Text('Lista de Creaciones en Pixel Art'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ListCreationScreen()),
                        );
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.grid_on),
                      label: const Text('PixelArt Screen'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PixelArtScreen( ),
                          ),
                        );
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.settings),
                      label: const Text('Configuración'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ConfigScreen()),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Contador
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: 20),

                // Acciones inferiores
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: null,
                      backgroundColor: _color,
                      tooltip: 'Crear',
                      child: const Icon(Icons.create),
                    ),
                    const SizedBox(width: 12),
                    FloatingActionButton(
                      onPressed: null,
                      backgroundColor: _color,
                      tooltip: 'Compartir',
                      child: const Icon(Icons.share),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: persistentFooterButtons,
    );
    return scaffold;
  }
}
