import 'package:flutter/material.dart';
import 'package:numeron/models/guess_result.dart';
import 'package:numeron/widgets/guess_result_card.dart';

class GuessResultCardListBoard extends StatelessWidget {
  const GuessResultCardListBoard({
    super.key,
    this.height = 280,
    required this.guessResults,
  });

  final List<GuessResult> guessResults;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[for (var guess in guessResults) GuessResultCard(guess: guess)],
      ),
    );
  }
}
