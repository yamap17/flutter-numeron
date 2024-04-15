import 'package:flutter/material.dart';
import 'package:numeron/ui/home/provider.dart';
import 'package:numeron/ui/home/screen.dart';
import 'package:numeron/ui/practice/provider.dart';
import 'package:provider/provider.dart';

class NumeronApp extends StatelessWidget {
  const NumeronApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider(),
          ),
          ChangeNotifierProvider<PracticeProvider>(
            create: (context) => PracticeProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Numer0n',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen(title: 'Numer0n'),
        ));
  }
}
