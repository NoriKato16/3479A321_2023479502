import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '/providers/ConfigurationData.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({super.key});

  @override
  State<PixelArtScreen> createState() => _PixelArtScreenState();
}

class _PixelArtScreenState extends State<PixelArtScreen> {
  final Logger logger = Logger();
  int _sizeGrid = 16;
  Color _selectedColor = Colors.black;
  late List<Color> _cellColors;

  @override
  void initState() {
    super.initState();
    _sizeGrid = context.read<ConfigurationData>().size;
    _cellColors = List<Color>.filled(_sizeGrid * _sizeGrid, Colors.transparent);
    logger.d("PixelArtScreen initialized.");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sizeGrid = context.watch<ConfigurationData>().size;
  }

  @override
  Widget build(BuildContext context) {
    final config = context.watch<ConfigurationData>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation Process'),
        actions: [
          Row(
            children: [
              const Text('Números'),
              Switch(
                value: config.showNumbers,
                onChanged: (value) {
                  config.setShowNumbers(value);
                  logger.d("Mostrar números: $value");
                },
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('${config.size} x ${config.size}'),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _sizeGrid,
                ),
                itemCount: _sizeGrid * _sizeGrid,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => _cellColors[index] = _selectedColor);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(1),
                      color: _cellColors[index],
                      child: config.showNumbers
                          ? Center(
                              child: Text(
                                '$index',
                                style: TextStyle(
                                  color: _cellColors[index] == Colors.black
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
            // Paleta de colores
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.grey[200],
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildColorPalette(),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _savePixelArt,
        tooltip: 'Guardar imagen',
        child: const Icon(Icons.save),
      ),
    );
  }

  List<Widget> _buildColorPalette() {
    final colors = [
      Colors.black,
      Colors.white,
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.brown,
      Colors.grey,
      Colors.pink,
    ];
    return colors.map((color) {
      final selected = color == _selectedColor;
      return GestureDetector(
        onTap: () => setState(() => _selectedColor = color),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.all(selected ? 12 : 8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: selected ? Border.all(color: Colors.black, width: 2) : null,
          ),
          width: selected ? 36 : 28,
          height: selected ? 36 : 28,
        ),
      );
    }).toList();
  }

  Future<void> _savePixelArt() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromLTWH(0, 0, _sizeGrid * 20.0, _sizeGrid * 20.0),
    );
    for (int row = 0; row < _sizeGrid; row++) {
      for (int col = 0; col < _sizeGrid; col++) {
        final color = _cellColors[row * _sizeGrid + col];
        final paint = Paint()..color = color;
        final rect = Rect.fromLTWH(col * 20.0, row * 20.0, 20.0, 20.0);
        canvas.drawRect(rect, paint);
      }
    }
    final picture = recorder.endRecording();
    final image = await picture.toImage(_sizeGrid * 20, _sizeGrid * 20);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final imageBytes = byteData!.buffer.asUint8List();
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/pixel_art_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(filePath);
    await file.writeAsBytes(imageBytes);
    logger.d("Pixel art saved to: $filePath");
    context.read<ConfigurationData>().addCreation(filePath);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Pixel art saved to: $filePath')));
  }
}
