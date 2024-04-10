import 'package:flutter/material.dart';
import 'package:numeron/views/home_page.dart';

class NumeronApp extends StatelessWidget {
  const NumeronApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numer0n',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Numer0n'),
    );
  }
}
