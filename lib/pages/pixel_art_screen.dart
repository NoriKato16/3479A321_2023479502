import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '/providers/ConfigurationData.dart';

class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({super.key, required this.title});

  final String title;

  @override
  State<PixelArtScreen> createState() => _PixelArtScreenState();
}

class _PixelArtScreenState extends State<PixelArtScreen> {
  int _counter = 0;
  Color _color = Colors.cyanAccent;
  final logger = Logger();
  int _sizeGrid = 0;

  @override
  void initState() {
    super.initState();
    _sizeGrid = context.read<ConfigurationData>().size;
    logger.d("se llama a inistate");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d("se llama a didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant PixelArtScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d("se llama a didupdate");
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    logger.d("se llama a setState");
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.d("se llama a deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    logger.d("se llama a dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.d("se llama a reassemble");
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.d("build de dibujar el widget");
    int providerSize = context.watch<ConfigurationData>().size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Pixel Art sobre una grilla personalizable'),
              const SizedBox(height: 20),

              // Muestra el valor local del contador
              Text(
                'Contador local: $_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 20),

              // Muestra el valor compartido del Provider
              Text(
                'Tamaño (Provider): $providerSize',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  context.read<ConfigurationData>().setSize(providerSize + 1);
                },
                child: const Text("Incrementar Provider"),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text("Incrementar local"),
              ),
            ],
          ),
        ),
      ),
    );
  }//widget build

  
}
