import 'package:flutter/material.dart';
import 'package:numeron/ui/auth/google_signin.dart';
import 'package:numeron/ui/game/provider.dart';
import 'package:numeron/ui/home/provider.dart';
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
          home: const GoogleSignin(),
        ));
  }
}
