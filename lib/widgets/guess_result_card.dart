import 'package:flutter/material.dart';
import 'package:numeron/models/guess_result.dart';

class GuessResultCard extends StatelessWidget {
  const GuessResultCard({
    super.key,
    required this.guess,
  });

  final GuessResult guess;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      alignment: Alignment.center,
      child: Card(
        margin: const EdgeInsets.all(5),
        child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              '${guess.playerGuessNumbers.join()}   Hits: ${guess.hits}, Blows: ${guess.blows}',
              style: const TextStyle(fontSize: 20),
            )),
      ),
    );
  }
}
