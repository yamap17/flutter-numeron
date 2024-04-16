import 'package:flutter/material.dart';
import 'package:numeron/ui/game/screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return GameScreen(
                      title: '1人で遊ぶ',
                    );
                  }),
                );
              },
              child: const Text('1人で遊ぶ'),
            ),
          )
        ]));
  }
}
