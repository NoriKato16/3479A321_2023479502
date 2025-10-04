import 'package:flutter/material.dart';

class ConfigurationData extends ChangeNotifier {
  int _size = 10; // valor inicial
  int get size => _size;

  void setSize(int newSize) {
    _size = newSize;
    notifyListeners(); 
  }
}
