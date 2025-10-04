import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/ConfigurationData.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    int currentSize = context.watch<ConfigurationData>().size;

    // Lista de valores permitidos
    final availableSizes = ["16", "18", "20", "24", "30"];

    // se valida que el valor inicial est dentro de la lista
    final initialSize = availableSizes.contains(currentSize.toString())
        ? currentSize.toString()
        : "16"; // si no hay coincidencia se deja un valor por defecto

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración Pixel Art"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tamaño del Pixel Art:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Dropdown para seleccionar los tamaños
            DropdownButtonFormField<String>(
              initialValue: initialSize,
              items: availableSizes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<ConfigurationData>().setSize(int.parse(value));
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Seleccione el tamaño",
              ),
            ),

            const SizedBox(height: 20),
            Text(
              "Valor actual desde Provider: $currentSize",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
