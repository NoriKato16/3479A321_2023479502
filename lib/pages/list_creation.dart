import 'package:flutter/material.dart';

class ListCreationScreen extends StatelessWidget {
  // Fuente de datos (lista de creaciones)
  final List<String> creaciones = const [
    'Aji',
    'Pizza',
    'Sandia',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Creaciones en Pixel Art')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: creaciones.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = creaciones[index];
          return ListTile(
            leading: const Icon(Icons.brush),
            title: Text(item),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Abrir: $item')),
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