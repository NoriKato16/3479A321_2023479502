import 'package:flutter/material.dart';
import 'package:flutter_lab2/pages/about.dart';
import 'package:flutter_lab2/pages/list_creation.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home_page.dart'; 
import 'pages/list_art.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 35, 190, 53),
        ),
        textTheme: GoogleFonts.arizoniaTextTheme(),
      ),
      //home: const MyHomePage(title: '2023479502'),
      //home: ListArtScreen() ,
      //home: ListCreationScreen(),
      home: AboutScreen(),
    );
  }
}
