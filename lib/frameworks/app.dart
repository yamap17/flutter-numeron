import 'package:flutter/material.dart';
import 'package:numeron/providers/game_provider.dart';
import 'package:numeron/views/home_page.dart';
import 'package:provider/provider.dart';

class NumeronApp extends StatelessWidget {
  const NumeronApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(
            create: (context) => GameProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Numer0n',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomePage(title: 'Numer0n'),
        ));
  }
}
