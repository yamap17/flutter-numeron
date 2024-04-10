import 'package:flutter/material.dart';
import 'package:numeron/models/guess.dart';
import 'package:numeron/widgets/guess_card.dart';

class GuessHistoryListBoard extends StatelessWidget {
  const GuessHistoryListBoard({
    super.key,
    this.height = 280,
    required this.guesses,
  });

  final List<Guess> guesses;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[for (var guess in guesses) GuessCard(guess: guess)],
      ),
    );
  }
}
