// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bengkelin/views/splash_scren.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bengkelin',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sesuaikan dengan tema aplikasi Anda
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}
