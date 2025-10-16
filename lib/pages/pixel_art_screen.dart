import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '/providers/ConfigurationData.dart';


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
            border:
                selected ? Border.all(color: Colors.black, width: 2) : null,
          ),
          width: selected ? 36 : 28,
          height: selected ? 36 : 28,
        ),
      );
    }).toList();
  }
}