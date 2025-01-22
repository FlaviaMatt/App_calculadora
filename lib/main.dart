// main.dart
import 'package:flutter/material.dart';
import 'calculadora.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Calculadora(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
      ),
    );
  }
}