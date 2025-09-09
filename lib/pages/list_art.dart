import 'package:flutter/material.dart';

class ListArtScreen extends StatelessWidget {
  // a) Variable tipo Lista<String> con el contenido a mostrar
  final List<String> elementos = const [
    'Hot Pepper',
    'Pizza',
    'Watermelon'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista_art')),

      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: elementos.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = elementos[index];
          return ListTile(
            leading: const Icon(Icons.image),
            title: Text(item),
            trailing: const Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }
}