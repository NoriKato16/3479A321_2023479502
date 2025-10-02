import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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



  @override
  void initState() {
    super.initState();
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
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text("Incrementar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
