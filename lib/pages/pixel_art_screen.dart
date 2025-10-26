import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '/providers/ConfigurationData.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  File? _backgroundImage;

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
    final hasImage = _backgroundImage != null;

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
            // Sección de controles superior
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Text('${config.size} x ${config.size}'),
                  const SizedBox(height: 8),
                  
                  // Botón tomar foto
                  ElevatedButton.icon(
                    onPressed: _takePicture,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Tomar foto'),
                  ),
                  
                  // Mostrar controles si hay imagen
                  if (hasImage) ...[
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _deleteBackgroundImage,
                      icon: const Icon(Icons.delete),
                      label: const Text('Eliminar fondo'),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Ajustar Opacidad',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Slider(
                      value: config.backgroundOpacity,
                      min: 0.1,
                      max: 1.0,
                      divisions: 10,
                      label: '${(config.backgroundOpacity * 100).toInt()}%',
                      onChanged: (value) {
                        config.setBackgroundOpacity(value);
                      },
                    ),
                    Text(
                      'Opacidad: ${(config.backgroundOpacity * 100).toInt()}%',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),
            
            // Grid de pixel art
            Expanded(
              child: Stack(
                children: [
                  Container(color: Colors.grey[100]),
                  
                  // Imagen de fondo
                  if (hasImage)
                    Opacity(
                      opacity: config.backgroundOpacity,
                      child: Image.file(
                        _backgroundImage!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  
                  // Grid
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
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
                        ),
                      );
                    },
                  ),
                ],
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
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pixel art guardado: $filePath')),
      );
    }
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/background_image.png';
      final newImage = File(pickedFile.path);

      if (_backgroundImage != null && await _backgroundImage!.exists()) {
        await _backgroundImage!.delete();
      }

      await newImage.copy(filePath);

      setState(() {
        _backgroundImage = File(filePath);
      });
      
      logger.d("Imagen guardada. _backgroundImage != null: ${_backgroundImage != null}");
    }
  }

  void _deleteBackgroundImage() {
    if (_backgroundImage != null && _backgroundImage!.existsSync()) {
      _backgroundImage!.deleteSync();
    }
    setState(() {
      _backgroundImage = null;
    });
    
    logger.d("Imagen eliminada. _backgroundImage != null: ${_backgroundImage != null}");
  }
}