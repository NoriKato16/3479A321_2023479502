import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ListCreationScreen extends StatefulWidget {
  const ListCreationScreen({super.key});

  @override
  State<ListCreationScreen> createState() => _ListCreationScreenState();
}

class _ListCreationScreenState extends State<ListCreationScreen> {
  List<File> _imageFiles = [];

  @override
  void initState() {
    super.initState();
    _loadSavedImages();
  }

  Future<void> _loadSavedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = Directory(directory.path)
        .listSync()
        .where((item) => item.path.endsWith('.png'))
        .map((item) => File(item.path))
        .toList();

    setState(() {
      _imageFiles = files.reversed.toList(); // Muestra las últimas primero
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creaciones en Pixel Art'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recargar',
            onPressed: _loadSavedImages,
          ),
        ],
      ),
      body: _imageFiles.isEmpty
          ? const Center(
              child: Text('No hay imágenes guardadas aún.'),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: _imageFiles.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final file = _imageFiles[index];
                final fileName = file.path.split('/').last;

                return ListTile(
                  leading: Image.file(
                    file,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(fileName),
                  subtitle: Text(
                    file.path,
                    style: const TextStyle(fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Abrir: $fileName')),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
        label: const Text('Volver'),
      ),
    );
  }
}
