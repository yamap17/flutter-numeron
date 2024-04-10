import 'package:flutter/material.dart';
import 'package:numeron/models/guess.dart';

class GuessCard extends StatelessWidget {
  const GuessCard({
    super.key,
    required this.guess,
  });

  final Guess guess;

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
              '${guess.selectedNumbers.join()}   Hits: ${guess.hits}, Blows: ${guess.blows}',
              style: const TextStyle(fontSize: 20),
            )),
      ),
    );
  }
}
